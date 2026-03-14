import {preferences} from "@kit.ArkData";
import { AppPreferenceConstants } from "../constants/AppPreferenceConstants";


class PreferenceService{
  //首先定义一个preference实例
  preference:preferences.Preferences|null = null

  //初始化方法
  async initUserPreference(context:Context,name:string):Promise<void>{
    //尝试获取
    try {
      this.preference =await preferences.getPreferences(context,name)
      console.log("preference初始化成功");
    }catch (e){
      throw new Error(String(e))
    }
  }

  //提供get的方法
  async getPreferenceValue(key:string):Promise<string>{
    try {
      if(!this.preference){
        throw new Error("preference还未初始化!")
      }
      let value =  await this.preference.get(key,"default")
      return value as string
    }
    catch (e){
      throw new Error(String(e))
    }

  }

  //添加方法
  async putPreference(key:string,value:preferences.ValueType):Promise<void>{
    try {
      if(!this.preference){
       throw new Error("preference还未初始化!")
      }
      //存内存，写文件
      await this.preference.put(key,value)
      await this.flushToDisk()
    }
    catch (e){
      throw new Error(String(e))
    }


  }

  //写入文件
   async  flushToDisk():Promise<void>{
    try {
      if(!this.preference){
        throw new Error("preference还未初始化!")

      }
      await this.preference.flush()
      console.log("写入硬盘成功");
    }
    catch (e){
      throw new Error(String(e))
    }


  }

  //查询是否存在某个值
  async hasPreference(key:string):Promise<boolean>{

    try {
      if(!this.preference){
        throw new Error("preference还未初始化!")

      }
      await this.preference.has(key)
      return true
    }catch (e){
      throw new Error(String(e))
    }
  }

  //删除某个值
  async deletePreference(key:string):Promise<boolean>{
    try {
      if(!this.preference){
        throw new Error("preference还未初始化!")

      }
      await this.preference.delete(key)
      return true
    }catch (e) {
      throw new Error(String(e))

    }
  }


}

export const preferenceService = new PreferenceService()