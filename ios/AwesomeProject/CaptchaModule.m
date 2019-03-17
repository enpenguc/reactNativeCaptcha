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

#define appId  @"2073347220"

// @interface CaptchaModule () <NTESVerifyCodeManagerDelegate>

@implementation CaptchaModule

// To export a module named CalendarManager
RCT_EXPORT_MODULE();

// This would name the module AwesomeCalendarManager instead
// RCT_EXPORT_MODULE(AwesomeCalendarManager);


RCT_EXPORT_METHOD(showCaptcha)
{
//  RCTLogInfo(@"Pretending to create an event %@", appId);
//  UIAlertView *mBoxView = [[UIAlertView alloc] initWithTitle:@"验证成功" message:@"showCaptcha..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//  [mBoxView show];

//  [[TCWebCodesBridge sharedBridge] setCapOptions:@{@"sdkClose": @YES}];

//  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 220 , 280, 250)];
  UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(10, 220 , 280, 250)];

//  UIView *view = [[[UIApplication sharedApplication] delegate] window].rootViewController.view;
//  UnityAppController* appController = GetAppController();
  // 加载腾讯验证码
  [[TCWebCodesBridge sharedBridge] loadTencentCaptcha:view appid:appId callback:^(NSDictionary *resultJSON) {
    [self showResultJson:resultJSON];
  }];
}

- (UIViewController *)getCurrentVC
{
  UIViewController *result = nil;
  
  UIWindow * window = [[UIApplication sharedApplication] keyWindow];
  if (window.windowLevel != UIWindowLevelNormal)
  {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow * tmpWin in windows)
    {
      if (tmpWin.windowLevel == UIWindowLevelNormal)
      {
        window = tmpWin;
        break;
      }
    }
  }
  
  UIView *frontView = [[window subviews] objectAtIndex:0];
  id nextResponder = [frontView nextResponder];
  
  if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
  else
    result = window.rootViewController;
  
  return result;
}


- (void)showResultJson:(NSDictionary*)resultJSON {
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       NSString* jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:resultJSON options:0 error:NULL] encoding:NSUTF8StringEncoding];
       if (0 == [resultJSON[@"ret"] intValue]) {
           [[[UIAlertView alloc] initWithTitle:@"验证成功" message:jsonStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
       } else {
           [[[UIAlertView alloc] initWithTitle:@"验证失败" message:jsonStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
       }
   });
}

@end
