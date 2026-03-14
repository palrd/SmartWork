import { AppTextStringConstants } from "../constants/AppTextStringConstants"

@Builder
export function WebViewPageBuilder(){
  WebViewPage()
}

@ComponentV2
struct WebViewPage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!


  build() {
    NavDestination(){
      Column(){
        Text(AppTextStringConstants.H5_MIXED_PRESENTATION)
      }
      .width('100%')
      .height('100%')
    }
    .title(AppTextStringConstants.H5_MIXED_PRESENTATION)
  }
}