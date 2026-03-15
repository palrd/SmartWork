import { abilityAccessCtrl,bundleManager,Permissions } from '@kit.AbilityKit';

class PermissionService{
  async checkPermissionGrant(permission:Permissions):Promise<boolean>{
    //atManager，用来检测应用的权限是否被允许
    let atManager:abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    //初始记录权限允许状态
    let grantStatus:abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    //获取应用的tokenId
    try{
      let info:bundleManager.BundleInfo =await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo:bundleManager.ApplicationInfo = info.appInfo
      let tokenId:number =appInfo.accessTokenId;
      //检测权限是否被允许

      grantStatus =await atManager.checkAccessToken(tokenId,permission);
      if(grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED){
        return true;
      }else {
        return false;
      }
    }catch (e) {
      console.log("获取tokenId失败");
      throw new Error(String(e))
    }
  }

  async requestPermission(permissions:Array<Permissions>,context:Context):Promise<boolean>{
    let atManager:abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    try{
      let requestResult = await atManager.requestPermissionsFromUser(context,permissions);
      let grandStatus:Array<number> = requestResult.authResults;
      for(let i=0;i<grandStatus.length;i++){
        if(grandStatus[i] === 0){
          console.log("权限获取成功！");
        }else {
          //引导
          try {
            let resultForSetting =  await atManager.requestPermissionOnSetting(context,permissions)
            for(let j =0;j<resultForSetting.length;j++){
              if(grandStatus[i] === 0){
                console.log("权限获取成功！");
              }else{
                console.error("权限引导失败，将调用toast提示用户")
                return false;

              }
            }
          }
          catch (e){
            console.error("权限引导失败，将调用toast提示用户")
          }

        }

      }
      //若循环结束，方法仍在执行，说明权限获取全部成功
      return true;

    }catch (e) {
      //失败
      console.error("错误！");
      return false;
    }
  }

}

export const permissionService = new PermissionService()