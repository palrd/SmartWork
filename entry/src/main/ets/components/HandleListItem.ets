import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants'
import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'
import { WorkOrder } from '../models/Entity/WorkOrder'


@ComponentV2
export struct HandleListItem{
  @Consumer("pathStack") pathStack:NavPathStack = undefined!

  @Require @Param workOrder:WorkOrder
  @Param useSelfPadding:boolean = false
  @Param useOneLine:boolean = false

  @Event action:()=>void= ()=>{}


  actionData():void{
    AppStorage.setOrCreate(AppDataBaseStringConstants.APP_STORAGE_NOW_WORK_ID,this.workOrder.id)
    this.pathStack.pushPathByName("WorkOrderDetailPage",this.workOrder,()=>{this.action();console.log("我是回调！！！！！！！！！！！！！！！")})
  }


  build() {
    Row(){
      Row(){
        Column({space:10}){
          Text(this.workOrder.workOrderTitle)
            .fontSize(Theme.PrimaryBody.fontsize)
            .fontWeight(Theme.PrimaryBody.fontWeight)
            .fontColor(Theme.PrimaryBody.fontColor)

          Text(this.workOrder.workOrderDetail)
            .maxLines(this.useOneLine?1:null)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)

          Row({space:10}){
            Text(this.workOrder.TimeText)
              .fontSize(Theme.Caption_PlaceHolder.fontsize)
              .fontWeight(Theme.Caption_PlaceHolder.fontWeight)
              .fontColor(Theme.Caption_PlaceHolder.fontColor)
            Text(this.workOrder.hour)
              .fontSize(Theme.Caption_PlaceHolder.fontsize)
              .fontWeight(Theme.Caption_PlaceHolder.fontWeight)
              .fontColor(Theme.Caption_PlaceHolder.fontColor)

          }


        }

        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)

        Text(this.workOrder.StatusText)
          .fontSize(Theme.Caption_PlaceHolder.fontsize)
          .fontWeight(Theme.SecondaryText.fontWeight)
          .fontColor(Theme.PrimaryAccent)
          .padding({left:5,right:5,top:2,bottom:2})
          .border({
            radius:3
          })


      }
      .width('100%')
      .padding({left:20,right:20,top:15,bottom:15})
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Theme.SecondaryBackGround)
      .border({radius:20,})
    }
    .padding({ left:this.useSelfPadding?20:0,right:this.useSelfPadding?20:0,})
    .onClick(()=>{
        this.actionData()
    })

  }
}