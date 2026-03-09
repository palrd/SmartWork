

@Component
struct ListItemHandle{

  @Prop title:string
  @Prop description:string

  build() {
    Column(){

    }
      .width('100%')
      .padding(20)
  }
}