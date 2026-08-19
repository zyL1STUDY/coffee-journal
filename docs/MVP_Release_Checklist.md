# MVP Release Checklist

更新时间：2026-08-19

## 交付定位

Coffee Journal 当前版本定位为：

> MVP 交互版 / Portfolio-ready work in progress

它用于展示产品定义、核心用户流程、移动端 UI 还原、Flutter 工程组织和 MVP 验收意识。当前版本可以作为简历项目展示，但不声明已经具备完整 App Store 发布能力。

## 已完成

| 范围 | 状态 | 说明 |
|---|---|---|
| Home / 今天 | 已完成 MVP | 动态日期、Today Card、记录入口、最近咖啡、空状态 |
| Record Flow | 已完成 MVP | 来源选择、三类记录表单、保存后刷新首页 |
| Photo Entry | 已完成 MVP 基础 | 已接入相册选择、照片预览和本地照片地址保存；真实拍照入口和权限失败状态待补齐 |
| Journal | 已完成 MVP | 当月记录月历、贴纸、Badge、统计、Summary、空状态 |
| Coffee Memory | 已完成 MVP | 展示真实记录、AI Message、备注、编辑入口、删除二次确认 |
| Profile | 已完成 MVP | 个人信息、语言、数据与隐私、关于、静态政策页面 |
| Desktop Widget | Preview / Prototype | iOS Medium Widget preview 与基础 extension，不声明完整发布能力 |
| Local Persistence | 已完成 MVP 基础 | iOS / 桌面端使用本地文档目录，Web 预览使用 localStorage |
| Photo Cutout Pipeline | 已完成 MVP 预留 | 已有 `REMOVE_BG_API_KEY` 配置、后台处理状态和失败兜底 |
| Widget Tests | 已覆盖核心路径 | Home、Profile、Record、Photo Entry、Journal、Coffee Memory、本地持久化、抠图成功路径 |

## 当前边界

| 项目 | 当前状态 | 后续计划 |
|---|---|---|
| 本地持久化 | 已有轻量本地存储 | 后续可迁移到 Isar / SQLite / Supabase，不影响现有 UI |
| 相机 / 相册 | 相册已接入，拍照待接入 | 补齐拍照入口、权限失败状态和真实设备验证 |
| 照片抠图 | 已有 remove.bg 预留管线 | 配置真实 API key 后验证成功 / 失败 / 无 key 三种状态 |
| AI Message | 当前使用兜底文案 | 接入 OpenAI Responses API，保存时生成并固定；失败不阻塞保存 |
| 云同步 | 未接入 | Future：Supabase / Storage |
| 桌面组件 | preview / prototype | 完成 App Group、URL Scheme、真机 / 模拟器验证 |
| 发布准备 | 未完成 | 准备 App Icon、Launch Screen、TestFlight、商店截图 |

## 验收口径

MVP 验收时优先检查：

1. 用户能从 Home 进入记录流程并保存一杯咖啡。
2. 保存后 Home 最近咖啡刷新。
3. Journal 能看到当月记录，并打开 Coffee Memory。
4. Coffee Memory 展示保存的真实内容。
5. Coffee Memory 删除前有二次确认，删除后记录从 Home / Journal 中移除。
6. 首访无记录时不显示假数据。
7. GitHub README 能清楚说明项目做了什么、当前完成到哪里、下一步计划是什么。

## 当前验证命令

```bash
flutter analyze
flutter test
```

## 下一阶段建议

1. 更新过期任务文档，让项目状态与代码保持一致。
2. 补齐真实拍照入口、相册 / 相机权限失败状态和设备验证。
3. 接入 AI Message 生成，并保持失败不阻塞保存。
4. 验证 remove.bg 抠图管线和 iOS Widget 真机 / 模拟器体验。
5. 准备 App Icon、Launch Screen、Demo 录屏、TestFlight 或 App Store 发布材料。
