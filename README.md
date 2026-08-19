# Coffee Journal

Coffee Journal 是一款以咖啡为入口的 AI 日记 App MVP。

它不是咖啡摄入量追踪器，而是帮助用户快速记录一杯咖啡，并在之后通过月历和 Coffee Memory 回看日常记忆的移动端产品。

> More than coffee. More than memories.

## Demo

- Demo：待补充
- 当前状态：Flutter 移动端 MVP / Portfolio-ready prototype

## 项目介绍

Coffee Journal 面向喜欢咖啡、但不想被复杂表单打断的人。

用户可以从 Home 快速记录一杯咖啡，选择来源、补充饮品信息，并在 Journal 中通过月历回看每一天的咖啡记忆。AI 不作为聊天机器人出现，而是像轻量观察者一样，为每次记录生成一句温柔的记忆提示。

已完成的 MVP 范围：

- Home：今日问候、AI 一句话、记录入口、最近咖啡
- Record Flow：咖啡来源选择、三类记录表单、保存/编辑/删除
- Journal：月历视图、日期贴纸、多杯记录 Badge、Coffee Memory 详情
- Profile：个人信息、语言、数据与隐私、关于页面
- Widget：iOS Medium Widget preview / prototype

当前项目重点展示产品定义、AI 协作工作流、Flutter MVP 实现和基础测试覆盖。真实相机、持久化数据库、云端同步和生产 AI 接入仍属于后续迭代范围。

## 我的角色

AI 产品经理 + Flutter MVP Builder

我在这个项目中使用 AI-assisted product workflow 完成从产品定义到可运行原型的完整闭环：

- 定义产品定位和 MVP 边界
- 拆解用户流程和页面结构
- 迭代视觉方向和交互细节
- 使用 Figma 整理核心页面、组件语言和交付结构
- 将设计语言转化为 Flutter 组件和 Theme Token
- 用测试覆盖关键用户路径
- 维护开发日志和交付文档，形成可追踪的项目工作流

## AI 产品经理工作流

这个项目的重点不是只展示代码，而是展示一个 AI 产品经理如何把想法推进成可验证的 MVP。

工作流包括：

1. 产品定位：明确 Coffee Journal 不是数据追踪工具，而是日常记忆产品。
2. MVP 定义：限定 Home、Record Flow、Journal、Profile 和 Widget preview 的首版范围。
3. 用户流程：从“记录一杯”到“回看 Coffee Memory”建立完整闭环。
4. 设计迭代：围绕温暖、轻量、低打扰的方向，多轮调整 UI 语言。
5. Figma 交付：整理最终页面、组件结构和视觉规范，作为开发对齐依据。
6. AI 功能设计：将 AI 放在一句轻量观察文案中，而不是做成聊天入口。
7. 工程实现：用 Flutter / Riverpod / GoRouter 搭建可运行 MVP。
8. 验证收尾：通过 `flutter analyze`、`flutter test`、commit history 和 Release Checklist 记录阶段结果。

更完整的工作流说明见：[AI 产品经理工作流](docs/AI_Product_Workflow.md)。

MVP 验收边界见：[MVP Release Checklist](docs/MVP_Release_Checklist.md)。

项目配置、环境变量和本地存储说明见：[Project Config](docs/Project_Config.md)。

## 技术栈

- Flutter / Dart
- Figma
- Riverpod
- GoRouter
- 自定义 Theme Token 与共享 UI 组件
- WidgetKit preview / iOS Extension prototype
- flutter_test

## 本地运行

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

如需环境变量：

```bash
cp .env.example .env
```

当前 MVP 不依赖真实 API key，`.env` 可以保持为空。

## 项目状态

Coffee Journal 当前是作品集展示用 MVP 原型，已完成核心体验闭环和主要 UI polish。

下一步计划：

- 接入本地持久化数据库
- 接入真实相机 / 相册
- 接入保存时 AI Message 生成
- 验证 iOS Widget 真机体验
- 准备 TestFlight / App Store 发布材料
