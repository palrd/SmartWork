export class AppDataBaseStringConstants{
  static DATABASE_NAME:string = "SmartDB.db"

  static CREATE_DATABASE_SUCCESSFULLY:string = "数据库SmartWork.db创建成功"
  static CREATE_DATABASE_FAILED:string = "数据库SmartWork.db创建失败"
  static TABLE_WORK_ORDER_NAME:string = "workOrder"
  static TABLE_WORK_ORDER_SCENE_NAME:string = "workOrderScene"
  static CREATE_TABLE_WORK_ORDER_SUCCESSFULLY:string = "数据表工单表创建成功"
  static CREATE_TABLE_WORK_ORDER_SCENE_SUCCESSFULLY:string = "数据表凭证表创建成功"
  static CREATE_TABLE_WORK_ORDER_FAILED:string = "数据表工单表创建失败"
  static CREATE_TABLE_WORK_ORDER_SCENE_FAILED:string = "数据表凭证表创建失败"
  static MISS_DATABASE:string = "数据库还未初始化"

  static WORK_ORDER_FROM_ROW_FAILED:string = "workOrder对象自动映射失败"
  static WORK_ORDER_SCENE_FROM_ROW_FAILED:string = "workOrderScene对象自动映射失败"

  static QUERY_ALL_FAILED:string = "获取全部工单查询失败"

  static INSERT_TABLE_WORK_ORDER_SUCCESSFULLY:string = "插入工单数据成功"
  static INSERT_TABLE_WORK_ORDER_FAILED:string = "插入工单数据失败"




  //========SQL==============
  static TABLE_WORK_ORDER_SQL:string = "CREATE TABLE IF NOT EXISTS workOrder(id INTEGER PRIMARY KEY AUTOINCREMENT,workOrderTitle TEXT,workOrderDetail TEXT,status INTEGER,submitPerson TEXT,locationCheck TEXT);"
  static TABLE_WORK_ORDER_SCENE_SQL:string = "CREATE TABLE IF NOT EXISTS workOrderScene (id INTEGER PRIMARY KEY AUTOINCREMENT, workOrderId INTEGER, scenePath TEXT);"
  static QUERY_ALL_SQL:string = "SELECT * FROM "
  static QUERY_COUNT_WITH_READY:string = "SELECT count(*) FROM " + AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME+" WHERE STATUS = 1"
  static QUERY_COUNT_WITH_FINISHED:string = "SELECT count(*) FROM " + AppDataBaseStringConstants.TABLE_WORK_ORDER_NAME+" WHERE STATUS = 2"
  static COUNT:string = "count"
  //=========字段==========
  static TABLE_ID: string = "id";
  static TABLE_WORK_ORDER_Title: string = "workOrderTitle";
  static TABLE_WORK_ORDER_DETAIL: string = "workOrderDetail";
  static TABLE_STATUS: string = "status";
  static TABLE_WORK_ORDER_SCENE: string = "workOrderScene";
  static TABLE_SUBMIT_PERSON: string = "submitPerson";
  static TABLE_LOCATION_CHECK: string = "locationCheck";

  static SCENE_ID: string = "id";
  static SCENE_PATH: string="scenePath"
  static WORK_ORDER_ID: string ="workOrderId"



}