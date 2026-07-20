# Coffee Journal

Coffee Journal 是一款 Flutter 移动端 App MVP。它不是咖啡摄入量追踪器，而是一款以咖啡为入口的 AI 咖啡日记：记录每一杯咖啡，也记录日常生活里的轻量记忆。

> More than coffee. More than memories.

## 项目定位

Coffee Journal 面向喜欢咖啡、但不想被复杂表单打断的人。MVP 的目标是验证一条核心体验：用户可以快速留下今天这一杯，并在之后通过月历和 Coffee Memory 回看这段日常记忆。

产品原则：

- 记录应该轻松，而不是完成任务。
- AI 是轻量观察者，不是聊天机器人。
- 咖啡是入口，记忆是目的地。
- 移动端优先，默认以 iPhone 尺寸设计和验证。

## MVP 已完成内容

| 模块 | 当前状态 |
|---|---|
| Home / 今天 | 动态日期、Today Card、记录入口、最近咖啡、首访空状态 |
| Record Flow | 来源选择、连锁品牌 / 独立咖啡店 / 自己做三类记录表单、可选照片入口、保存后刷新首页 |
| Journal | 当月咖啡月历、日期贴纸、多杯 Badge、统计摘要、空状态文案 |
| Coffee Memory | Bottom Sheet 详情，展示真实记录内容、AI Message、备注、编辑入口、删除二次确认 |
| Profile / 我的 | 个人信息、语言、数据与隐私、关于页面、静态隐私政策 / 用户协议 |
| Desktop Widget | iOS Medium Widget preview / prototype，展示最近一杯咖啡；不作为完整发布能力声明 |

## 当前边界

这个仓库展示的是 **MVP 交互版 / Portfolio-ready work in progress**。当前重点是产品结构、体验闭环、UI 还原和工程组织。

尚未作为完整上线能力声明的内容：

- 本地持久化数据库仍待接入；当前记录仓库为内存状态管理。
- 真实相机 / 相册流程仍待接入；当前照片入口为 MVP 预留交互。
- OpenAI / Supabase / 云端图片存储尚未接入生产链路。
- iOS Widget 已有 preview / extension 基础，但还需要真机或模拟器完整验证。
- App Store / TestFlight 发布准备仍在后续 Roadmap。

## 技术栈

- Flutter / Dart
- Riverpod
- GoRouter
- 自定义 Theme Token 与组件
- WidgetKit preview / iOS Extension prototype
- flutter_test

已预留但未完成生产接入：

- Isar 本地数据库
- image_picker
- OpenAI Responses API
- Supabase / Storage

## 项目结构

```text
lib/
  app/                    App 入口
  core/                   路由、主题、配置、常量
  features/
    home/                 今天页
    record/               记录咖啡流程
    journal/              月历与 Coffee Memory
    profile/              我的与设置页面
    widgets/              桌面组件同步支持
  shared/                 共享 UI 组件

docs/                     产品、设计、技术与交付文档
test/                     核心 Widget 测试
ios/CoffeeJournalWidget/  iOS Widget preview / prototype
```

## 交付文档

建议从 [docs/README.md](docs/README.md) 开始阅读。核心文档：

- [01 项目概览](docs/01_项目概览.md)
- [02 MVP 功能清单](docs/02_MVP功能清单.md)
- [03 用户流程](docs/03_用户流程.md)
- [04 页面说明](docs/04_页面说明.md)
- [05 数据模型](docs/05_数据模型.md)
- [07 设计规范](docs/07_设计规范.md)
- [08 AI 功能说明](docs/08_AI功能说明.md)
- [12 业务规则](docs/12_业务规则.md)
- [MVP Release Checklist](docs/MVP_Release_Checklist.md)

## 本地运行

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

如果需要环境变量：

```bash
cp .env.example .env
```

MVP 当前不依赖真实 AI 或 Supabase key，`.env` 可以保持为空或使用占位值。

## 当前验证

当前核心 Widget 测试覆盖：

- Home 首访空状态
- Profile 与二级页面
- Record Flow 保存与取消
- 照片入口预览
- 最近咖啡删除
- Journal 打开 Coffee Memory
- Coffee Memory 覆盖底部导航

最新本地检查：

```bash
flutter analyze
flutter test
```

## Roadmap

下一阶段重点：

- 接入本地持久化，替换内存 Mock Repository。
- 接入真实相机 / 相册选择。
- 接入保存时 AI Message 生成与失败兜底。
- 完成 iOS Widget 真机 / 模拟器验证。
- 准备 TestFlight / App Store 发布资料。
