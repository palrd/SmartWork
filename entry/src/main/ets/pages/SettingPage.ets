import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"

@Builder
export function SettingPageBuilder(){
  SettingPage()
}

@Component
struct SettingPage{
  @Consume pathStack:NavPathStack
  build() {

    NavDestination(){
      Column({space:20}){
        Column({space:15}){
          Row(){
            Text(AppTextStringConstants.ACCEPT_THE_PUSH_NOTIFICATION)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
            Toggle({isOn:true,type:ToggleType.Switch})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Divider()
            .strokeWidth(1)
            .width('100%')

          Row(){
            Text(AppTextStringConstants.CLEAR_CACHES)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
            Text(AppTextStringConstants.CACHE_SIZE+" MB")
              .fontSize(Theme.SecondaryText.fontsize)
              .fontWeight(Theme.SecondaryText.fontWeight)
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

        Column({space:15}){
          Row(){
            Text(AppTextStringConstants.ABOUT_SMART_WORK)
              .fontSize(Theme.PrimaryBody.fontsize)
              .fontWeight(Theme.PrimaryBody.fontWeight)
              .fontColor(Theme.PrimaryBody.fontColor)
            Text("v" +AppTextStringConstants.APP_VERSION+ " >")
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
            Text(AppTextStringConstants.H5_MIXED_PRESENTATION)
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
          .onClick(()=>{
            this.pathStack.pushPathByName("WebViewPage",null)
          })


        }
        .width('100%')
        .padding(20)
        .backgroundColor(Theme.PrimaryBackGround)
        .border({radius:20})

        Button(){
          Text(AppTextStringConstants.LOGIN_OUT)
            .fontSize(Theme.Action_MediumBody_White.fontsize)
            .fontWeight(Theme.Action_MediumBody_White.fontWeight)
            .fontColor(Theme.Destructive)
        }
        .backgroundColor(Theme.PrimaryBackGround)
        .width('100%')
        .padding(20)

      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Theme.PrimaryBackGround2)
      .height('100%')
      .padding({
        top:20,
        left:20,
        right:20
      })


    }
    .title(AppTextStringConstants.SETTING_PAGE)

  }
}