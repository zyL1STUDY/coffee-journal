# Design Audit（设计审查）

## 审查依据

- 当前 Figma 文件：Coffee Journal - MVP Screens
- 当前链接节点：`110:2`
- 历史 Figma 交付记录：项目过往聊天中多次直接读取和修改同一 Figma 文件 `AdnrN3VEhAbSfHcbO62UNj`
- 审查日期：2026-07-06
- 原则：Figma 是唯一设计真源；历史聊天仅用于补充同一 Figma 文件中过往已确认的设计状态。

## 当前 Figma 可见状态

已通过 `03 Final Screens` 链接读取到完整最终页面：

- `01 Home`
- `02 Record Flow`
- `03 Photo Source`
- `04 Brand Record`
- `05 Cafe Record`
- `06 Homemade Record`
- `07 Journal`
- `08 Coffee Memory`
- `09 Profile`

说明：此前只能读取到 Cover，是因为使用了 Cover 节点链接 `110:2`。当前使用 `03 Final Screens` 节点链接 `110:5` 后，最终页面可正常读取。

## Figma 交付结构

同一 Figma 文件已整理为以下结构：

- `00 Cover`
- `01 Design System`
- `02 Components`
- `03 Final Screens`
- `04 Dev Handoff`
- `99 Archive`

其中 `03 Final Screens` 确认包含 9 个最终 MVP 画面：

| 顺序 | 最终页面 | 说明 |
|---:|---|---|
| 01 | Home | 首页 / 今天 |
| 02 | Record Flow | 记录流程起点 |
| 03 | Photo Source | 照片来源 |
| 04 | Brand Record | 连锁品牌记录 |
| 05 | Cafe Record | 独立咖啡店记录 |
| 06 | Homemade Record | 自己做记录 |
| 07 | Journal | 咖啡记忆月历 |
| 08 | Coffee Memory | 咖啡记忆详情 |
| 09 | Profile | 我的 |

## 已忽略页面

| 页面 / 区域 | 类型 | 忽略原因 |
|---|---|---|
| Record Flow V1 - Record First | Exploration / Archive | 早期“先记录”方案，已被 Photo First 方向替代。 |
| Record Flow V2 Exploration | Exploration / Archive | 记录流程探索稿，最终只保留确认后的 01-06 记录流程画面。 |
| Original App Screens Source Group | Archive | 原始页面来源组，已复制最终版本到 Final Screens。 |
| Early Design System | Archive | 早期设计系统，正式规范已整理到 Design System。 |
| Coffee Memory Working Copy | Archive | 工作副本，最终采用 `08 Coffee Memory`。 |

## 设计缺失与风险

| 分类 | 内容 | 状态 |
|---|---|---|
| 空状态 | Home、Journal、Profile 空状态已在页面说明中补充；具体视觉稿可后续细化。 | 已补充 |
| Loading | 保存、AI、图片处理 Loading 规则已在页面说明和 AI 文档中补充；具体视觉稿可后续细化。 | 已补充 |
| Error State | 图片失败、AI 失败、保存失败、记录不存在等错误规则已补充。 | 已补充 |
| 删除确认 | Coffee Memory 删除前必须二次确认；使用软删除。 | 已确认 |
| 设置页 | Settings 是否进入 MVP 未在 Final Screens 中确认。 | TODO |
| Onboarding / 登录 | 未在最终页面清单中出现。 | TODO |
