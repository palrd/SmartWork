import { Theme } from '../constants/Theme'

@Entry
@Component
struct Index {
  @Provide pathStack:NavPathStack = new NavPathStack()

  onPageShow(): void {
    this.pathStack.replacePathByName('LoginPage',null)
  }

  @Builder
  build() {
    Navigation(this.pathStack){
      Column(){
        Text('初始化完成')
          .fontSize(Theme.PrimaryTitle.fontsize)
          .fontWeight(Theme.PrimaryTitle.fontWeight)
          .fontColor(Theme.PrimaryTitle.fontColor)
      }
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }
  }
}