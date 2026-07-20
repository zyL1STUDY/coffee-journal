# Sprint 日志

> 辅助文档 / 实际开发日志。
>
> 本文件只记录已经发生的设计、产品和开发过程，不作为未来开发计划。当前 MVP 开发计划请以 `10_开发任务拆分.md` 为准。

## Sprint 01

状态：已完成

已完成：

- Flutter 项目初始化
- 基础目录结构
- 主题
- 底部导航
- 四个基础页面
- 移动端优先预览修正

备注：

- Coffee Journal 的开发方向是 Flutter 移动端 App 优先。
- Chrome 只是开发预览工具。
- 本阶段没有实现业务逻辑、登录、Supabase、AI、相机、数据库模型。

## Sprint 02

状态：已完成

已完成：

- 在 Figma 中建立 Coffee Journal 第一版设计语言。
- 创建核心移动端页面：今天、Journal、我的。
- 将底部导航调整为三个产品区域。
- 优化 Home 页面信息层级：
  - Header
  - Today Card
  - 记录入口
  - 最近记录
  - 底部导航
- 调整底部导航图标，去掉文字标签，降低视觉拥挤。
- 统一当前 Figma 设计默认中文文案。

产品决策：

- Coffee Journal 不是咖啡数据追踪器。
- 咖啡是入口，记忆是目的地。
- 首页应该温暖、安静、轻量，不制造任务感。
- AI 不作为独立模块出现，而是轻量融入 Today Card。

## Sprint 03

状态：已完成

日期：2026-07-01

已完成：

- 重新讨论并调整记录流程方向。
- 明确记录流程从 Home 点击「记录这一杯」后，应该默认进入拍照路径。
- 确认新的产品原则：默认拍照优先，但随时可以跳过。
- 探索记录流程 V1：先记录 / 来源优先。
- 探索记录流程 V2：默认拍照优先。
- 设计记录流程 V2 的完整状态：
  - 开始
  - 照片来源
  - 来源选择
  - 连锁品牌
  - 独立咖啡店
  - 自己做
- 根据内容量调整底部弹层高度：
  - 短内容使用短弹层
  - 来源选择使用中等弹层
  - 完整记录表单使用高弹层
- 确认记录流程使用同一个底部弹层内部切换步骤，而不是连续叠加多个弹层。
- 确认三个来源分支：
  - 连锁品牌：先选择品牌，再补充可选饮品名。
  - 独立咖啡店：先选择或创建咖啡店，再补充可选饮品名。
  - 自己做：先选择制作方式，再补充可选饮品名。
- 确认连锁品牌饮品应记录真实饮品名，例如「红酒美式」，不强迫用户先选择「美式」这类泛分类。
- 整理 Figma 文件结构：
  - 设计系统
  - App 页面
  - 记录流程 V1 - 先记录
  - 记录流程 V2 - 默认拍照优先

产品决策：

- 记录流程应该支持拍照优先，因为用户更愿意先留下这一刻，而不是先填写多个选项。
- 照片是默认入口，但不是必填项。
- 连锁品牌饮品应记录用户真实记得的饮品名，例如「红酒美式」，而不是强迫用户先选择「美式」这类泛分类。
- MVP 阶段可以把饮品分类放在系统背后，不作为用户必填项。

## Sprint 04

状态：已完成

日期：2026-07-03

已完成：

- 继续完善 Figma 中的 Journal 页面。
- 将 Journal 从普通日历调整为 Coffee Memory 页面。
- 放大月历区域，让月历成为页面视觉中心。
- 保留传统月历认知：
  - 月份
  - 星期
  - 日期
- 删除原来的粉色圆点表达。
- 改为用咖啡照片缩略图表示当天有记录。
- 为多杯记录日期增加数量 Badge。
- 将本月统计放到月历下方，并降低视觉重量：
  - 本月咖啡
  - 去过店铺
  - 连续记录
