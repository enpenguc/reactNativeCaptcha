//
//  CaptchaModule.h
//  AwesomeProject
//
//  Created by enpengwx on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CaptchaModule.h"
#import <TCWebCodesSDK/TCWebCodesBridge.h>
#import <React/RCTRootView.h>

//#define APPID  @"12313"

@implementation CaptchaModule

// To export a module named CalendarManager
RCT_EXPORT_MODULE();

//// 导出常量
//- (NSDictionary *)constantsToExport
//{
//  return @{ @"APPID": APPID };
//}

// callback方式
//RCT_EXPORT_METHOD(showCaptcha:(NSString *)appId2 callback:(RCTPromiseRejectBlock)callback)
//{
//  dispatch_async(dispatch_get_main_queue(), ^{
//    [[TCWebCodesBridge sharedBridge] loadTencentCaptcha:[self getCurrentVC].view appid:appId callback:^(NSDictionary *resultJSON) {
//      callback(@[resultJSON]);
//    }];
//  });
//}
//

// promise模式
RCT_EXPORT_METHOD(showCaptcha:(NSString *)appId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [[TCWebCodesBridge sharedBridge] loadTencentCaptcha:[self getCurrentVC].view appid:appId callback:^(NSDictionary *resultJSON) {
      resolve(resultJSON);
    }];
  });
}

- (UIViewController *)getCurrentVC
{
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
  return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
  UIViewController *currentVC;
  if ([rootVC presentedViewController]) {
    // 视图是被presented出来的
    rootVC = [rootVC presentedViewController];
  }
  if ([rootVC isKindOfClass:[UITabBarController class]]) {
    // 根视图为UITabBarController
    currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
  } else if ([rootVC isKindOfClass:[UINavigationController class]]){
    // 根视图为UINavigationController
    currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
  } else {
    // 根视图为非导航类
    currentVC = rootVC;
  }
  return currentVC;
}

@end
