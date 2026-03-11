import { AppTextStringConstants } from '../../constants/AppTextStringConstants';
import { WorkOrderScene } from './WorkOrderScene';
import relationalStore from '@ohos.data.relationalStore';
import { AppDataBaseStringConstants } from '../../constants/AppDataBaseStringConstants';

//对象数据层级比较深，要使用深层观察
@Observed
export class WorkOrder{
  // 工单的唯一id
  public id?: number;
  // 工单名称
  public workOrderTitle: string;
  // 工单详细
  public workOrderDetail: string;
  // 0表示待审核 1表示待处理 2表示已完成
  public status: number;
  // 存储凭证路径的数组
  public workOrderScene: Array<WorkOrderScene>;
  // 提交人
  public submitPerson: string;
  // 所在位置
  public locationCheck: string;

  constructor(
  id: number,
  workOrderTitle: string,
  workOrderDetail: string,
  status: number,
  workOrderScene: Array<WorkOrderScene>,
  submitPerson: string,
  locationCheck: string
  ) {
  this.id = id;
  this.workOrderTitle = workOrderTitle;
  this.workOrderDetail = workOrderDetail;
  this.status = status;
  this.workOrderScene = workOrderScene;
  this.submitPerson = submitPerson;
  this.locationCheck = locationCheck;
}

  static fromRow(resultSet:relationalStore.ResultSet):WorkOrder{
    try {
      let id:number = resultSet.getLong(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_ID)) as number
      let workOrderTitle:string = resultSet.getString(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_WORK_ORDER_Title)) as string
      let workOrderDetail:string = resultSet.getString(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_WORK_ORDER_DETAIL)) as string
      let status:number = resultSet.getLong(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_STATUS)) as number
      let workOrderScene:Array<WorkOrderScene> = []
      let submitPerson:string = resultSet.getString(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_SUBMIT_PERSON)) as string
      let locationCheck:string = resultSet.getString(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_LOCATION_CHECK)) as string

      return new WorkOrder(id,workOrderTitle,workOrderDetail,status,workOrderScene,submitPerson,locationCheck)

    }catch (e){
      console.log(AppDataBaseStringConstants.WORK_ORDER_FROM_ROW_FAILED);
      throw new Error(e)
    }
  }
  get StatusText():string{
    switch (this.status){
      case 0:return AppTextStringConstants.STATUS_APPROVE
      case 1:return AppTextStringConstants.STATUS_READY_TO_HANDLE
      case 2:return AppTextStringConstants.STATUS_FINISHED
      default :return AppTextStringConstants.STATUS_APPROVE
    }
  }


}