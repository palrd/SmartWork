import {relationalStore} from "@kit.ArkData";
import { AppDataBaseStringConstants } from "../constants/AppDataBaseStringConstants";


class DataBaseService{
  private RDB:relationalStore.RdbStore | undefined= undefined


  //初始化方法，建造一个数据库
  async  initDB(context:Context):Promise<void>{
    try {
      //配置建库信息
      let DB_CONFIG:relationalStore.StoreConfig = {
        name:AppDataBaseStringConstants.DATABASE_NAME,
        securityLevel:relationalStore.SecurityLevel.S1
      }
      this.RDB = await relationalStore.getRdbStore(context,DB_CONFIG)
      console.log(AppDataBaseStringConstants.CREATE_DATABASE_SUCCESSFULLY)
      //创建表1
      await this.RDB.execute(AppDataBaseStringConstants.TABLE_WORK_ORDER_SQL)
      console.log(AppDataBaseStringConstants.CREATE_TABLE_WORK_ORDER_SUCCESSFULLY)

      //创建表2
      await this.RDB.execute(AppDataBaseStringConstants.TABLE_WORK_ORDER_SCENE_SQL)
      console.log(AppDataBaseStringConstants.CREATE_TABLE_WORK_ORDER_SCENE_SUCCESSFULLY)

    }catch (e){
      console.error(AppDataBaseStringConstants.CREATE_DATABASE_FAILED)
      console.error(AppDataBaseStringConstants.CREATE_TABLE_WORK_ORDER_FAILED)
      console.error(AppDataBaseStringConstants.CREATE_TABLE_WORK_ORDER_SCENE_FAILED)
      throw new Error(String(e))
    }
  }



  getRDB():relationalStore.RdbStore{
    if(!this.RDB){
      throw new Error(AppDataBaseStringConstants.MISS_DATABASE)
    }
    return this.RDB
  }
}

export const dataBaseService = new DataBaseService()