//
//  RNConnectManager.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/22.
//

#import "RNConnectManager.h"
#import <React/RCTLog.h>

#define JSFuncEventInit @"EventInit"
#define JSFuncEventLogin @"EventLogin"

@implementation RNConnectManager
/**
 1、必须：向RN导出该模块
 */
RCT_EXPORT_MODULE(NativeConnector);


/**
 2、必须：声明要给 JavaScript 导出的方法。
 */
RCT_EXPORT_METHOD(callNativeFunc:(NSString *)msg)
{
  NSLog(@"%@", msg);
}

RCT_EXPORT_METHOD(callNativeWithCallBackFunc:(NSString *)msg callback:(RCTResponseSenderBlock)callback)
{
  NSLog(@"%@", msg);
  callback(@[@"ok i got it"]);
}


/**
  调用js的方法
 */
- (NSArray<NSString *> *)supportedEvents {
  return @[JSFuncEventInit, JSFuncEventLogin];
}

- (void)startInit:(NSString *)msg {
  [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                      method:@"emit"
                        args:@[JSFuncEventInit, msg]
                  completion:NULL];
}

- (void)startLogin {
  [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                      method:@"emit"
                        args:@[JSFuncEventLogin]
                  completion:NULL];
}

@end
