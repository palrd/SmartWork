import { AppTextStringConstants } from "../constants/AppTextStringConstants"

@Builder
export function WebViewPageBuilder(){
  WebViewPage()
}

@Component
struct WebViewPage{
  @Consume pathStack:NavPathStack

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