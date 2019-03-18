// NativeModules.js
/**
 * 导出NativeModules，暴露给ReactNative的js代码访问
 *
 */
import { NativeModules } from "react-native";

const { CaptchaModule } = NativeModules;


module.exports = {
  /*
  * 验证码组件CaptchaModule，显示滑块浮窗验证调用showCaptcha方法
  *  eg.
  * const appId = '12331'; // appId
  * const res = await CaptchaModule.showCaptcha(appId);
  * res数据结构：{ ret: 0, appid: '12313', ticket: 'sfxf3wsfsf', randstr: 'sdfsf' }
  * 其中res.ret === 0表示成功。提交请求给服务端，需要将整个res都需要传递回去，让服务端做校验。
  */
  CaptchaModule,
};
