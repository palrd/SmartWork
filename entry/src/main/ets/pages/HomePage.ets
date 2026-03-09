import { HandleListItem } from "../components/HandleListItem"
import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"


@Component
export struct HomePage{
  @Consume pathStack:NavPathStack

  build() {
    Column({space:15}){
      Text(AppTextStringConstants.HOMEPAGE)
        .fontSize(Theme.LargeTitle.fontsize)
        .fontWeight(Theme.LargeTitle.fontWeight)
        .fontColor(Theme.LargeTitle.fontColor)
      Row(){
        Column({space:40}){
          Text('12')
            .fontSize(Theme.PrimaryTitle.fontsize)
            .fontWeight(Theme.PrimaryTitle.fontWeight)
            .fontColor(Theme.PrimaryAccent)

          Text(AppTextStringConstants.PREPARE_OA)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)
        } .padding(20)
        .backgroundColor(Theme.SecondaryBackGround)
        .border({
          radius:20,
        })
        .width('45%')
        .alignItems(HorizontalAlign.Start)



        Column({space:40}){
          Text('20')
            .fontSize(Theme.PrimaryTitle.fontsize)
            .fontWeight(Theme.PrimaryTitle.fontWeight)
            .fontColor(Theme.PrimaryAccent)

          Text(AppTextStringConstants.FINISHED_OA)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)
        }
        .padding(20)
        .backgroundColor(Theme.SecondaryBackGround)
        .border({
          radius:20,
        })
        .width('45%')
        .alignItems(HorizontalAlign.Start)

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Text(AppTextStringConstants.RECENTLY_HANDLE)
        .fontSize(Theme.SecondaryText.fontsize)
        .fontWeight(Theme.SecondaryText.fontWeight)
        .fontColor(Theme.SecondaryText.fontColor)

      List({space:10}){
        HandleListItem({useSelfPadding:false,handleData:{title:"网络设备巡检",status:0,description:"A区机房状态路由状态异常",createTime:"10:30"}})
      }





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