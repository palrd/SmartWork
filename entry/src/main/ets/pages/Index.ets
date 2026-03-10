import { AppPageConstants } from '../constants/AppPageConstants'
import { AppPreferenceConstants } from '../constants/AppPreferenceConstants'

@Entry
@Component
struct Index{
  @Provide pathStack:NavPathStack= new NavPathStack()

  aboutToAppear(): void {
    try {
      let isLogin = AppStorage.get(AppPreferenceConstants.LOGIN_STATUS) as boolean
      if(isLogin){
        this.pathStack.replacePathByName(AppPageConstants.HOME_PAGE,null)

      }else {
        this.pathStack.replacePathByName(AppPageConstants.LOGIN_PAGE,null)

      }
    }catch (e){
      throw new Error(String(e))
    }

  }
  build() {
    Navigation(this.pathStack){

    }
    .width('100%')
    .height('100%')
  }
}