import { HandleListItem } from '../../components/HandleListItem'
import { AppTextStringConstants } from '../../constants/AppTextStringConstants'
import { Theme } from '../../constants/Theme'

@Component
export  struct WorkOrderListPage{
  build() {

    Column({space:25}){
      Row(){
        Text(AppTextStringConstants.WORK_ORDER_PAGE)
          .fontSize(Theme.LargeTitle.fontsize)
          .fontWeight(Theme.LargeTitle.fontWeight)
          .fontColor(Theme.LargeTitle.fontColor)

        Text("+  "+AppTextStringConstants.CREATE_NEW)
          .fontSize(Theme.Action_MediumBody_Blue.fontsize)
          .fontWeight(Theme.Action_MediumBody_Blue.fontWeight)
          .fontColor(Theme.Action_MediumBody_Blue.fontColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Tabs(){
        TabContent(){
          List({space:10}){
            ForEach([1,3,2,4,5,5],()=>{
              HandleListItem({handleData:{title:"网络设备巡检",status:0,description:"A区机房状态路由状态异常",createTime:"10:30"}})
            })
          }

        }


      }
      .width('100%')
      .height('100%')





    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Theme.PrimaryBackGround2)
    .padding({
      top:20,
      left:20,
      right:20
    })
  }
}