import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import {webview} from "@kit.ArkWeb";



@Builder
export function WebViewPageBuilder(){
  WebViewPage()
}

@ComponentV2
struct WebViewPage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!
  @Local controller:webview.WebviewController = new webview.WebviewController()

  async getLogin():Promise<String>{
    return "data"
  }



  build() {
    NavDestination(){
      Column(){
        Web({src:$rawfile("show.html"),controller:this.controller})
          .height('100%')
          .onControllerAttached(()=>{
              try {
                this.controller.registerJavaScriptProxy({call:this.getLogin.bind(this)},'jsbridge',['call'])

              }catch (e){
                console.log(String(e))
              }
          })
      }
      .width('100%')
      .height('100%')
    }
    .title(AppTextStringConstants.H5_MIXED_PRESENTATION)
  }
}