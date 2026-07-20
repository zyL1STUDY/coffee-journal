import SwiftUI
import WidgetKit

private let widgetKind = "CoffeeJournalRecentCoffeeWidget"
private let appGroupID = "group.com.coffeejournal.coffeeJournal"

struct RecentCoffeeEntry: TimelineEntry {
  let date: Date
  let name: String
  let time: String
  let aiMessage: String
}

struct RecentCoffeeProvider: TimelineProvider {
  func placeholder(in context: Context) -> RecentCoffeeEntry {
    RecentCoffeeEntry(
      date: Date(),
      name: "晨间拿铁",
      time: "08:20",
      aiMessage: "今天有点冷，热拿铁应该很舒服"
    )
  }

  func getSnapshot(in context: Context, completion: @escaping (RecentCoffeeEntry) -> Void) {
    completion(loadEntry())
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<RecentCoffeeEntry>) -> Void) {
    let entry = loadEntry()
    let nextRefresh = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
    completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
  }

  private func loadEntry() -> RecentCoffeeEntry {
    let defaults = UserDefaults(suiteName: appGroupID)
    return RecentCoffeeEntry(
      date: Date(),
      name: defaults?.string(forKey: "latestCoffeeName") ?? "晨间拿铁",
      time: defaults?.string(forKey: "latestCoffeeTime") ?? "08:20",
      aiMessage: defaults?.string(forKey: "latestCoffeeAiMessage") ?? "今天有点冷，热拿铁应该很舒服"
    )
  }
}

struct CoffeeJournalWidgetEntryView: View {
  let entry: RecentCoffeeProvider.Entry

  var body: some View {
    MediumRecentCoffeeWidget(entry: entry)
  }
}

struct MediumRecentCoffeeWidget: View {
  let entry: RecentCoffeeEntry

  var body: some View {
    GeometryReader { proxy in
      let scale = min(proxy.size.width / 329, proxy.size.height / 155)

      ZStack(alignment: .topLeading) {
        LatteGlassBackground()
          .frame(width: 275, height: 104)
          .offset(x: 40, y: 32)

        VStack(alignment: .leading, spacing: 5) {
          Text(entry.time)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(Color(red: 0.51, green: 0.42, blue: 0.35))
            .shadow(color: Color(red: 1, green: 0.97, blue: 0.93).opacity(0.2), radius: 1, y: 1)
            .lineLimit(1)

          Text(entry.name)
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(Color(red: 0.35, green: 0.27, blue: 0.21))
            .shadow(color: Color(red: 1, green: 0.97, blue: 0.93).opacity(0.2), radius: 1, y: 1)
            .lineLimit(1)

          Text(entry.aiMessage)
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(Color(red: 0.51, green: 0.42, blue: 0.35))
            .shadow(color: Color(red: 1, green: 0.97, blue: 0.93).opacity(0.2), radius: 1, y: 1)
            .lineLimit(2)
        }
        .frame(width: 168, alignment: .leading)
        .offset(x: 132, y: 44)

        AddCoffeeLink()
          .frame(width: 31, height: 31)
          .offset(x: 271, y: 44)

        CoffeeSticker(width: 110, height: 132)
          .rotationEffect(.degrees(-4))
          .offset(x: 22, y: 8)
      }
      .frame(width: 329, height: 155, alignment: .topLeading)
      .scaleEffect(scale)
      .frame(width: proxy.size.width, height: proxy.size.height)
    }
    .widgetBackground()
  }
}

struct LatteGlassBackground: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 24, style: .continuous)
      .fill(Color(red: 1, green: 0.97, blue: 0.95).opacity(0.46))
      .background(LatteMaterialBackground())
      .overlay(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white.opacity(0.20))
          .blur(radius: 14)
          .frame(width: 236, height: 22)
          .offset(x: 18, y: 7)
      }
      .overlay(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
          .fill(Color(red: 1, green: 0.96, blue: 0.91).opacity(0.15))
          .blur(radius: 20)
          .frame(width: 158, height: 72)
          .offset(x: 94, y: 19)
      }
      .overlay(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white.opacity(0.06))
          .blur(radius: 16)
          .frame(width: 132, height: 54)
          .offset(x: 106, y: 24)
      }
      .overlay(
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .stroke(Color.white.opacity(0.28), lineWidth: 1)
      )
      .shadow(color: Color(red: 0.49, green: 0.36, blue: 0.27).opacity(0.08), radius: 12, y: 4)
  }
}

struct AddCoffeeLink: View {
  var body: some View {
    Link(destination: URL(string: "coffeejournal://coffeejournal/record")!) {
      ZStack {
        Circle()
          .fill(Color.white.opacity(0.21))
          .background(AddButtonMaterialBackground())
          .overlay(Circle().stroke(Color.white.opacity(0.27), lineWidth: 1))
          .shadow(color: Color.black.opacity(0.03), radius: 5, y: 1.5)

        Image(systemName: "plus")
          .font(.system(size: 17, weight: .medium))
          .foregroundStyle(Color(red: 0.42, green: 0.31, blue: 0.24).opacity(0.8))
      }
    }
  }
}

private struct LatteMaterialBackground: View {
  var body: some View {
    if #available(iOSApplicationExtension 15.0, *) {
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(.ultraThinMaterial)
        .opacity(0.72)
    } else {
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(Color.white.opacity(0.18))
    }
  }
}

private struct AddButtonMaterialBackground: View {
  var body: some View {
    if #available(iOSApplicationExtension 15.0, *) {
      Circle().fill(.ultraThinMaterial)
    } else {
      Circle().fill(Color.white.opacity(0.18))
    }
  }
}

struct CoffeeSticker: View {
  let width: CGFloat
  let height: CGFloat

  var body: some View {
    Image("coffee_sticker")
      .resizable()
      .scaledToFit()
      .frame(width: width, height: height)
      .shadow(color: Color.black.opacity(0.10), radius: 6, y: 2)
  }
}

private extension View {
  @ViewBuilder
  func widgetBackground() -> some View {
    if #available(iOSApplicationExtension 17.0, *) {
      containerBackground(.clear, for: .widget)
    } else {
      background(Color.clear)
    }
  }
}

@main
struct CoffeeJournalWidget: Widget {
  let kind: String = widgetKind

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: RecentCoffeeProvider()) { entry in
      CoffeeJournalWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("最近一杯咖啡")
    .description("把最近添加的一杯咖啡放在桌面。")
    .supportedFamilies([.systemMedium])
  }
}
