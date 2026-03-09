import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'



@Builder
export function  CreateWorkOrderPageBuilder(){
  CreateWorkOrderPage()
}

@Component
struct CreateWorkOrderPage{
  @Consume pathStack:NavPathStack

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
            Row(){
              Text(AppTextStringConstants.TYPE_FOR_CREATE_WORK_ORDER)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text("请选择 >")
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryAccent)
                .onClick(()=>{
                  console.log("PICKER");
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Divider()
              .strokeWidth(1)
              .width('100%')

            Row(){
              Text(AppTextStringConstants.EXPECTATION_TIME_FOR_FINISH)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text("今天 >")
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryAccent)
                .onClick(()=>{
                  console.log("PICKER");
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)


          }
          .width('100%')
          .padding(20)
          .backgroundColor(Theme.PrimaryBackGround)
          .border({radius:20})


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
              console.log("pick");
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
                .onClick(()=>{
                  console.log("PICKER");
                })
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