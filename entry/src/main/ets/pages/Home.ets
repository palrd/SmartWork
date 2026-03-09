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
        TabContent(){
          WorkOrderListPage()
        }
        TabContent(){
          ProfilePage()
        }


      }
      .width('100%')
      .height('100%')

    }
    .hideTitleBar(true)

  }
}