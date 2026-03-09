import { HandleListItem,HandleData } from '../components/HandleListItem'
import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'
import App from '@system.app'


@Builder
export function  WorkOrderDetailPageBuilder(){
  WorkOrderDetailPage()
}

@Component
struct WorkOrderDetailPage{
  @Consume pathStack:NavPathStack
  handleData:HandleData = {title:"网络设备巡检",status:0,description:"A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常A区机房状态路由状态异常",createTime:"10:30"}

  getStatus():string{
    if(this.handleData.status === 0){
      return AppTextStringConstants.STATUS_READY_TO_HANDLE
    }
    if(this.handleData.status === 1){
      return AppTextStringConstants.STATUS_FINISHED
    }
    if(this.handleData.status === 2){
      return AppTextStringConstants.STATUS_APPROVE
    }

    //默认返回
    return AppTextStringConstants.STATUS_APPROVE
  }
  build() {
       NavDestination(){
      Stack(){
        Scroll(){
          Column({space:15}){
            Column({space:15}){
              Text(this.handleData.title)
                .fontSize(Theme.PrimaryTitle.fontsize)
                .fontWeight(Theme.PrimaryTitle.fontWeight)
                .fontColor(Theme.PrimaryTitle.fontColor)

              Text(this.getStatus())
                .fontSize(Theme.SecondaryText.fontsize)
                .fontWeight(Theme.SecondaryText.fontWeight)
                .fontColor(Theme.PrimaryAccent)


              Text(this.handleData.description)
                .fontSize(Theme.SecondaryText.fontsize)
                .fontWeight(Theme.SecondaryText.fontWeight)
                .fontColor(Theme.SecondaryText.fontColor)

            }
            .alignItems(HorizontalAlign.Start)
            .backgroundColor(Theme.PrimaryBackGround)
            .border({radius:20})
            .width('100%')
            .padding(20)

            Row(){
              Text(AppTextStringConstants.SCENE_PHOTO)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
            }
            .padding({left:20})


            List({space:10}){
              ForEach([1,2,3,4],()=>{

                ListItem(){
                  Image($r('app.media.background'))
                    .objectFit(ImageFit.Cover)
                    .border({radius:10})

                }
                .width(80)
                .height(80)
              })
            }
            .listDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)


            Column({space:15}){
              Row(){
                Text(AppTextStringConstants.SUBMIT_PERSON)
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryBody.fontColor)
                Text(AppTextStringConstants.USER_NAME)
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.SecondaryText.fontColor)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Divider()
                .strokeWidth(1)
                .width('100%')

              Row(){
                Text(AppTextStringConstants.LOCATION_CHECK_IN)
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryBody.fontColor)
                Text(AppTextStringConstants.USER_NAME)
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryAccent)
                  .onClick(()=>{
                    console.log("输出导航");
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)


            }
            .width('100%')
            .padding(20)
            .backgroundColor(Theme.PrimaryBackGround)
            .border({radius:20})




          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(Theme.PrimaryBackGround2)
          .padding({
            top:20,
            left:20,
            right:20
          })
        }
        .height('100%')
        .backgroundColor(Theme.PrimaryBackGround2)
        .align(Alignment.TopStart)
        .scrollBar(BarState.Off)
        .padding({bottom:100})


        Row(){
          Button(){
            Text(AppTextStringConstants.REJECT_HANDLE)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
          }
          .width('30%')
          .backgroundColor(Theme.SecondaryBackGround2)
          .padding({
            left:20,
            right:20,
            top:15,
            bottom:15
          })


          Button(){
            Text(AppTextStringConstants.AGREE_HANDLE)
              .fontSize(Theme.Action_MediumBody_White.fontsize)
              .fontWeight(Theme.Action_MediumBody_White.fontWeight)
              .fontColor(Theme.Action_MediumBody_White.fontColor)
          }
          .width('60%')
          .padding({
            left:20,
            right:20,
            top:15,
            bottom:15
          })

        }
        .padding(20)
        .height(80)
        .width('100%')
        .backgroundColor(Theme.SecondaryBackGround)
        .justifyContent(FlexAlign.SpaceBetween)
        .position({bottom:0})
        .border({
          radius:{
            topLeft:20,
            topRight:20
          }
        })

      }

    }
    .title(AppTextStringConstants.WORK_ORDER_DETAIL_PAGE)







  }
}