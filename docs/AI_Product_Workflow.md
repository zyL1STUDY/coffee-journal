# AI 产品经理工作流

Coffee Journal 是一个用 AI-assisted workflow 推进的 Flutter MVP 项目。这个文档用于说明我如何以 AI 产品经理的方式，从产品想法推进到可运行原型。

## 1. 产品定位

Coffee Journal 的定位不是咖啡摄入量追踪器，而是以咖啡为入口的日常记忆产品。

核心判断：

- 用户记录的不是数据，而是一杯咖啡背后的日常片段。
- 记录流程应该轻，不应该像填写任务。
- AI 应该像观察者，而不是聊天机器人。

## 2. MVP 范围

首版 MVP 聚焦一个完整闭环：

1. 用户从 Home 进入记录流程。
2. 用户快速保存一杯咖啡。
3. 记录出现在 Home 最近咖啡中。
4. 用户在 Journal 月历中回看记录。
5. 用户打开 Coffee Memory 查看这杯咖啡的记忆详情。

当前已完成模块：

- Home
- Record Flow
- Journal
- Coffee Memory
- Profile
- iOS Medium Widget preview / prototype

## 3. Figma 设计交付

我使用 Figma 进行核心页面和视觉语言整理，包括：

- Home / 今天
- Record Flow
- Journal
- Coffee Memory
- Profile
- Desktop Widget preview

设计过程重点不是做静态 UI，而是持续验证信息层级、用户路径和情绪表达。

## 4. AI 协作方式

AI 在这个项目中承担三个角色：

- Product sparring partner：帮助澄清产品定位、MVP 边界和用户流程。
- Design reviewer：对页面层级、交互反馈、文案语气和视觉一致性进行迭代。
- Coding assistant：将确认后的产品和设计决策实现为 Flutter 代码。

我的工作重点是判断方向、筛选方案、确认取舍，并持续把 AI 输出收敛为可交付的产品结果。

## 5. 设计决策示例

关键产品和设计决策：

- 三个一级入口：Home、Journal、Profile。
- Camera 不作为一级 Tab，记录入口留在 Home。
- AI 只做一句轻量提示，不做聊天入口。
- Journal 不是数据报表，而是咖啡记忆月历。
- Coffee Memory 使用 Bottom Sheet，保持轻量回看体验。
- UI 方向从普通白底卡片调整为低饱和纸感背景 + 轻量 Liquid Glass。

## 6. 工程实现

技术实现侧重点：

- Flutter / Dart 构建移动端 MVP。
- Riverpod 管理记录状态。
- GoRouter 管理页面与记录流程路由。
- 自定义 Theme Token 和共享组件，避免依赖默认 Material 视觉。
- Widget Tests 覆盖核心路径。

## 7. 验证与交付

每个阶段收尾时，我会整理：

- 当前完成范围
- 修改原因
- 测试结果
- Git commit
- 后续边界

当前验证命令：

```bash
flutter analyze
flutter test
```

这个项目展示的是一个 AI 产品经理如何把模糊想法转化为清晰 MVP，并进一步推进到可运行、可展示、可迭代的产品原型。
