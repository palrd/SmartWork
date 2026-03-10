interface fontTheme{
  fontsize:number,
  fontWeight:number,
  fontColor:string
}

export class Theme{
  //主要用于页面顶部大标题、弹窗主标题、核心数据高亮。
  //1. 页面级巨幅标题 (Large Title)
  static LargeTitle:fontTheme={fontsize:34,fontWeight:700,fontColor:'#000000'}

  //2. 模块/卡片主标题 (Primary Title)
  static PrimaryTitle:fontTheme={fontsize:28,fontWeight:600,fontColor:'#1C1C1E'}

  //主要用于应用内 80% 的阅读内容，如列表主标题、段落文字、用户输入的内容、按钮文字。
  //3. 主干正文 (Primary Body)
  static PrimaryBody:fontTheme={fontsize:17,fontWeight:400,fontColor:'#1C1C1E'}

  //4. 交互/强调正文 (Action / Medium Body)
  //适用场景：底部大按钮中的文字、需要轻微强调的列表文本。
  // #FFFFFF (纯白，用于品牌色背景的按钮上) 或 #007AFF (苹果蓝，用于纯文字按钮)
  static Action_MediumBody_White:fontTheme={fontsize:17,fontWeight:500,fontColor:'#FFFFFF'}

  static Action_MediumBody_Blue:fontTheme={fontsize:17,fontWeight:500,fontColor:'#007AFF'}

  //主要用于不抢眼的辅助信息，如列表下方的副标题、发布时间、未输入的占位符提示（Placeholder）。

  //列表的描述文字、副标题。
  static SecondaryText:fontTheme={fontsize:15,fontWeight:400,fontColor:'#8E8E93'}

  //输入框里的默认提示词、极小的脚注、时间戳。
  static Caption_PlaceHolder:fontTheme={fontsize:13,fontWeight:400,fontColor:'#C7C7CC'}


  //第一层级：底层背景色 (Primary Background)
  //整个 App 的大背景底色
  static PrimaryBackGround:string = '#FFFFFF'
  //第一层级：底层背景色 更冷
  //悬浮卡片、分组列表的背景区块、顶部导航栏背景。
  static PrimaryBackGround2:string = '#F2F2F7'

  //第二层级：卡片/模块背景色 (Secondary Background)
  // 色值参考： 纯白 (#FFFFFF，当底色是灰时) 或
  static SecondaryBackGround:string = '#FFFFFF'
  //极浅灰 (#F2F2F7，当底色是白时)
  static SecondaryBackGround2:string = '#F2F2F7'

  // 搜索框底色、未激活的滑块底色、列表之间的极细分割线。
  static TertiaryBackground:string = '#E5E5EA'

  //三种强调色
  //主行动按钮、文字超链接、选中的图标、激活的开关。
  static PrimaryAccent:string = '#007AFF'

  static PrimaryAccentBg:string = '#75007bff'

  //警告色
  //适用场景： 删除按钮、报错提示文本、解散群组等危险操作。
  static Destructive:string = '#FF3B30'

  //成功/安全
  //交易成功图标、开启状态的 Switch 开关。
  static Success:string ='#34C759'







}