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
  //工单创建时间
  public createTime:number;

  constructor(
  id: number,
  workOrderTitle: string,
  workOrderDetail: string,
  status: number,
  workOrderScene: Array<WorkOrderScene>,
  submitPerson: string,
  locationCheck: string,
    createTime:number
  ) {
  this.id = id;
  this.workOrderTitle = workOrderTitle;
  this.workOrderDetail = workOrderDetail;
  this.status = status;
  this.workOrderScene = workOrderScene;
  this.submitPerson = submitPerson;
  this.locationCheck = locationCheck;
  this.createTime = createTime;
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
      let createTime:number = resultSet.getLong(resultSet.getColumnIndex(AppDataBaseStringConstants.TABLE_CREATE_TIME)) as number

      return new WorkOrder(id,workOrderTitle,workOrderDetail,status,workOrderScene,submitPerson,locationCheck,createTime)

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

  get TimeText(): string {
    let date = new Date(this.createTime)
    let now = new Date()

    let todayStart = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate()
    ).getTime()

    let yesterdayStart = todayStart - 24*60*60*1000

    if (this.createTime >= todayStart) {
      return "今天"
    }

    if (this.createTime >= yesterdayStart) {
      return "昨天"
    }

    return `${date.getMonth()}-${date.getDate()}`
  }

  get hour():string{
    let date = new Date(this.createTime)
    let h = date.getHours().toString().padStart(2,"0")
    let m = date.getMinutes().toString().padStart(2,"0")
    return `${h}:${m}`
  }



}