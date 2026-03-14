import { AppErrorStringConstants } from "../constants/AppErrorStringConstants"
import { AppShowToastStringConstants } from "../constants/AppShowToastStringConstants"
import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"
import { UserDTO } from "../models/DTO/UserDTO"
import { loginRepository } from "../repository/LoginRepository"
import { ToastUtil } from "../utils/ToastUtil"


@Builder
export function LoginPageBuilder(){
  LoginPage()
}


@ComponentV2
struct LoginPage{

  @Consumer("pathStack") pathStack:NavPathStack =undefined!

  @Local userDTO:UserDTO = {
    username:'',
    password:''
  }

  //登录方法
  async login(){
    try {
      if(this.userDTO.username !== '' && this.userDTO.password!== ''){
        await loginRepository.login(this.userDTO)
        this.pathStack.replacePathByName("Home",null)
        ToastUtil.showToast(this.getUIContext(),AppShowToastStringConstants.LOGIN_SUCCESS+this.userDTO.username)

      }else {
        ToastUtil.showToast(this.getUIContext(),AppErrorStringConstants.MISS_LOGIN_USER_NAME)

      }
    }catch (e){
      console.log(String(e))
    }


  }

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
                  .onChange((value:string)=>{
                    this.userDTO.username = value
                  })

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
                  .onChange((value:string)=>{
                    this.userDTO.password = value
                  })

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
                    this.login()
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