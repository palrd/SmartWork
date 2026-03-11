@Observed
export class WorkOrderScene{
  id:number
  scenePath:string
  workOrderId:number

  constructor(id:number,
  scenePath:string,
  workOrderId:number) {
    this.id =id
    this.scenePath = scenePath
    this.workOrderId =workOrderId

  }
}