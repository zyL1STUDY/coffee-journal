# MVP Release Checklist

更新时间：2026-07-15

## 交付定位

Coffee Journal 当前版本定位为：

> MVP 交互版 / Portfolio-ready work in progress

它用于展示产品定义、核心用户流程、移动端 UI 还原、Flutter 工程组织和 MVP 验收意识。当前版本可以作为简历项目展示，但不声明已经具备完整 App Store 发布能力。

## 已完成

| 范围 | 状态 | 说明 |
|---|---|---|
| Home / 今天 | 已完成 MVP | 动态日期、Today Card、记录入口、最近咖啡、空状态 |
| Record Flow | 已完成 MVP | 来源选择、三类记录表单、保存后刷新首页 |
| Photo Entry | MVP 预留 | 当前为添加照片预览交互，真实系统相机 / 相册待接入 |
| Journal | 已完成 MVP | 当月记录月历、贴纸、Badge、统计、Summary、空状态 |
| Coffee Memory | 已完成 MVP | 展示真实记录、AI Message、备注、编辑入口、删除二次确认 |
| Profile | 已完成 MVP | 个人信息、语言、数据与隐私、关于、静态政策页面 |
| Desktop Widget | Preview / Prototype | iOS Medium Widget preview 与基础 extension，不声明完整发布能力 |
| Widget Tests | 已覆盖核心路径 | Home、Profile、Record、Photo Entry、Journal、Coffee Memory |

## 当前边界

| 项目 | 当前状态 | 后续计划 |
|---|---|---|
| 本地持久化 | 暂为内存 Repository | 接入 Isar 或其他本地数据库 |
| 相机 / 相册 | 已预留入口 | 接入 image_picker 与权限失败状态 |
| AI Message | 当前使用兜底文案 | 接入 OpenAI Responses API，保存时生成并固定 |
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

1. 接入本地持久化，替换内存状态管理。
2. 接入真实拍照 / 相册选择。
3. 接入 AI Message 生成与失败兜底。
4. 完成 iOS Widget 真机 / 模拟器验证。
5. 准备 TestFlight 或 App Store 发布材料。
