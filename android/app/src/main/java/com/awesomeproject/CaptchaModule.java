package com.awesomeproject;

//import android.widget.Toast;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;

import com.tencent.captchasdk.TCaptchaDialog;
import com.tencent.captchasdk.TCaptchaVerifyListener;

import org.json.JSONObject;



public class CaptchaModule extends ReactContextBaseJavaModule {
    private TCaptchaDialog dialog;
    private Promise verifyPromise;
    private Promise verifyAppId;
    private TCaptchaVerifyListener captchaVerifyListener = new TCaptchaVerifyListener() {
        @Override
        public void onVerifyCallback(JSONObject jsonObject) {
            try {
                WritableMap data = Arguments.createMap();
                int ret = jsonObject.getInt("ret");
                data.putInt("ret", ret);
                data.putString("appid", jsonObject.getString("appid"));
                data.putString("ticket", jsonObject.getString("ticket"));
                data.putString("randstr", jsonObject.getString("randstr"));
                verifyPromise.resolve(data);
            } catch (Exception e) {
                verifyPromise.reject("500", "Verify error", e);
            }
        }
    };

    public CaptchaModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "CaptchaModule";
    }

    // /**
    //  *  暴露给react常亮定义
    //  */
    // @Override
    // public Map<String, Object> getConstants() {
    //     final Map<String, Object> constants = new HashMap<>();
    //     constants.put("APPID", "23123");
    //     return constants;
    // }


    // /**
    //  *  暴露给react访问发方法
    //  */
    // @ReactMethod
    // public void showCaptcha(String appId, Promise promise) {
    //     try {
    //     //    toastMsg("showCaptcha start...");
    //         if (dialog != null){
    //          dialog.dismiss();
    //         }
    //         verifyPromise = promise;
    //         dialog = new TCaptchaDialog(getCurrentActivity(), appId, captchaVerifyListener, "ssss");
    //         dialog.show();
    //     } catch(Exception e) {
    //         promise.reject("500", "Verify error", e);
    //         // e.printStackTrace();
    //     }
    // }

    /**
     *  暴露给react访问发方法
     */
    @ReactMethod
    public void showCaptcha(String appId, Promise promise) {
        verifyAppId = appId;
        verifyPromise = promise;
        // fixbug: Calling View methods on another thread than the UI thread
        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    //    toastMsg("showCaptcha start...");
                    if (dialog != null) {
                        dialog.dismiss();
                    }

                    dialog = new TCaptchaDialog(getCurrentActivity(), verifyAppId, captchaVerifyListener, "ssss");
                    dialog.show();
                } catch (Exception e) {
                    verifyPromise.reject("500", "Verify error", e);
                    // e.printStackTrace();
                }
            }
        });
    }

    // private void toastMsg(String msg) {
    //     Toast.makeText(getCurrentActivity(), msg, Toast.LENGTH_SHORT).show();
    // }

}
