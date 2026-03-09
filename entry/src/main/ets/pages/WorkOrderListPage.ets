import { HandleListItem } from '../components/HandleListItem'
import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'

@Component
export  struct WorkOrderListPage{
  @Consume pathStack:NavPathStack

  build() {
    Column({space:15}){
      Column(){
        Row(){
          Text(AppTextStringConstants.WORK_ORDER_PAGE)
            .fontSize(Theme.LargeTitle.fontsize)
            .fontWeight(Theme.LargeTitle.fontWeight)
            .fontColor(Theme.LargeTitle.fontColor)

          Text("+  "+AppTextStringConstants.CREATE_NEW)
            .fontSize(Theme.Action_MediumBody_Blue.fontsize)
            .fontWeight(Theme.Action_MediumBody_Blue.fontWeight)
            .fontColor(Theme.Action_MediumBody_Blue.fontColor)
            .onClick(()=>{
                this.pathStack.pushPathByName("CreateWorkOrderPage",null)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Theme.PrimaryBackGround2)
      .padding({
        top:20,
        left:20,
        right:20
      })

      Tabs(){
        TabContent(){
          List({space:10}){
            HandleListItem({useSelfPadding:true,handleData:{title:"网络设备巡检",status:0,description:"A区机房状态路由状态异常",createTime:"10:30"}})

          }
          .height('100%')
          .width('100%')
        }
        .tabBar("全部")

        TabContent(){
          List({space:10}){
            HandleListItem({useSelfPadding:true,handleData:{title:"服务器",status:0,description:"A区机房状态路由状态异常",createTime:"10:30"}})

          }
          .height('100%')
          .width('100%')
        }
        .tabBar(AppTextStringConstants.STATUS_APPROVE)
        TabContent(){
          List({space:10}){
            HandleListItem({useSelfPadding:true,handleData:{title:"服务器",status:0,description:"A区机房状态路由状态异常",createTime:"10:30"}})

          }
          .height('100%')
          .width('100%')
        }
        .tabBar(AppTextStringConstants.FINISHED_OA)
      }
      .width('100%')
      .layoutWeight(1)
      .border({
        width:{bottom:1},
        color:Theme.TertiaryBackground
      })
      .scrollable(false)

    }
    .backgroundColor(Theme.PrimaryBackGround2)



  }
}