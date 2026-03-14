import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"


@ComponentV2
export struct ProfilePage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!


  build() {
      NavDestination(){

        Column({space:20}){
          Text(AppTextStringConstants.PROFILE_PAGE)
            .fontSize(Theme.LargeTitle.fontsize)
            .fontWeight(Theme.LargeTitle.fontWeight)
            .fontColor(Theme.LargeTitle.fontColor)

          Row({space:15}){
            Image($r('app.media.background'))
              .width(60)
              .height(60)
              .border({radius:30})

            Column(){
              Text(AppTextStringConstants.USER_NAME)
                .fontColor(Theme.PrimaryTitle.fontColor)
                .fontSize(Theme.PrimaryTitle.fontsize)
                .fontWeight(Theme.PrimaryTitle.fontWeight)
              Text(AppTextStringConstants.USER_DEPARTMENT+"   "+AppTextStringConstants.USER_POSITION)
                .fontSize(Theme.SecondaryText.fontsize)
                .fontWeight(Theme.SecondaryText.fontWeight)
                .fontColor(Theme.SecondaryText.fontColor)
            }
            .alignItems(HorizontalAlign.Start)
            .width('75%')

          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding(20)
          .backgroundColor(Theme.PrimaryBackGround)
          .border({radius:20})


          Column({space:15}){
            Row(){
              Text(AppTextStringConstants.WORK_ORDER_STATISTICS)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text(">")
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.SecondaryText.fontColor)
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
              Text(AppTextStringConstants.ATTENDANCE_RECORD)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text(">")
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.SecondaryText.fontColor)
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


            Row(){
              Text(AppTextStringConstants.SETTING_PAGE)
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.PrimaryBody.fontColor)
              Text(">")
                .fontSize(Theme.PrimaryBody.fontsize)
                .fontWeight(Theme.PrimaryBody.fontWeight)
                .fontColor(Theme.SecondaryText.fontColor)
                .onClick(()=>{
                  console.log("PICKER");
                })
            }
            .width('100%')
            .padding(20)
            .backgroundColor(Theme.PrimaryBackGround)
            .border({radius:20})
            .justifyContent(FlexAlign.SpaceBetween)
          .onClick(()=>{
            this.pathStack.pushPathByName("SettingPage",null)
          })



        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(20)
      }
      .hideTitleBar(true)
    .backgroundColor(Theme.PrimaryBackGround2)
  }
}