export class AppDataBaseStringConstants{
  static DATABASE_NAME:string = "SmartDB.db"
  static TABLE_WORK_ORDER_SQL:string = "CREATE TABLE IF NOT EXISTS workOrder(id INTEGER PRIMARY KEY AUTOINCREMENT,workOrderName TEXT,workOrderDetail TEXT,status INTEGER,submitPerson TEXT,locationCheck TEXT);"
  static TABLE_WORK_ORDER_SCENE_SQL:string = "CREATE TABLE IF NOT EXISTS workOrderScene (id INTEGER PRIMARY KEY AUTOINCREMENT, workOrderId INTEGER, scenePath TEXT);"
  static CREATE_DATABASE_SUCCESSFULLY:string = "数据库SmartWork.db创建成功"
  static CREATE_DATABASE_FAILED:string = "数据库SmartWork.db创建失败"
  static TABLE_WORK_ORDER_NAME:string = "工单表"
  static TABLE_WORK_ORDER_SCENE_NAME:string = "凭证表"
  static CREATE_TABLE_WORK_ORDER_SUCCESSFULLY:string = "数据表工单表创建成功"
  static CREATE_TABLE_WORK_ORDER_SCENE_SUCCESSFULLY:string = "数据表凭证表创建成功"
  static CREATE_TABLE_WORK_ORDER_FAILED:string = "数据表工单表创建失败"
  static CREATE_TABLE_WORK_ORDER_SCENE_FAILED:string = "数据表凭证表创建失败"
  static MISS_DATABASE:string = "数据库还未初始化"


}