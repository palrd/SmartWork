import { WorkOrder } from '../models/Entity/WorkOrder';
import { dataBaseService } from '../services/DataBaseService';
import relationalStore from '@ohos.data.relationalStore';
import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants';
import { WorkOrderScene } from '../models/Entity/WorkOrderScene';


//需要同时操作两张表
class WorkOrderDAO{
  //仅针对workOrder这个对象的组装方法
  async mixWorkOrders(workOrderResultSet:relationalStore.ResultSet,
   db:relationalStore.RdbStore):Promise<Array<WorkOrder>>{
   try {
     //创建map
     let orders = new Map<number,WorkOrder>()

     //先去拿到workOrder的数据
     try {
       while (workOrderResultSet.goToNextRow()){
         let workOrder:WorkOrder = WorkOrder.fromRow(workOrderResultSet)
         orders.set(workOrder.id!,workOrder)
       }
     }catch (e){
       throw new Error(String(e))

     }finally {
       workOrderResultSet.close()
     }
     //准备筛选用的id
     let ids:Array<number> = Array.from(orders.keys())
     if(ids.length === 0){
       let result:Array<WorkOrder> = Array.from(orders.values())

       return result
     }
     //去拿到scene的数据，然后放到相关workOrder
     let predicateForScene:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_SCENE_NAME)
     predicateForScene.in(AppDataBaseStringConstants.WORK_ORDER_ID,ids)

     let sceneResultSet:relationalStore.ResultSet =await db.query(predicateForScene)
     if(!sceneResultSet){
       let result:Array<WorkOrder> = Array.from(orders.values())

       return result
     }
     try {
       while (sceneResultSet.goToNextRow()){
         let scene:WorkOrderScene = WorkOrderScene.fromRow(sceneResultSet)
         orders.get(scene.workOrderId!)?.workOrderScene.push(scene)
       }
     }catch (e){
       throw new Error(String(e))

     }finally {
       sceneResultSet.close()
     }

     //全部处理完成后
     let result:Array<WorkOrder> = Array.from(orders.values())

     return result
   }catch (e) {
     throw new Error(String(e))
   }


  }

    //分页查询
    async queryWorkOrderPage(pageNumber:number,pageSize:number):Promise<Array<WorkOrder>>{
      try {
        let db = dataBaseService.getRDB()

        if(!db){
          throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
        }
        let predicateForWorkOrder:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
        predicateForWorkOrder.offsetAs((pageNumber-1)*pageSize)
        predicateForWorkOrder.limitAs(pageSize)
        predicateForWorkOrder.orderByDesc(AppDataBaseStringConstants.TABLE_ID)

        let workOrderResultSet:relationalStore.ResultSet = await db.query(predicateForWorkOrder)
        if(!workOrderResultSet){
          return []
        }
        return await this.mixWorkOrders(workOrderResultSet,db)

      }catch (e) {
        console.error("错误来自queryWorkOrderPage");
        throw new Error(String(e))

      }

    }

    //插入工单
    async insertWorkOrder(workOrder:WorkOrder):Promise<number>{
      let db = dataBaseService.getRDB()
      if(!db){
        throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
      }

      try {
        let workOrderFotInsert:relationalStore.ValuesBucket = {
          'workOrderTitle' : workOrder.workOrderTitle,
          'workOrderDetail' : workOrder.workOrderDetail,
          'status' :workOrder.status,
          'submitPerson' : workOrder.submitPerson,
          'locationCheck' : workOrder.locationCheck,
          'createTime': workOrder.createTime
        }
        db.beginTransaction()
        let orderId:number = await db.insert(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME,workOrderFotInsert)
        if(workOrder.workOrderScene.length !== 0){
          let workOrdersSceneForInsert :Array<relationalStore.ValuesBucket> = []
          workOrder.workOrderScene.forEach((scene:WorkOrderScene)=>{
            let workOrderSceneForInsert:relationalStore.ValuesBucket = {
              'scenePath':scene.scenePath,
              'workOrderId':orderId
            }
            workOrdersSceneForInsert.push(workOrderSceneForInsert)
          })
          await db.batchInsert(AppDataBaseStringConstants.TABLE_WORK_ORDER_SCENE_NAME,workOrdersSceneForInsert)
        }
        db.commit()

        console.log(AppDataBaseStringConstants.INSERT_TABLE_WORK_ORDER_SUCCESSFULLY)
        return orderId
      }catch (e){
        db.rollBack()
        console.error("错误来自insertWorkOrder");
        throw new Error(String(e))
      }
    }

    //根据工单状态查询工单
    async queryWorkOrderByStatus(pageNumber:number,pageSize:number,status:number,):Promise<Array<WorkOrder>>{
     try {
       let db =dataBaseService.getRDB()
       if(!db){
         throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
       }
       let predicateForWorkOrder:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
       predicateForWorkOrder.offsetAs((pageNumber-1)*pageSize)
       predicateForWorkOrder.limitAs(pageSize)
       predicateForWorkOrder.orderByDesc(AppDataBaseStringConstants.TABLE_ID)
       predicateForWorkOrder.equalTo(AppDataBaseStringConstants.TABLE_STATUS,status)

       let workOrderResultSet:relationalStore.ResultSet = await db.query(predicateForWorkOrder)
       if(!workOrderResultSet){
         return []
       }
       return await this.mixWorkOrders(workOrderResultSet,db)

     }catch (e){
       console.error("错误来自queryWorkOrderByStatus");

       throw new Error(String(e))

     }


    }

    //查询待办和完成的量
    async getNumberOfFinishedAndToDo():Promise<Map<string,number>> {
      try {
        let db = dataBaseService.getRDB()
        if (!db) {
          throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
        }
        let countStatus = new Map<string, number>()
        let resultSetReady: relationalStore.ResultSet =
          await db.querySql(AppDataBaseStringConstants.QUERY_COUNT_WITH_READY)
        let resultSetFinish: relationalStore.ResultSet =
          await db.querySql(AppDataBaseStringConstants.QUERY_COUNT_WITH_FINISHED)

        try {
          if (resultSetReady.goToFirstRow() && resultSetFinish.goToFirstRow()) {

            let ready:number = resultSetReady.getLong(resultSetReady.getColumnIndex(AppDataBaseStringConstants.COUNT))
            console.log("这里检索到准备完成数据；",ready);
            countStatus.set("ready", ready)

            let finish:number =resultSetFinish.getLong(resultSetFinish.getColumnIndex(AppDataBaseStringConstants.COUNT))
            console.log("这里检索到准备完成数据；",finish);

            countStatus.set("finish", finish)
          }

        } catch (e) {
          console.error("getNumberOfFinishedAndToDo");
          throw new Error(String(e))

        } finally {
          resultSetReady.close()
          resultSetFinish.close()
        }
        return countStatus

      } catch (e) {
        console.error("错误来自getNumberOfFinishedAndToDo");

        throw new Error(String(e))
      }

    }

    //查询今天之内的工单
    async getRecentlyWorkOrders():Promise<Array<WorkOrder>>{
      try{
        let db = dataBaseService.getRDB()
        if(!db){
          throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
        }
        //把今天的开始计算出来
        let now = new Date()
        let todayStart = new Date(
          now.getFullYear(),
          now.getMonth(),
          now.getDate()
        ).getTime()

        let predicate:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
        predicate.greaterThan(AppDataBaseStringConstants.TABLE_CREATE_TIME,todayStart)
        predicate.orderByDesc(AppDataBaseStringConstants.TABLE_CREATE_TIME)
        let workOrderResultSet:relationalStore.ResultSet = await db.query(predicate)
        if(!workOrderResultSet){
          return []
        }
        return await this.mixWorkOrders(workOrderResultSet,db)
      }catch (e) {
        console.error("错误来自getRecentlyWorkOrders");

        throw new Error(String(e))
      }
    }

    async deleteWorkOrderById(id:number):Promise<void>{

        let db = dataBaseService.getRDB()
        if(!db){
          throw new Error(AppDataBaseStringConstants.MISS_DATABASE)

        }
        let predicateForWorkOrder:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
        predicateForWorkOrder.equalTo(AppDataBaseStringConstants.TABLE_ID,id)
        let predicateForWorkOrderScene:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_SCENE_NAME)
        predicateForWorkOrderScene.equalTo(AppDataBaseStringConstants.WORK_ORDER_ID,id)
        try {
          db.beginTransaction()

        let row:number = await db.delete(predicateForWorkOrder)
          if(row !==0){
            await db.delete(predicateForWorkOrderScene)
          }

          db.commit()
        }catch (e) {
          db.rollBack()
          console.error("错误来自deleteWorkOrderById");

          throw new Error(String(e))
        }


    }

    async queryOrderById(id:number):Promise<WorkOrder>{
      try {
        let db = dataBaseService.getRDB()
        if(!db){
          console.error("queryOrderById");
          throw new Error()
        }
        let predicateForWorkOrder = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
        predicateForWorkOrder.equalTo(AppDataBaseStringConstants.TABLE_ID,id)
        let resultSetForWorkOrder:relationalStore.ResultSet =await db.query(predicateForWorkOrder)
        if(!resultSetForWorkOrder.goToFirstRow()){
          console.log("此处为空")
          return WorkOrder.unUseAbleOrder()
        }
        let workOrder:WorkOrder = WorkOrder.fromRow(resultSetForWorkOrder)
       try {

           let predicateForScene = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_SCENE_NAME)
           predicateForScene.equalTo(AppDataBaseStringConstants.WORK_ORDER_ID,id)
           let resultSetForScene:relationalStore.ResultSet = await db.query(predicateForScene)
           if(!resultSetForScene){
             console.log("此处scene为空")

             return workOrder

           }
          try {
            let scenes:Array<WorkOrderScene> =[]
            while (resultSetForScene.goToNextRow()){
              let scene:WorkOrderScene = WorkOrderScene.fromRow(resultSetForScene)
              scenes.push(scene)
            }
            //注入
            workOrder.workOrderScene = scenes
            return workOrder
          }catch (e) {
            resultSetForScene.close()
            console.error("queryOrderById");
            throw new Error()
          }

       }catch (e) {
         resultSetForWorkOrder.close()
         console.error("queryOrderById");
         throw new Error()
       }

      }catch (e) {
        console.error("queryOrderById");
        throw new Error()
      }
    }


    async updateWorkOrderStatusById(id:number):Promise<number>{
     try {
       let db =dataBaseService.getRDB()
       if(!db){
         throw new Error()

       }
       let predicate:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
       predicate.equalTo(AppDataBaseStringConstants.TABLE_ID,id)
       let value:relationalStore.ValuesBucket={
         'status':1
       }
       let rowId = await db.update(value,predicate)
       return rowId

     }catch (e) {
       throw new Error(String(e))

     }
    }


}

export const workOrderDAO = new WorkOrderDAO()