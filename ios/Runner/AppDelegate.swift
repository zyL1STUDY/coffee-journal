import Flutter
import UIKit
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let appGroupID = "group.com.coffeejournal.coffeeJournal"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(
      name: "coffee_journal/widget_sync",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "syncLatestCoffee" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.syncLatestCoffee(call.arguments)
      result(nil)
    }
  }

  private func syncLatestCoffee(_ arguments: Any?) {
    let defaults = UserDefaults(suiteName: appGroupID)
    let values = arguments as? [String: Any]
    defaults?.set(values?["name"] as? String ?? "晨间拿铁", forKey: "latestCoffeeName")
    defaults?.set(values?["time"] as? String ?? "08:20", forKey: "latestCoffeeTime")
    defaults?.set(
      values?["aiMessage"] as? String ?? "今天有点冷，热拿铁应该很舒服",
      forKey: "latestCoffeeAiMessage"
    )
    defaults?.synchronize()

    if #available(iOS 14.0, *) {
      WidgetCenter.shared.reloadAllTimelines()
    }
  }
}
