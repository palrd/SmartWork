import { AppPreferenceConstants } from '../constants/AppPreferenceConstants'
import { preferenceService } from './PreferenceService'

class AuthCheckService{
  async checkLogin():Promise<boolean>{
    try {
      //粗筛

      let isLogin = await preferenceService.hasPreference(AppPreferenceConstants.USER_TOKEN)

      return isLogin
    }catch (e){
      throw new Error(String(e))
    }

  }
}

export const authCheckService = new AuthCheckService()