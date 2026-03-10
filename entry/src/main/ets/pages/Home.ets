import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"
import { HomePage } from "./HomePage"
import { ProfilePage } from "./ProfilePage"
import { WorkOrderListPage } from "./WorkOrderListPage"


@Builder
export function  HomeBuilder(){
  Home()
}

@Component
struct Home{
  @Consume pathStack:NavPathStack


  build() {
    NavDestination(){
      Tabs({barPosition:BarPosition.End}){
        TabContent(){
          HomePage()
        }
        .tabBar(AppTextStringConstants.HOMEPAGE)
        TabContent(){
          WorkOrderListPage()
        }
        .tabBar(AppTextStringConstants.WORK_ORDER_PAGE)

        TabContent(){
          ProfilePage()
        }
        .tabBar(AppTextStringConstants.PROFILE_PAGE)



      }
      .animationCurve(Curve.FastOutSlowIn)
      .width('100%')
      .height('100%')
      .barOverlap(true)
      .backgroundColor(Theme.PrimaryBackGround2)
    }
    .hideTitleBar(true)


  }
}