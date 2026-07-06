# Coffee Journal

Coffee Journal 是一款 Flutter 移动端 App MVP。

它不是咖啡数据追踪器，而是一款以咖啡为入口的 AI 咖啡日记：记录每一杯咖啡，也记录日常生活里的轻量记忆。

核心理念：

> More than coffee. More than memories.

## 当前状态

当前项目已完成 Milestone 0：Flutter 工程初始化和 MVP 开发交付文档。

已确认的产品方向：

- 移动端优先，默认按照 iPhone 尺寸设计。
- 三个底部导航：今天 / Journal / 我的。
- Home 是记录入口。
- Record Flow 默认拍照优先，但允许跳过拍照。
- Journal 只负责浏览和回顾咖啡记忆，不放新增入口。
- Coffee Detail 已调整为 Coffee Memory。
- AI 是轻量观察者，不是聊天机器人。

## 技术栈

- Flutter stable
- Dart
- Riverpod
- GoRouter
- Isar Database
- image_picker
- flutter_dotenv
- Material 3

## 本地启动

1. 复制环境变量示例：

```bash
cp .env.example .env
```

2. 按需填写 `.env`。MVP 当前不接入真实 AI 或 Supabase，真实 key 可以先留空。

3. 安装依赖：

```bash
flutter pub get
```

4. 运行检查：

```bash
flutter analyze
flutter test
```

5. 启动项目：

```bash
flutter run
```

当前 Milestone 0 只包含基础工程壳、三 Tab placeholder、Theme Token、GoRouter、Riverpod ProviderScope、环境变量示例和 Coffee Record 基础字段模型。

## 文档入口

正式开发交付文档位于 `docs/`，建议优先阅读：

- `00_Design_Audit.md`
- `01_项目概览.md`
- `02_MVP功能清单.md`
- `03_用户流程.md`
- `04_页面说明.md`
- `05_数据模型.md`
- `06_UI组件清单.md`
- `07_设计规范.md`
- `08_AI功能说明.md`
- `09_技术建议.md`
- `10_开发任务拆分.md`
- `11_待确认事项.md`
- `12_业务规则.md`

辅助历史资料：

- `13_历史聊天记录摘要.md`
- `PROJECT_CONTEXT.md`
- `Roadmap.md`
- `Sprint_Log.md`
- `UI_Guidelines.md`

## 当前待确认

- 已通过 `03 Final Screens` 链接确认 Figma 中存在 9 个最终 MVP 画面。
- Empty / Loading / Error 的具体视觉样式仍可后续细化；删除确认规则已在业务规则中确认。
- MVP 第一版采用匿名本地模式；AI Provider 已锁定为 OpenAI Responses API；Supabase 和云端图片存储为 Future 同步方案。
