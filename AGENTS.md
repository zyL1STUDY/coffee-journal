# Coffee Journal Project Instructions

## Pixel Perfect UI Workflow

Coffee Journal UI 必须按照 Pixel Perfect 的标准开发。页面开发时，Figma 是布局和视觉尺寸的唯一依据，不要根据 Figma 自行理解布局。

开发每一个页面之前，必须先分析 Figma，并输出：

```text
UI Measurement Report
```

报告至少包括：

- Header
- Padding
- Card
- Radius
- Typography
- Spacing
- Button
- Bottom Navigation

逐项测量并确认以下内容以后，才能开始编码：

- Padding
- Margin
- Gap
- Border Radius
- Typography
- Font Weight
- Font Size
- Line Height
- Letter Spacing
- Card Height
- Component Width
- Safe Area
- Icon Size

执行要求：

- 不要直接开始写 Flutter。
- 不要为了方便使用 Flutter 默认样式。
- 不要使用 Material 默认视觉。
- 如果 Flutter 默认 Widget 与 Figma 不一致，请自定义 Widget。
- Coffee Journal 的 UI 优先级高于 Flutter 默认组件。
- 使用已有 Theme Token；如果 Figma 需要的新值尚未 token 化，先补充 token，再用于组件。
- 编码前先确认尺寸，编码后用页面截图或运行效果说明对照 Figma。

## Daily Development Log Reminder

在 Coffee Journal 项目中，当用户完成当天开发、提交代码、推送 GitHub，或说“今天结束 / 收工 / 先到这里 / done for today”时，主动询问：

> 今天是否需要更新 `docs/Sprint_Log.md`？

如果用户确认需要，帮助更新 `docs/Sprint_Log.md`，日志内容使用简体中文，默认保持简短，主要包含：

1. 日期
2. 今日完成内容
3. 必要时说明修改原因
4. 新增或修改的 commit / 是否已推送

执行要求：

- 不要每完成一个小功能都更新 `docs/Sprint_Log.md`。
- 只在一天结束时询问是否更新。
- 未经用户确认不要自动修改 `docs/Sprint_Log.md`。
- 用户希望项目之后可放在简历中展示完整工作流；每次当天工作完成后，默认先运行检查，再整理 commit，并推送到 GitHub。
- `docs/Roadmap.md` 只在 Milestone 完成或版本规划变化时提醒更新。
- `docs/01_项目概览.md` 到 `docs/12_业务规则.md` 产品文档已经冻结，除非用户明确要求，不要主动修改。
- 每次更新日志前，先读取当天 Git commit 历史和当前变更摘要。
- 日志使用简体中文。
