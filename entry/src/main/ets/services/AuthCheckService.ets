import { AppPreferenceConstants } from '../constants/AppPreferenceConstants'
import { preferenceService } from './PreferenceService'

class AuthCheckService{
  async checkLogin():Promise<boolean>{
    try {
      let userName = await preferenceService.getPreferenceValue(AppPreferenceConstants.USER_NAME)
      if(userName !== "default"){
        AppStorage.setOrCreate(AppPreferenceConstants.USER_NAME,userName)
        return true

      }
      return false;

    }catch (e){
      throw new Error(String(e))
    }

  }
}

export const authCheckService = new AuthCheckService()