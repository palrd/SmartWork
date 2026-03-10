
export class ToastUtil{

  //简单的toast
  static showToast(context:UIContext,message:string,duration:number =2000){
    let promptAction =  context.getPromptAction()

    try {
      promptAction.showToast({ message: message ,duration:duration})
    } catch (error) {
     console.log(String(error))
    }

  }
}