- 将 AI 保留为一句轻量 Summary，不再做大卡片。
- 新增 Coffee Detail 设计状态。
- Coffee Detail 采用背景变暗 / 模糊感 + Bottom Sheet。
- Coffee Detail 使用用户提供的咖啡照片作为示意图。
- Coffee Detail 包含：
  - 大照片
  - 饮品名称
  - 来源
  - 时间
  - AI Summary
  - 备注
  - 编辑
  - 删除

产品决策：

- Journal 的核心不是展示数据，而是让用户一眼看到这个月的咖啡记忆。
- 有照片的日期优先显示照片缩略图，比粉色圆点更有记忆感。
- Coffee Detail 不跳转新页面，继续使用 Bottom Sheet，保持与记录流程一致的交互语言。
- App 内的可见文案继续默认使用中文。

## Sprint 05

状态：已完成

日期：2026-07-06

已完成：

- 根据 Figma 和历史聊天记录整理开发交付文档。
- 新增 MVP 开发交付包：
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
- 新增 `13_历史聊天记录摘要.md`，用于保留历史确认信息。
- 同步更新 `README.md` 和 `PROJECT_CONTEXT.md`。

产品决策：

- 交付文档默认使用中文。
- 正式交付文档保持简洁，但不遗漏核心产品判断。
- 用户不喜欢或不方便拍照时，记录流程必须允许跳过拍照。
- 已通过 `03 Final Screens` 链接确认 Figma 中存在 9 个最终 MVP 画面；后续读取应使用 Final Screens 或具体画面链接。

## 2026-07-08 Daily Development Log

日期：2026-07-08

今日完成内容：

- 完成 Milestone 1「导航 + Home 基础 UI」开发，并提交基础版本。
- 基于 Figma Final 和后续 Review，对 Home 页面做 UI Polish：
  - 调整 Typography Token 到 Apple / PingFang 轻量方向。
  - 优化 Today Card、AI 提示文案、Recent Coffee 卡片层级。
  - 将 Recent Coffee 的咖啡图调整为 Sticker 风格，包含白边、轻微阴影和凸出卡片的视觉表现。
  - 修复底部导航图案不显示的问题。
- 为 Home 的 Recent Coffee 增加左滑操作：
  - 支持编辑。
  - 支持删除。
  - 修复删除后下一张卡片错误继承左滑状态的问题。
- 进入 Milestone 2「Record Flow」并完成记录流程基础闭环：
  - Home 点击「记录一杯」后直接进入咖啡来源选择。
  - 支持连锁品牌、独立咖啡店、自己做三种来源。
  - 三个来源进入统一详情页结构。
  - 品牌 / 来源未选择时，保存按钮禁用。
  - 使用 Mock Repository 保存记录，保存后返回 Home。
- 调整 Record Flow 的照片逻辑：
  - 初始不预留照片高度。
  - 点击「添加照片」后，在详情页标题下方展示 Sticker 预览。
  - Sticker 预览风格与 Home Recent Coffee 保持一致。
- 优化 Record Flow 退出逻辑：
  - 增加右上角 `×` 取消入口。
  - 空记录直接退出。
  - 已填写内容时弹出轻量确认。
  - 将 `×` 关闭改为 bottom sheet dismiss：向下滑动退出，背景 blur 同步淡出。
- 更新并扩展 Widget Tests，覆盖保存、禁用按钮、照片预览、取消确认、左滑删除等关键路径。
- 已运行并通过：
  - `flutter analyze`
  - `flutter test`

新增或修改的 commit：

- `14cdef3 feat: build navigation and home foundation`
- 当前还有未提交改动，主要集中在 Home UI Polish、Record Flow foundation、Record Flow 取消 / dismiss 动效、测试覆盖、项目长期工作规则。

遇到的问题：

- 底部导航图案一度未显示。
- Recent Coffee Sticker 放大后曾遮挡标题和其他卡片内容。
- 删除第一条 Recent Coffee 后，下一条卡片错误保留左滑状态。
- Record Flow 初版步骤过多，用户从拍照到详情页需要经过多个中转页面。
- 详情页照片展示逻辑一度存在重复入口或不符合用户预期。
- `×` 取消最初表现为普通页面切换，视觉上像左滑返回，不符合 bottom sheet 的空间逻辑。
- 新启动预览端口前，浏览器曾显示旧版本页面，导致新加的 `×` 看起来没有出现。

