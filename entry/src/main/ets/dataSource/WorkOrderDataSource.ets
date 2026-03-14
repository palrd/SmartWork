import { WorkOrder } from '../models/Entity/WorkOrder'

export class WorkOrderDatasource implements IDataSource{
  private data:Array<WorkOrder> = []
  private dataChangeListeners:Array<DataChangeListener> = []

  totalCount(): number {
    console.log("WorkOrderDatasource读取长度")

    return this.data.length
  }

  getData(index: number): WorkOrder {
    console.log("WorkOrderDatasource读取数据")

    return this.data[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    console.log("WorkOrderDatasource注册监听器")

    this.dataChangeListeners.push(listener)
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    console.log("WorkOrderDatasource移除监听")

    this.dataChangeListeners = this.dataChangeListeners.filter(i=>i!==listener)
  }

  setData(data:Array<WorkOrder>):void{
    console.log("WorkOrderDatasource设置数据")

    this.data = data
   this.dataChangeListeners.forEach(i=> i.onDataReloaded())
  }

}