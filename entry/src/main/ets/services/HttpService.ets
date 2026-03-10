//导入网络包
import {http} from  "@kit.NetworkKit";
import { JSON } from "@kit.ArkTS";
import hilog from "@ohos.hilog";
import { ApiConstants } from "../constants/ApiConstants";


class HttpService {

  //封装静态get方法
   async getRequest<T>(url: string): Promise<T> {
   let httpRequest:http.HttpRequest=  http.createHttp()
    try {
      let httpResponse = await httpRequest.request(url, {
        method: http.RequestMethod.GET
      })

      let result =JSON.parse( httpResponse.result  as string) as T

      return result
    } catch (err) {
      hilog.error(0x0001, "HttpService", "request error")

      throw new Error("请求失败")
    }finally {
     //记得销毁
      httpRequest.destroy()
    }
  }

  //封装POST
  //返回泛型，传入泛型
   async postRequest<T>(url:string,param:object):Promise<T>{
    let httpRequest:http.HttpRequest = http.createHttp()
    try {
      //将T类型数据转换成Json
      //但是泛型要强制转换成object才可以被转换成json
      let postBody = JSON.stringify(param)
      //发起请求
      let httpResponse = await httpRequest.request(url,{
        method:http.RequestMethod.POST,
        extraData:postBody,
        header:{
          'Content-Type':ApiConstants.requestHead
        }
      })

      //处理回来的数据
      //处理后强转为需要的参数
      let result =JSON.parse( httpResponse.result  as string) as T

      return result
    }catch (e){
      hilog.error(0x0001,"httpService","post请求失败")
      throw new Error("post请求失败")
    }finally {
      httpRequest.destroy()
    }
  }



}

export const httpService = new HttpService()