已解决的问题：

- 修复底部导航图案显示。
- 调整 Recent Coffee Sticker 尺寸、位置和卡片间距，避免遮挡文字和其他卡片。
- 修复左滑状态在删除后错误继承的问题。
- 将 Record Flow 收敛为：Home → 来源选择 → 详情页 → 保存 → Home。
- 确认照片逻辑为：未添加时不占位，添加后在顶部展示 Sticker 预览。
- 增加取消安全出口，并实现 bottom sheet 向下 dismiss。
- 通过 `flutter analyze` 和 `flutter test` 验证当前改动。

未解决问题：

- Record Flow 目前仍使用 Mock Data，尚未接入真实数据库、相机、相册、AI 或 Supabase。
- 当前 Sticker 仍为 mock 图片，真实拍照 / 相册后的抠图流程尚未实现。
- Record Flow UI 还需要继续对照 Figma Final 做 Pixel Perfect 细调。
- 当前改动尚未提交 Git，需要 Review 后再提交 Milestone 2 相关 commit。

明日计划：

- Review 当前 Record Flow 的视觉和动效。
- 继续打磨来源选择页与详情页的 spacing、typography、button、safe area。
- 确认照片入口未来接入真实拍照 / 相册时的交互状态。
- Review 通过后再提交 Record Flow foundation commit。

当前 Milestone 状态：

- Milestone 1：导航 + Home 基础 UI，已完成并已提交。
- Milestone 1.5：Home UI Polish，已基本完成，等待最终视觉确认。
- Milestone 2：Record Flow foundation，核心闭环已完成，当前处于 Review / Polish 阶段，尚未提交。

## 2026-07-10 Daily Development Log

日期：2026-07-10

今日完成内容：

- 开始并完成 Milestone 3「Journal 基础体验」开发：
  - 实现 Latte Glass Calendar。
  - 实现月份 / 日期 / 星期标题展示。
  - 使用 Coffee Sticker 标记有记录的日期。
  - 支持多杯记录 Badge。
  - 点击有记录日期打开 Coffee Memory Mock。
- 根据 Review 继续打磨 Journal：
  - 缩短日历日期上下间距，避免日历过长。
  - 放大日历 Coffee Sticker，并覆盖在日期数字上。
  - 增加咖啡贴纸掉落出现效果。
  - 调整 Coffee Memory 排版、按钮重量、关闭入口和页面高度。
  - 修复切换到 Home / Profile 后返回 Journal 仍停留在详情页的问题。
  - 修复切换 Tab 时 Coffee Memory 退场动画可见的问题。
  - 将 Journal 顶部月份区域改为左右并列的月份 / 年份月份 Mock 布局。
- 新增可复用视觉组件：
  - `LatteGlassCard` 用于 Journal Calendar 的 Latte Glass 卡片。
  - `AiCandyGlassCard` 用于 AI 提示的糖果毛玻璃质感。
- 将 Home 页 AI 小提示模块改为糖果毛玻璃形式，并多次压缩高度，使它更像轻提示而不是大卡片。
- 调整 Record Flow 背景模糊：
  - 使用真实 Home 页面作为背景，而不是骨架占位。
  - 保持背景模糊后仍能看到内容层次。
- 补充 Widget Tests：
  - 覆盖 Journal Coffee Memory 打开。
  - 覆盖离开 Journal 后 Coffee Memory 自动关闭。
- 已运行并通过：
  - `flutter analyze`
  - `flutter test`

修改原因：

- Journal 的核心体验需要让用户一眼看到本月咖啡记忆，并能快速打开 Coffee Memory。
- Coffee Sticker 比矩形缩略图更符合当前 Coffee Journal 的温暖、轻量、成就感方向。
- AI 提示需要在 Home 与 Coffee Memory 中保持一致的视觉语言。
- Record Flow 与 Coffee Memory 的背景模糊需要保持统一，同时不能让背景内容完全消失。

新增或修改的 commit：

