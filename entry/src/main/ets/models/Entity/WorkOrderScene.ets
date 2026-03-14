import relationalStore from "@ohos.data.relationalStore"
import { AppDataBaseStringConstants } from "../../constants/AppDataBaseStringConstants"

@ObservedV2
export class WorkOrderScene{
  @Trace id?:number
  @Trace scenePath:string
  @Trace workOrderId?:number

  constructor(id:number|null,
  scenePath:string,
  workOrderId:number|null) {
    this.id =id!
    this.scenePath = scenePath
    this.workOrderId =workOrderId!

  }

  static fromRow(resultSet:relationalStore.ResultSet):WorkOrderScene{
    try {
      let id:number = resultSet.getLong(resultSet.getColumnIndex(AppDataBaseStringConstants.SCENE_ID)) as number
      let scenePath:string = resultSet.getString(resultSet.getColumnIndex(AppDataBaseStringConstants.SCENE_PATH)) as string
      let workOrderId:number = resultSet.getLong(resultSet.getColumnIndex(AppDataBaseStringConstants.WORK_ORDER_ID)) as number

      return new WorkOrderScene(id,scenePath,workOrderId)
    }catch (e) {
      console.log(AppDataBaseStringConstants.WORK_ORDER_SCENE_FROM_ROW_FAILED);
      throw new Error(e)
    }
  }
}