import { AppTextStringConstants } from '../../constants/AppTextStringConstants';
import { WorkOrderScene } from './WorkOrderScene';

//对象数据层级比较深，要使用深层观察
@Observed
export class WorkOrder{
  // 工单的唯一id
  public id: number;
  // 工单名称
  public workOrderName: string;
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
  workOrderName: string,
  workOrderDetail: string,
  status: number,
  workOrderScene: Array<WorkOrderScene>,
  submitPerson: string,
  locationCheck: string
  ) {
  this.id = id;
  this.workOrderName = workOrderName;
  this.workOrderDetail = workOrderDetail;
  this.status = status;
  this.workOrderScene = workOrderScene;
  this.submitPerson = submitPerson;
  this.locationCheck = locationCheck;
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