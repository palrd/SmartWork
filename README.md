SmartWork 企业级移动工单协作系统 2026.01 – 2026.03
独立全栈开发 技术栈：ArkTS + ArkUI V2 + Navigation + RelationalStore + NetworkKit + ArkWeb
• 项目描述：面向企业外勤与巡检场景打造的鸿蒙原生移动工单协作平台。采用“离线优先 (OfflineFirst)”架构设计，解决外勤人员在地下室等弱网/无网环境下无法顺畅作业的痛点，实现工单创建、流
转、凭证打卡等全生命周期的高可用闭环。
• 现代化架构与路由管理：采用 Repository-Service-DAO 四层架构解耦业务逻辑与 UI 渲染；使用原生
Navigation 与 NavPathStack 统一管理页面栈和跨页传参，实现页面级完全解耦，代码复用率提升 40%。 • 状态管理与性能优化：率先接入 ArkUI V2 状态管理机制（@ObservedV2 / @Trace），实现深层级数据
对象的细粒度按需渲染，相减少无效 UI 重绘；结合 Emitter 事件总线实现跨页面状态数据无感同步。
• 离线优先本地库设计：深度封装 RelationalStore 关系型数据库，设计主附表关联结构并建立复合索引
（多条件分页查询性能提升 50%）；利用 SQLite 事务控制 (beginTransaction / commit) 保障双表级
联并发读写时的数据一致性。
• 网络降级与全栈闭环：独立开发后端 RESTful API 服务；基于 NetworkKit 封装泛型 HTTP 网络层与拦
截器，实现 Token 双重持久化闭环；“在线请求 + 本地兜底”双模式加载策略，无网状态自动降级读取
本地缓存。
• 系统能力与混合开发：深度接入 LocationKit 获取双精度定位并利用逆地理编码实现自动地名转换；封
装健壮的 AbilityAccessCtrl 动态权限体系（预检/动态弹窗/降级引导）；基于 ArkWeb 与 JSBridge 实
现原生 ArkTS 侧与内嵌 H5 统计大屏的双向高效通信。
