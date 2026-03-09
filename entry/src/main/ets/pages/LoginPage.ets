import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"

@Builder
export function  LoginPageBuilder(){
  LoginPage()
}

@Component
struct LoginPage{

  @Consume pathStack:NavPathStack

  build() {
      NavDestination(){
         Column({space:30}){
              Column({space:10}){
                Text(AppTextStringConstants.APP_NAME)
                  .fontSize(Theme.LargeTitle.fontsize)
                  .fontWeight(Theme.LargeTitle.fontWeight)
                  .fontColor(Theme.LargeTitle.fontColor)

                Text(AppTextStringConstants.APP_DESCRIPTION)
                  .fontSize(Theme.SecondaryText.fontsize)
                  .fontWeight(Theme.SecondaryText.fontWeight)
                  .fontColor(Theme.SecondaryText.fontColor)
              }
              .alignItems(HorizontalAlign.Start)


              Column({space:10}){
                TextInput({placeholder:AppTextStringConstants.PERSON_DATA_EMAIL})
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryBody.fontColor)
                  .backgroundColor(Color.Transparent)
                  .placeholderColor(Theme.Caption_PlaceHolder.fontColor)

                Divider()
                  .width('100%')
                  .strokeWidth(1)
                  .color(Theme.TertiaryBackground)

                TextInput({placeholder:AppTextStringConstants.PERSON_DATA_PASSWORD})
                  .fontSize(Theme.PrimaryBody.fontsize)
                  .fontWeight(Theme.PrimaryBody.fontWeight)
                  .fontColor(Theme.PrimaryBody.fontColor)
                  .backgroundColor(Color.Transparent)
                  .placeholderColor(Theme.Caption_PlaceHolder.fontColor)

              }
              .border({
                width:1,
                color:Theme.TertiaryBackground,
                radius:20
              })
              .padding(10)
              .alignItems(HorizontalAlign.Start)

              Button(AppTextStringConstants.LOGIN)
                .width('100%')
                .padding({
                  top:10,
                  bottom:10
                })
                .onClick(()=>{
                  this.pathStack.replacePathByName("Home",null)
                })



              }
        .width('100%')
         .height('100%')
         .alignItems(HorizontalAlign.Start)
         .backgroundColor(Theme.PrimaryBackGround)
        .padding({
          top:70,
          left:20,
          right:20
        })
}
  }
}