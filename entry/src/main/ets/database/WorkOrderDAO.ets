import { WorkOrder } from '../models/Entity/WorkOrder';
import { dataBaseService } from '../services/DataBaseService';
import relationalStore from '@ohos.data.relationalStore';
import { AppDataBaseStringConstants } from '../constants/AppDataBaseStringConstants';
import { WorkOrderScene } from '../models/Entity/WorkOrderScene';


//需要同时操作两张表
class WorkOrderDAO{

    //分页查询
    async queryWorkOrderPage(pageNumber:number,pageSize:number):Promise<Array<WorkOrder>>{
      try {
        let db = dataBaseService.getRDB()

        if(!db){
          throw new Error()
        }
        let predicateForWorkOrder:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
        predicateForWorkOrder.offsetAs((pageNumber-1)*pageSize)
        predicateForWorkOrder.limitAs(pageSize)
        predicateForWorkOrder.orderByDesc(AppDataBaseStringConstants.TABLE_ID)

        let orders = new Map<number,WorkOrder>()
        let workOrderResultSet:relationalStore.ResultSet = await db.query(predicateForWorkOrder)
        if(!workOrderResultSet){
          return []
        }
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

        let ids:Array<number> = Array.from(orders.keys())
        if(ids.length === 0){
          let result:Array<WorkOrder> = Array.from(orders.values())

          return result
        }
        //筛选
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
             orders.get(scene.workOrderId)?.workOrderScene.push(scene)
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

    //插入工单
    async insertWorkOrder(workOrder:WorkOrder):Promise<void>{
      let db = dataBaseService.getRDB()
      if(!db){
        throw new Error()
      }

      try {
        let workOrderFotInsert:relationalStore.ValuesBucket = {
          'workOrderTitle' : workOrder.workOrderTitle,
          'workOrderDetail' : workOrder.workOrderDetail,
          'status' :workOrder.status,
          'submitPerson' : workOrder.submitPerson,
          'locationCheck' : workOrder.locationCheck,
        }
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


        console.log(AppDataBaseStringConstants.INSERT_TABLE_WORK_ORDER_SUCCESSFULLY)
      }catch (e){
        throw new Error(String(e))
      }
    }

    //根据工单状态查询工单
    async queryWorkOrderByStatus(status:number,pageNumber:number,pageSize:number):Promise<Array<WorkOrder>>{
     try {
       let db =dataBaseService.getRDB()
       if(!db){
         throw new Error()
       }
       let predicateForWorkOrder:relationalStore.RdbPredicates = new relationalStore.RdbPredicates(AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME)
       predicateForWorkOrder.offsetAs((pageNumber-1)*pageSize)
       predicateForWorkOrder.limitAs(pageSize)
       predicateForWorkOrder.orderByDesc(AppDataBaseStringConstants.TABLE_ID)
       predicateForWorkOrder.equalTo(AppDataBaseStringConstants.TABLE_STATUS,status)

       let orders = new Map<number,WorkOrder>()
       let workOrderResultSet:relationalStore.ResultSet = await db.query(predicateForWorkOrder)
       if(!workOrderResultSet){
         return []
       }
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

       let ids:Array<number> = Array.from(orders.keys())
       if(ids.length === 0){
         let result:Array<WorkOrder> = Array.from(orders.values())

         return result
       }
       //筛选
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
           orders.get(scene.workOrderId)?.workOrderScene.push(scene)
         }
       }catch (e){
         throw new Error(String(e))

       }finally {
         sceneResultSet.close()
       }

       //全部处理完成后
       let result:Array<WorkOrder> = Array.from(orders.values())

       return result


     }catch (e){
       throw new Error(String(e))

     }


    }

    //查询待办和完成的量
    async getNumberOfFinishedAndToDo():Promise<Map<string,number>> {
      try {
        let db = dataBaseService.getRDB()
        if (!db) {
          throw new Error()
        }
        let countStatus = new Map<string, number>()
        let resultSetReady: relationalStore.ResultSet =
          await db.querySql(AppDataBaseStringConstants.QUERY_COUNT_WITH_READY)
        let resultSetFinish: relationalStore.ResultSet =
          await db.querySql(AppDataBaseStringConstants.QUERY_COUNT_WITH_FINISHED)

        try {
          if (resultSetReady && resultSetFinish) {
            resultSetReady.goToFirstRow()
            resultSetFinish.goToFirstRow()

            let ready: number = resultSetReady.getLong(resultSetReady.getColumnIndex(AppDataBaseStringConstants.COUNT))
            let finish: number = resultSetFinish.getLong(resultSetFinish.getColumnIndex(AppDataBaseStringConstants.COUNT))

            countStatus.set("ready", ready)
            countStatus.set("finish", finish)
          }

        } catch (e) {
          throw new Error()

        } finally {
          resultSetReady.close()
          resultSetFinish.close()
        }
        return countStatus

      } catch (e) {
        throw new Error(String(e))
      }

    }


}

export const workOrderDAO = new WorkOrderDAO()