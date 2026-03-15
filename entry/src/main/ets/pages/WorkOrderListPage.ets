import { HandleListItem } from '../components/HandleListItem'
import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants'
import { AppTextStringConstants } from '../constants/AppTextStringConstants'
import { Theme } from '../constants/Theme'
import { WorkOrder } from '../models/Entity/WorkOrder'
import { dataBaseRepo } from '../repository/DataBaseRepo'
import {emitter} from "@kit.BasicServicesKit";
import { AppEventConstants } from '../constants/AppEventsConstants'


@ComponentV2
export  struct WorkOrderListPage{
  @Consumer("pathStack") pathStack:NavPathStack =undefined!

  @Local dataSourceForAll: Array<WorkOrder> =[]
  @Local dataSourceForReady:Array<WorkOrder> =[]
  @Local dataSourceForFinish:Array<WorkOrder> =[]

 aboutToAppear(): void {
   this.loadData()

 }

 refresh():void{
    this.loadData();
    console.log("我被call了")
    emitter.emit({
      eventId:AppEventConstants.REFRESH_EVENT

    })
 }

  async loadData():Promise<void>{
    let resultForAll =await dataBaseRepo.getAllWorkOrders()
    this.dataSourceForAll=resultForAll
    let resultForReady =await dataBaseRepo.getReadyWorkOrders()
    this.dataSourceForReady=resultForReady
    let resultForFinish =await dataBaseRepo.getFinishWorkOrders()
    this.dataSourceForFinish= resultForFinish
  }

  build() {
    Column({space:15}){
      Column(){
        Row(){
          Text(AppTextStringConstants.WORK_ORDER_PAGE)
            .fontSize(Theme.LargeTitle.fontsize)
            .fontWeight(Theme.LargeTitle.fontWeight)
            .fontColor(Theme.LargeTitle.fontColor)

          Text("+  "+AppTextStringConstants.CREATE_NEW)
            .fontSize(Theme.Action_MediumBody_Blue.fontsize)
            .fontWeight(Theme.Action_MediumBody_Blue.fontWeight)
            .fontColor(Theme.Action_MediumBody_Blue.fontColor)
            .onClick(()=>{
                this.pathStack.pushPathByName("CreateWorkOrderPage",null,()=>{
                  this.loadData()
                  console.log("pop回调");
                })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Theme.PrimaryBackGround2)
      .padding({
        top:20,
        left:20,
        right:20
      })

      Tabs(){
        TabContent(){
          if(this.dataSourceForAll.length !== 0){
            Column(){
              List({space:10}){
                Repeat(this.dataSourceForAll)
                  .each((orders:RepeatItem<WorkOrder>)=>{
                    ListItem(){
                      HandleListItem({workOrder:orders.item,useSelfPadding:true,useOneLine:true,action:()=>{this.refresh()}})
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
            .height('100%')
            .layoutWeight(1)
          }else {
            Column(){
              Text(AppDataBaseStringConstants.NO_DATA)
            }
            .width('100%')
            .height('100%')
          }

        }
        .tabBar("全部")

        TabContent(){
          if(this.dataSourceForReady.length !==0){
            Column(){
              List({space:10}){
                Repeat(this.dataSourceForReady)
                  .each((orders:RepeatItem<WorkOrder>)=>{
                    ListItem(){
                      HandleListItem({workOrder:orders.item,useSelfPadding:true,useOneLine:true,action:()=>{this.refresh()}})
                    }
                  })
                  .key((item:WorkOrder)=>{return item.id?.toString()+'_'+item.status.toString()})

              }
              .height('100%')
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .justifyContent(FlexAlign.Start)
            .height('100%')
            .layoutWeight(1)
            .padding({bottom:60})
          }else {
            Column(){
              Text(AppDataBaseStringConstants.NO_DATA)
            }
            .width('100%')
            .height('100%')
          }
        }
        .tabBar("待处理")
        TabContent(){
          if(this.dataSourceForFinish.length !== 0){
          Column(){
            List({space:10}){
              Repeat(this.dataSourceForFinish)
                .each((orders:RepeatItem<WorkOrder>)=>{
                  ListItem(){
                    HandleListItem({workOrder:orders.item,useSelfPadding:true,useOneLine:true,action:()=>{this.refresh()}})
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
          .height('100%')
          .layoutWeight(1)
          }else {
            Column(){
              Text(AppDataBaseStringConstants.NO_DATA)
            }
            .width('100%')
            .height('100%')
          }
        }
        .tabBar(AppTextStringConstants.FINISHED_OA)
      }
      .width('100%')
      .layoutWeight(1)
      .border({
        width:{bottom:1},
        color:Theme.TertiaryBackground
      })
      .scrollable(false)

    }
    .backgroundColor(Theme.PrimaryBackGround2)



  }
}