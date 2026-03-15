import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'
import { WorkOrder } from '../models/Entity/WorkOrder'
import { dataBaseRepo } from '../repository/DataBaseRepo'
import { ToastUtil } from '../utils/ToastUtil'


@Builder
export function  CreateWorkOrderPageBuilder(){
  CreateWorkOrderPage()
}

@ComponentV2
struct CreateWorkOrderPage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!

  @Local workTitle:string = ''
  @Local workDetail:string = ''
  @Local location:string = '测试地点'
  @Local scenes:Array<string> = []

  async sureInsert():Promise<void>{
    if(this.workTitle === ''){
      ToastUtil.showToast(this.getUIContext(),"请先填写工单标题")
      return
    }
    if(this.workDetail === ''){
      ToastUtil.showToast(this.getUIContext(),"请描述问题")
      return
    }
    if(this.location === ''){
      ToastUtil.showToast(this.getUIContext(),"请获取定位")
      return
    }
    let workOrder:WorkOrder = new WorkOrder(null,this.workTitle,this.workDetail,0,[],'',this.location,0)

    let id = await dataBaseRepo.insertData(workOrder,this.scenes,this.getUIContext())

    this.pathStack.pop(id)

  }

  build() {
    NavDestination(){
      Scroll(){
        Column({space:20}){
          Column({space:10}){
            TextInput({placeholder:AppTextStringConstants.TITLE_FOR_CREATE_WORK_ORDER})
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
              .backgroundColor(Color.Transparent)
              .placeholderColor(Theme.Caption_PlaceHolder.fontColor)
              .onChange((value:string)=>{
                this.workTitle = value
              })

            Divider()
              .width('100%')
              .strokeWidth(1)
              .color(Theme.TertiaryBackground)

            TextArea({placeholder:AppTextStringConstants.DESCRIPTION_FOR_CREATE_WORK_ORDER})
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
              .backgroundColor(Color.Transparent)
              .placeholderColor(Theme.Caption_PlaceHolder.fontColor)
              .maxLines(null)
              .onChange((value:string)=>{
                this.workDetail = value
              })

          }
          .border({
            width:1,
            color:Theme.TertiaryBackground,
            radius:20
          })
          .padding(10)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(Theme.SecondaryBackGround)

          Column({space:15}){
            Text(AppTextStringConstants.UPDATE_SCENE_PHOTO)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
            Column(){
              Text("+")
                .fontSize(Theme.PrimaryTitle.fontsize)
                .fontWeight(Theme.PrimaryTitle.fontWeight)
                .fontColor(Theme.TertiaryBackground)
            }
            .width(80)
            .height(80)
            .border({
              style:BorderStyle.Dashed,
              color:Theme.TertiaryBackground,
              width:2,
              radius:10
            })
            .justifyContent(FlexAlign.Center)
            .onClick(()=>{
              this.scenes.push("凭证")
            })

            Divider()
              .strokeWidth(1)
              .width('100%')

            Row(){
              Text(AppTextStringConstants.LOCATION_CHECK_IN)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text(AppTextStringConstants.GET_LOCATION)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryAccent)

            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)




          }
          .width('100%')
          .padding(20)
          .backgroundColor(Theme.PrimaryBackGround)
          .border({radius:20})
          .alignItems(HorizontalAlign.Start)

          Button(){
            Text(AppTextStringConstants.SUBMIT_WORK_ORDER)
              .fontSize(Theme.Action_MediumBody_White.fontsize)
              .fontWeight(Theme.Action_MediumBody_White.fontWeight)
              .fontColor(Theme.Action_MediumBody_White.fontColor)
          }
          .width('100%')
          .padding(20)
          .onClick(()=>{
            this.sureInsert()
          })


        }
        .width('100%')
        .padding(20)


      }
      .height('100%')
      .align(Alignment.TopStart)
      .backgroundColor(Theme.PrimaryBackGround2)
      .scrollBar(BarState.Off)

    }
    .title(AppTextStringConstants.CREATE_WORK_ORDER_PAGE)

  }
}