import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'
import { WorkOrder } from '../models/Entity/WorkOrder'
import { WorkOrderScene } from '../models/Entity/WorkOrderScene'
import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants'
import { dataBaseRepo } from '../repository/DataBaseRepo'


@Builder
export function  WorkOrderDetailPageBuilder(){
  WorkOrderDetailPage()
}

@ComponentV2
struct WorkOrderDetailPage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!

  @Local workOrder:WorkOrder = WorkOrder.emptyConstruct()

  aboutToAppear(): void {
    this.loadData()
  }

  async deleteNowWorkOrder():Promise<void>{
    await dataBaseRepo.deleteNowWorkOrder()
    this.pathStack.pop("delete")

  }

  async loadData():Promise<void>{
    let order:WorkOrder =await  dataBaseRepo.getWorkOrderById()
    this.workOrder.workOrderTitle = order.workOrderTitle
    this.workOrder.workOrderDetail = order.workOrderDetail
    this.workOrder.status =order.status
    this.workOrder.workOrderScene = order.workOrderScene
    this.workOrder.submitPerson = order.submitPerson
    this.workOrder.locationCheck = order.locationCheck

    console.log("工单对象载入：",order.submitPerson)

  }

  async confirmFinish(){
    await dataBaseRepo.updateWorkOrderToFinish()
    this.pathStack.pop("finish")
  }

  build() {
       NavDestination(){
      Stack(){
        Scroll(){
          Column({space:15}){
            Column({space:15}){
              Text(this.workOrder.workOrderTitle)
                .fontSize(Theme.PrimaryTitle.fontsize)
                .fontWeight(Theme.PrimaryTitle.fontWeight)
                .fontColor(Theme.PrimaryTitle.fontColor)

              Text(this.workOrder.StatusText)
                .fontSize(Theme.SecondaryText.fontsize)
                .fontWeight(Theme.SecondaryText.fontWeight)
                .fontColor(Theme.PrimaryAccent)


              Text(this.workOrder.workOrderDetail)
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


            if(this.workOrder?.workOrderScene?.length > 0){
              List({space:10}){
                ForEach(this.workOrder.workOrderScene,(item:WorkOrderScene)=>{
                  ListItem(){
                    Image($r('app.media.background'))
                      .objectFit(ImageFit.Cover)
                      .border({radius:10})
                  }
                  .width(80)
                  .height(80)
                })
              }
            }else{
              Row(){
                Text(AppDataBaseStringConstants.NO_DATA)
              }
              .justifyContent(FlexAlign.Center)
            }

            Column({space:15}){
              Row(){
                Text(AppTextStringConstants.SUBMIT_PERSON)
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryBody.fontColor)
                Text(this.workOrder.submitPerson)
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
                Text(this.workOrder.locationCheck)
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
        .padding({bottom:120})


        Row(){
          Button(){
            Text(AppTextStringConstants.DELETE_DATA)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.Destructive)
          }
          .width('30%')
          .backgroundColor(Theme.SecondaryBackGround2)
          .padding({
            left:20,
            right:20,
            top:15,
            bottom:15
          })
          .onClick(()=>{
            this.deleteNowWorkOrder()

          })

          Button(){
            Text(AppTextStringConstants.CONFIRM_FINISH)
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
          .onClick(()=>{
              this.confirmFinish()

          })

        }
        .padding(20)
        .height(100)
        .width('100%')
        .backgroundColor(Theme.SecondaryBackGround)
        .justifyContent(FlexAlign.SpaceBetween)
        .position({bottom:0,right:0,left:0})
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