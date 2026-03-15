import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants';
import { AppPreferenceConstants } from '../constants/AppPreferenceConstants';
import { workOrderDAO } from '../database/WorkOrderDAO';
import { WorkOrder } from '../models/Entity/WorkOrder';
import { WorkOrderScene } from '../models/Entity/WorkOrderScene';
import { locationService } from '../services/LocationService';
import { preferenceService } from '../services/PreferenceService';

class DataBaseRepo{
  //向UI提供查询最近工单的查询方法
  async getRecentlyWorkOrders():Promise<Array<WorkOrder>>{
    try {
      let result = await workOrderDAO.getRecentlyWorkOrders()

      return result
    }catch (e) {
      throw new Error("获取最近工单失败")
    }

  }

  async getFinishAndReady():Promise<Map<string,number>>{
    try {
      let map:Map<string,number> =await workOrderDAO.getNumberOfFinishedAndToDo()
      return map

    }catch (e) {
      throw new Error("获取最近工单失败")

    }
  }

  async getAllWorkOrders(pageNumber:number = 1,pageSize:number = 20):Promise<Array<WorkOrder>>{
    let result =await workOrderDAO.queryWorkOrderPage(pageNumber,pageSize)
    return result

  }

  async getReadyWorkOrders(pageNumber:number = 1,pageSize:number = 20):Promise<Array<WorkOrder>>{
    let result =await workOrderDAO.queryWorkOrderByStatus(pageNumber,pageSize,0)

    return result
  }

  async getFinishWorkOrders(pageNumber:number = 1,pageSize:number = 20):Promise<Array<WorkOrder>>{
    let result =await workOrderDAO.queryWorkOrderByStatus(pageNumber,pageSize,1)
    return result
  }

  async insertData(workOrder:WorkOrder,scenes:Array<string>,context:UIContext):Promise<number>{
    try {
      //ui层只负责传递title，detail，location，scenes路径数组
      //所以在repo中需要将工单提交者名称，时间戳拼接,将scenes路径数组转成workOrderScenes
      let userName =await preferenceService.getPreferenceValue(AppPreferenceConstants.USER_NAME);
      workOrder.submitPerson = userName;
      console.log("从硬盘中获取提交者",userName)

      let createTime:number = Date.now()
      if(scenes.length!==0){
        let workOrderScenes:Array<WorkOrderScene> = []
        scenes.forEach((scene)=>{
          let workOrderScene:WorkOrderScene = new WorkOrderScene(null,scene,null)
          workOrderScenes.push(workOrderScene)
        })
        //注入
        workOrder.workOrderScene = workOrderScenes
      }
      workOrder.createTime = createTime
      //尝试自动获取位置
      let location:string =await locationService.getLocation(context);
      workOrder.locationCheck = location;
      //调用dao
      let orderId =  await workOrderDAO.insertWorkOrder(workOrder)
      return orderId
    }catch (e) {
      throw new Error("组装工单时失败")
    }

  }

  async getWorkOrderById():Promise<WorkOrder>{
    let id:number = AppStorage.get(AppDataBaseStringConstants.APP_STORAGE_NOW_WORK_ID)!
    console.log("当前查询id：",id)
    let workOrder:WorkOrder = await workOrderDAO.queryOrderById(id)
    return workOrder
  }

  async updateWorkOrderToFinish():Promise<number>{
    let id:number = AppStorage.get(AppDataBaseStringConstants.APP_STORAGE_NOW_WORK_ID)!
    console.log("当前更新id：",id)
    let result:number = await workOrderDAO.updateWorkOrderStatusById(id)
    return result
  }

  async deleteNowWorkOrder():Promise<void>{
    let id:number = AppStorage.get(AppDataBaseStringConstants.APP_STORAGE_NOW_WORK_ID)!
    console.log("当前更新id：",id)
    await workOrderDAO.deleteWorkOrderById(id)
  }


}

export const dataBaseRepo = new DataBaseRepo()