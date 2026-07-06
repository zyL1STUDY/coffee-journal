# 项目背景

> 辅助文档 / 仅供参考。
>
> 本文件用于保留项目背景和产品上下文，不替代正式开发交付文档。MVP 范围、页面说明、数据模型和业务规则请以 `01_项目概览.md`、`04_页面说明.md`、`05_数据模型.md`、`12_业务规则.md` 为准。

## 产品定位

Coffee Journal 是一款 AI 咖啡日记。

它不是咖啡数据追踪器。它的核心不是统计咖啡，而是通过咖啡记录生活里的日常片段。

咖啡是入口，记忆是目的地。

核心理念：

> More than coffee. More than memories.

## MVP 目标

MVP 需要建立一个真实、可维护的移动端产品基础。

产品体验应该让记录变得快速、温暖、个人化，而不是像填写表格或 tracker。

## 核心用户痛点

- 普通记录工具过于表格化，记录成本高。
- 单纯统计咖啡缺少情绪和生活记忆。
- 用户希望快速留下当下这一杯，而不是先填写复杂字段。
- 有些用户不喜欢拍照，或当下不方便拍照，所以记录流程必须支持跳过拍照。

## 产品原则

- 记录应该轻松，而不是完成任务。
- AI 是观察者，不是聊天机器人。
- 每个页面只完成一个核心目标。
- 少一点数据，多一点生活。
- 咖啡是入口，记忆是目的地。
- 默认拍照优先，但随时可以跳过。
- 不强迫用户先选择泛咖啡类型。
- MVP 可见文案默认使用中文。

## 当前 MVP 范围

- Home / 今天
- Record Flow / 记录流程
- Photo Source / 照片来源
- Brand Record / 连锁品牌记录
- Cafe Record / 独立咖啡店记录
- Homemade Record / 自己做记录
- Journal / 咖啡记忆月历
- Coffee Memory / 咖啡记忆详情
- Profile / 我的
- 轻量 AI Summary / AI Message

## 当前不属于 MVP 的方向

- AI 聊天机器人
- 心理咨询式 AI
- 每日语录式 AI
- Apple Watch
- Achievement
- Seasonal Theme
- Coffee Sticker 收藏正式实现
- 桌面小组件正式实现

## 移动端优先原则

Coffee Journal 按照 Flutter 移动端 App 优先开发。

Chrome 可以作为开发预览工具，但界面必须模拟真实手机体验。默认预览目标是 iPhone 尺寸：390 x 844。

当前产品方向不包含桌面布局。

## 技术栈

- Flutter stable
- Dart
- Riverpod
- GoRouter
- Material 3

## 开发原则

- 架构保持简单、模块化。
- 优先可维护性，不追求 clever solution。
- 颜色、间距、字体、圆角、尺寸等视觉值集中管理。
- 在真正减少重复、提高一致性时使用复用组件。
- UI 基础阶段避免混入业务逻辑。
- 按 Sprint 增量推进。

## 当前待确认风险

- Figma `03 Final Screens` 已确认存在 9 个最终 MVP 画面，后续开发应使用 Final Screens 链接作为设计入口。
- Empty / Loading / Error 已在主文档补充产品规则；具体视觉样式仍可后续细化。
- 登录、Supabase、图片存储、AI Provider 是否进入 MVP 仍需确认。