- `feat: build journal foundation and polish glass UI`（本次收尾提交，准备推送 GitHub）

当前 Milestone 状态：

- Milestone 1：导航 + Home 基础 UI，已完成并已提交。
- Milestone 2：Record Flow foundation，已完成并已提交。
- Milestone 3：Journal 基础体验，已完成基础体验并进入 Review / Polish 阶段。

## 2026-07-13 Daily Development Log

日期：2026-07-13

今日完成内容：

- 完善 Profile 主页面：
  - 去掉 Profile Header，保留 Coffee Journal 品牌区域。
  - 调整菜单顺序为个人信息、语言、桌面小组件、数据与隐私、关于 Coffee Journal。
  - 删除 Sticker 收藏入口和主页面 Coming Soon 文案。
  - 保持 Latte Glass 风格，并补充底部版本号。
- 新增 Profile 5 个二级页面：
  - 个人信息：默认咖啡头像、昵称、加入时间、累计记录杯数、连续记录天数。
  - 语言：简体中文当前选中，English 标记 Coming Soon。
  - 桌面小组件：Small / Medium Widget 预览和「如何添加到桌面」入口。
  - 数据与隐私：自动备份、导出数据、隐私政策、用户协议。
  - 关于 Coffee Journal：Logo、Slogan、版本、Designed in Australia 和感谢文案。
- 统一优化 Profile 二级页面视觉：
  - 每个二级页面收敛为 1 个主卡片，减少页面碎片感。
  - 统一返回按钮、标题字号、左右边距、卡片圆角和分隔线颜色。
  - 弱化昵称输入框和自动备份开关视觉。
  - 将加入时间格式调整为 `2026.06`。
- 一并提交 Journal 的少量视觉调整，使当前 Journal 与 Profile 的 Latte Glass 风格更统一。
- 补充 Widget Tests，覆盖 Profile 主菜单和二级页面入口。
- 已运行并通过：
  - `flutter analyze`
  - `flutter test`

修改原因：

- Profile 是 MVP 中承载个人设置、偏好和产品信息的主要入口，需要从占位页完善为可展示的真实页面。
- 二级页面初版存在「一个框一个框」的问题，本次统一收敛为单主卡片布局，让视觉更简洁、更像同一套设计系统。

新增或修改的 commit：

- 本次准备提交：`feat: polish profile pages`

当前状态：

- Profile 主页面和 5 个二级页面已完成 MVP 静态体验。
- 当前仍未接入账号登录、真实同步、数据导出、隐私政策详情页等非 MVP 功能。

## 2026-07-15 Daily Development Log

日期：2026-07-15

今日完成内容：

- 继续完善桌面小组件体验，并将范围收敛到 Medium Widget 为主。
- 基于 Figma 最终版开发 Coffee Journal Medium Widget：
  - 左侧 Coffee Sticker 悬浮在卡片上方。
  - 右侧展示最近一杯咖啡的时间、名称和 Home 同源 AI 一句话。
  - 保留右上角 `+` 按钮，点击后进入 Record Flow。
  - 删除 Small Widget 展示，避免 MVP 中出现质量不足的组件形态。
- 多轮调整 Widget 视觉方向：
  - 从普通卡片调整为 Sticker + Card 语言。
  - 探索 Latte Liquid Glass 材质，并最终保留温暖、轻量、可读性更稳定的版本。
  - 字体统一回深咖色体系，不使用白色字体。
  - 加号按钮降低视觉重量。
  - AI 文案区域加宽，减少不必要换行。
  - Sticker 改回 Home 页面同款咖啡贴纸，并修复矩形阴影导致的模糊底问题。
  - Sticker 放大、轻微倾斜，并增加更粗的纯白贴纸边，使其更像日历贴纸。
- 新增 iOS Widget Extension 基础实现：
  - 支持 `.systemMedium` 桌面组件。
  - 从 App Group 读取最近咖啡名称、时间和 AI 文案。
  - 通过 URL Scheme 预留从 Widget `+` 按钮进入记录流程。
