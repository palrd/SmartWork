import { HandleListItem } from "../components/HandleListItem"
import { AppDataBaseStringConstants } from "../constants/AppDataBaseStringConstants"
import { AppPreferenceConstants } from "../constants/AppPreferenceConstants"
import { AppShowToastStringConstants } from "../constants/AppShowToastStringConstants"
import { AppTextStringConstants } from "../constants/AppTextStringConstants"
import { Theme } from "../constants/Theme"
import { WorkOrder } from "../models/Entity/WorkOrder"
import { dataBaseRepo } from "../repository/DataBaseRepo"
import { ToastUtil } from "../utils/ToastUtil"
import {emitter} from "@kit.BasicServicesKit";
import { AppEventConstants } from "../constants/AppEventsConstants"


@ComponentV2
export struct HomePage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!

  @Local workOrders:Array<WorkOrder> = []
  @Local finish:string = ''
  @Local ready:string = ''

  aboutToAppear(): void {
    emitter.on({eventId:AppEventConstants.REFRESH_EVENT},()=>{
      this.loadData();
      console.log("回调执行了");
    })
    this.loadData()
    ToastUtil.showToast(this.getUIContext(),AppShowToastStringConstants.LOGIN_SUCCESS+AppStorage.get(AppPreferenceConstants.USER_NAME))

  }

  aboutToDisappear(): void {
    emitter.off(AppEventConstants.REFRESH_EVENT)
  }



  async loadData(){
    let result = await dataBaseRepo.getRecentlyWorkOrders()
    this.workOrders = result
    let map = await dataBaseRepo.getFinishAndReady()
    this.ready = map.get(AppDataBaseStringConstants.READY)?.toString()!
    this.finish = map.get(AppDataBaseStringConstants.FINISH)?.toString()!
    console.log("我再次执行")
  }


  build() {
    Column({space:15}){
      Text(AppTextStringConstants.HOMEPAGE)
        .fontSize(Theme.LargeTitle.fontsize)
        .fontWeight(Theme.LargeTitle.fontWeight)
        .fontColor(Theme.LargeTitle.fontColor)
      Row(){
        Column({space:40}){
          Text(this.ready)
            .fontSize(Theme.PrimaryTitle.fontsize)
            .fontWeight(Theme.PrimaryTitle.fontWeight)
            .fontColor(Theme.PrimaryAccent)

          Text(AppTextStringConstants.PREPARE_OA)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)
        } .padding(20)
        .backgroundColor(Theme.SecondaryBackGround)
        .border({
          radius:20,
        })
        .width('45%')
        .alignItems(HorizontalAlign.Start)



        Column({space:40}){
          Text(this.finish)
            .fontSize(Theme.PrimaryTitle.fontsize)
            .fontWeight(Theme.PrimaryTitle.fontWeight)
            .fontColor(Theme.PrimaryAccent)

          Text(AppTextStringConstants.FINISHED_OA)
            .fontSize(Theme.SecondaryText.fontsize)
            .fontWeight(Theme.SecondaryText.fontWeight)
            .fontColor(Theme.SecondaryText.fontColor)
        }
        .padding(20)
        .backgroundColor(Theme.SecondaryBackGround)
        .border({
          radius:20,
        })
        .width('45%')
        .alignItems(HorizontalAlign.Start)

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Text(AppTextStringConstants.RECENTLY_HANDLE)
        .fontSize(Theme.SecondaryText.fontsize)
        .fontWeight(Theme.SecondaryText.fontWeight)
        .fontColor(Theme.SecondaryText.fontColor)

      Column(){
        List({space:10}){
         Repeat(this.workOrders)
           .each((orders:RepeatItem<WorkOrder>)=>{
             ListItem(){
               HandleListItem({workOrder:orders.item,useSelfPadding:false,useOneLine:true,action:()=>{this.loadData()}})
             }
           })
           .key((item:WorkOrder)=>{return item.id?.toString()+'_'+item.status.toString()})
        }
        .height('100%')
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .justifyContent(FlexAlign.Start)

      .padding({bottom:60})
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Theme.PrimaryBackGround2)
    .padding({
      top:20,
      left:20,
      right:20
    })

  }
}