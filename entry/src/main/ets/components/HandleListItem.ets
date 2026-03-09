import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'

export  interface HandleData{
  title:string,
  description:string,
  createTime:string,
  status:number
}



@Component
export struct HandleListItem{
  @Consume pathStack:NavPathStack

  @Prop handleData:HandleData
  @Prop useSelfPadding:boolean
  @Prop useOneLine:boolean

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
    Row(){
      Row(){
        Column({space:10}){
          Text(this.handleData.title)
            .fontSize(Theme.PrimaryBody.fontsize)
            .fontWeight(Theme.PrimaryBody.fontWeight)
            .fontColor(Theme.PrimaryBody.fontColor)

          Text(this.handleData.description)
            .maxLines(this.useOneLine?1:null)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)

          Row({space:10}){
            Text("今天")
              .fontSize(Theme.Caption_PlaceHolder.fontsize)
              .fontWeight(Theme.Caption_PlaceHolder.fontWeight)
              .fontColor(Theme.Caption_PlaceHolder.fontColor)
            Text(this.handleData.createTime)
              .fontSize(Theme.Caption_PlaceHolder.fontsize)
              .fontWeight(Theme.Caption_PlaceHolder.fontWeight)
              .fontColor(Theme.Caption_PlaceHolder.fontColor)

          }


        }

        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)

        Text(this.getStatus())
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
      this.pathStack.pushPathByName("WorkOrderDetailPage",this.handleData)
    })

  }
}