- 同步 Record Repository 写入 Widget 所需的最近咖啡数据。
- 抽出 Home 与 Widget 共用的 AI 一句话文案常量，保持 Home 与 Widget 内容一致。
- 补充 / 调整 Widget Tests，继续覆盖 Home、Record、Journal、Profile 关键路径。
- 已运行并通过：
  - `flutter analyze`
  - `flutter test`

修改原因：

- MVP 进入收尾阶段，需要让 Profile 中的「桌面小组件」不再只是占位，而是能展示 Coffee Journal 记忆感和产品质感的真实入口。
- Widget 的目标不是信息密度，而是把最近一杯咖啡变成温暖、轻量、可放在桌面的视觉记忆。
- Small Widget 当前视觉表现不稳定，先从 MVP 展示中移除，把质量集中在 Medium Widget。

新增或修改的 commit：

- 今日没有新增 commit。
- 当前改动尚未提交、尚未推送，主要集中在桌面 Widget、iOS Widget Extension、Widget 数据同步和测试覆盖。

验证结果：

- `flutter analyze`：通过。
- `flutter test`：通过，11 个测试全部通过。
- iOS Widget 原生编译尚未在当前环境验证；当前环境找不到 `xcodebuild / simctl`。

当前 MVP 状态：

- Home、Record Flow、Journal、Profile 与桌面组件入口已基本完成 MVP 体验。
- 后续仍需要继续做细节视觉优化、真实数据 / 相机 / 相册 / AI / Supabase 接入，以及 iOS Widget 真机编译验证。

## 2026-07-20 Daily Development Log

日期：2026-07-20

今日完成内容：

- 更新 Home / Journal / Profile 的 AI 提示视觉：
  - 去掉 Home AI 区域咖啡图标。
  - 替换为更贴近 iOS 26 Liquid Glass 感的轻量玻璃卡片。
  - AI 文案改为打开页面时打字出现，并在逗号后自动换行。
- 为 App 引入低饱和纸感背景：
  - 新增 warm kraft paper 背景纹理资源。
  - Home、Journal、Profile、Profile 二级页面和底部导航统一使用纸感背景。
  - 将原本突兀的白色卡片、空状态、表单和弹层统一替换为低饱和纸色表面。
- 继续优化 Home 页面细节：
  - 最近咖啡空状态去掉外框，仅保留轻量提示文案。
  - 「记录一杯」按钮缩短并居中，让它与上方 AI 卡片比例更协调。
- 统一 Record Flow 的视觉表面：
  - 来源选择弹层、输入框和放弃确认弹窗改为纸感表面。
  - 保持原有底部弹层结构与流程不变。
- 优化 Profile 桌面小组件详情页：
  - Medium Widget 预览区域改为纸感底色。
  - 修正 Widget 预览整体偏移问题，使组件在预览区域中视觉居中。
  - 调整 Widget 玻璃层、加号按钮颜色，降低白色突兀感。
- 优化底部导航交互：
  - 去掉选中后的粉色背景。
  - 鼠标悬停和点击时图标临时放大，松开后恢复原尺寸。
  - 当前页通过图标线条加粗提示，不再依赖色块。
- 删除旧的 AI Candy Glass 组件，新增通用纸感背景、Liquid Glass AI 卡片、打字文本和 AI 文案格式化工具。
- 更新 Widget Tests，适配 AI 打字动画和当前页面结构。
- 已运行并通过：
  - `flutter analyze`
  - `flutter test`

修改原因：

- 背景改为纸感后，原有纯白卡片和粉色选中态显得割裂，需要统一为更低饱和、更温暖的视觉体系。
- AI 提示应更像轻量陪伴，而不是独立功能模块，因此减少图标和装饰，保留一句有生命感的文案。
- 底部导航需要在纸感背景中保持安静，同时仍能让用户知道当前所在页面。

新增或修改的 commit：

- 今日已有提交：`9eecbe4 feat: prepare mvp portfolio release`
- 本次准备提交：`style: polish paper texture and glass interactions`
- 当前尚未推送，准备在日志更新后提交并推送 GitHub。

验证结果：

- `flutter analyze`：通过。
- `flutter test`：通过，11 个测试全部通过。
