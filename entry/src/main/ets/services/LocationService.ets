import {geoLocationManager} from "@kit.LocationKit";
import { permissionService } from "./PermissionService";
import { Permissions } from "@kit.AbilityKit";
import { ToastUtil } from "../utils/ToastUtil";
import { JSON } from "@kit.ArkTS";

class LocationService{
  //来决定是否需要申请权限
  async checkPermission(context:UIContext):Promise<void>{
    let p1 = await permissionService.checkPermissionGrant("ohos.permission.LOCATION");
    let p2 = await permissionService.checkPermissionGrant("ohos.permission.APPROXIMATELY_LOCATION");

    //若模糊定位和精准定位中有一个没获取到，就直接全部重新申请
    if(!p1||!p2){
      //在此把每个权限都申请了
      let permissions:Array<Permissions> = ["ohos.permission.LOCATION","ohos.permission.APPROXIMATELY_LOCATION"];

      try{
        let result =  await permissionService.requestPermission(permissions,context.getHostContext()!);
        if(!result){
          //调用Toast提示用户全部不拒绝则无法使用定位功能，那么该工单无法创建
          ToastUtil.showToast(context,"无法获取位置则无法创建工单");
        }
      }catch (e) {
        console.error("请检查权限")
        throw new Error(String(e));
      }
    }
  }


  async getLocation(context:UIContext):Promise<string>{
    try {
      console.log("尝试获取位置：")
      //先手动检测
      await this.checkPermission(context);
      //双倍检查，通过说明权限没问题
      let locationEnable:boolean = geoLocationManager.isLocationEnabled();
      console.log("尝试获取位置是否允许：",locationEnable)
      //尝试获取系统缓存的最近定位记录
      let lastLocation:geoLocationManager.Location = geoLocationManager.getLastLocation();
      //尝试进行正地理编码
      //检测设备是否允许使用正地理比编码过程
      let isConvertEnable:boolean = geoLocationManager.isGeocoderAvailable();
      if(isConvertEnable){
        try {
          let resultFromLocation:geoLocationManager.GeoAddress[] =await geoLocationManager.getAddressesFromLocation(lastLocation);
          if(resultFromLocation.length >0){
            console.log("编码后的地理信息：",resultFromLocation[0].placeName);

          }
          let locationWithPlaceName:string = resultFromLocation[0].placeName as string
          return locationWithPlaceName;


        }catch (e){
          console.log("编码失败");

        }
      }else {
        console.log("编码不可用，返回经纬度：",lastLocation.latitude+lastLocation.longitude);
        let locationWithLatitude:string = String(lastLocation.latitude);
        return locationWithLatitude;
      }
      //如果上面均无返回值，说明位置服务不可用
      return "位置服务不可用";

    }catch (e) {
      console.log("尝试获取位置不允许：");
      console.log("错误：",e);
      throw new Error()
    }
  }
}

export const locationService =new LocationService();