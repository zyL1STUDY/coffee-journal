# 路线图

> 辅助文档 / 长期版本规划。
>
> 本文件保留产品迭代方向和历史 Sprint 脉络，不作为当前 MVP 开发任务清单。当前开发任务请以 `10_开发任务拆分.md` 为准。

## Sprint 01：项目基础

状态：已完成

重点：

- Flutter App 初始化
- Core 目录结构
- 集中式 Theme
- Bottom Navigation
- 基础页面
- 移动端优先预览行为

## Sprint 02：设计语言与记录流程探索

状态：已完成

重点：

- 在 Figma 中建立第一版产品设计语言。
- 保持移动端优先和 iPhone 优先。
- 优化今天、Journal、我的三个核心页面。
- 调整底部导航和 Home 页的信息层级。

## Sprint 03：记录流程产品结构

状态：已完成

重点：

- 从 Home 点击记录时，应默认引导用户捕捉咖啡时刻。
- 用户可以随时跳过拍照，直接记录。
- 比较记录流程 V1 和 V2。
- 当前优先方向是记录流程 V2：默认拍照优先。
- 使用同一个底部弹层内部切换步骤，不连续叠加多个弹层。
- 根据内容量调整底部弹层高度。
- 记录流程按照来源分支：
  - 连锁品牌
  - 独立咖啡店
  - 自己做
- 整理 Figma 文件结构，区分 App 页面、V1 和 V2。

## Sprint 04：Journal 与 Coffee Detail

状态：已完成

重点：

- 将 Journal 定义为 Coffee Memory，而不是普通 Calendar。
- 放大月历，让用户一眼看到本月喝过的咖啡。
- 用照片缩略图表达有记录的日期。
- 用数量 Badge 表达同一天多杯咖啡。
- 将统计和 AI Summary 放在月历下方，保持轻量。
- 新增 Coffee Detail 的 Bottom Sheet 状态。
- Coffee Detail 继续使用背景变暗 / 模糊感 + 底部弹层的交互语言。

## Sprint 05：Flutter MVP 交互闭环

状态：已完成 MVP A 档

重点：

- Home 使用真实当天日期，并支持首访空状态。
- Record Flow 支持保存一杯咖啡并刷新首页。
- Journal 接入当前记录数据，不再只展示静态演示月历。
- Coffee Memory 展示真实记录内容，并支持删除二次确认。
- Profile 补齐数据与隐私、隐私政策、用户协议等交付入口。
- GitHub README 和文档索引调整为对外展示友好的结构。
- 桌面小组件作为 iOS Medium Widget preview / prototype 保留，不声明完整发布能力。

## 后续方向

后续可能推进：

- 接入本地持久化，替换当前内存 Repository。
- 接入真实相机 / 相册选择和权限失败状态。
- 保存时生成 AI Message，并固定写入 Coffee Record。
- 完成 iOS Widget 真机 / 模拟器验证。
- 准备 TestFlight / App Store 发布材料。
- 根据真实使用反馈继续优化记录流程和 Coffee Memory。
