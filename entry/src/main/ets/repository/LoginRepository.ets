import { ApiConstants } from "../constants/ApiConstants";
import { AppPreferenceConstants } from "../constants/AppPreferenceConstants";
import { UserDTO } from "../models/DTO/UserDTO";
import {UserVO} from "../models/VO/UserVO";

import { httpService } from "../services/HttpService";
import { preferenceService } from "../services/PreferenceService";

export class LoginRepository{

  //这个方法就是向上提供给UI使用的
  async login(userDTO:UserDTO):Promise<void>{
   try{
     //从服务器获取数据
     let result:UserVO = await httpService.postRequest<UserVO>(ApiConstants.baseURL+ApiConstants.loginAPI,userDTO)
     //进行token存储
     await preferenceService.putPreference(AppPreferenceConstants.USER_TOKEN,result.username)
     //不出问题的话UI那边就会进入下一个页面
   }catch (e){
      throw new Error(String(e))
   }


  }
}