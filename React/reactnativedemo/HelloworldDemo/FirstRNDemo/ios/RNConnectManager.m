//
//  RNConnectManager.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/22.
//

#import "RNConnectManager.h"
#import <React/RCTLog.h>

#import "RNBridge.h"
#import "RNBUtil.h"

#import "ZTGJavascriptBridge.h"

#define JSFuncEventInit @"EventInit"
#define JSFuncEventLogin @"EventLogin"
#define JSFuncNativeCallJS @"callJSFunc"


@interface RNConnectManager () <RNBridgeDelegate>
@property (nonatomic, strong) RNBridge *dsBridgeAdapter;
@end

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

RCT_EXPORT_METHOD(callNative:(NSString *)method args:(id)args) {
  [self callNativeCallback:method args:args callback:nil];
}


RCT_EXPORT_METHOD(callNativeCallback:(NSString *)method args:(id)args callback:(RCTResponseSenderBlock)callback)
{
  @try {
    //NSLog(@"%@, %@", method, args);
    __block BOOL didCallBack = NO;
    [self.dsBridgeAdapter callMethod:method args:args callBack:^(NSString *result) {
        if (callback) callback(@[result ? : @""]);
        didCallBack = YES;
    }];
    
  } @catch(NSException *exception){
    NSLog(@"%@", exception);
  }
}


/**
  调用js的方法
 */
- (NSArray<NSString *> *)supportedEvents {
  return @[JSFuncEventInit, JSFuncEventLogin,JSFuncNativeCallJS];
}

- (void)startInit:(NSString *)msg {
//  [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
//                      method:@"emit"
//                        args:@[JSFuncEventInit, msg]
//                  completion:NULL];
  
  
  [self.dsBridgeAdapter callHandler:JSFuncEventInit arguments:@[msg ? : @""] completionHandler:^(id value) {

  }];
}

- (void)startLogin {
  [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                      method:@"emit"
                        args:@[JSFuncEventLogin]
                  completion:NULL];
}


- (RNBridge *)dsBridgeAdapter {
  if (!_dsBridgeAdapter) {
    _dsBridgeAdapter = [[RNBridge alloc] init];
    _dsBridgeAdapter.cDelegate = self;
    ZTGJavascriptBridge *jb = [[ZTGJavascriptBridge alloc] init];
    [_dsBridgeAdapter addReactNativeObject:jb ns:@"ztg"];
  }
  return _dsBridgeAdapter;
}

-(void)callJSHandler:(NSString *)methodName
           arguments:(NSArray *)args
   completionHandler:(RNBridgeCallJavascriptCompleteBlock)completionHandler
{
  if (self.bridge) {
    [self.bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                        method:@"emit"
                          args:@[JSFuncNativeCallJS, @{@"method":methodName, @"data":args}]
                    completion:^{
      if (completionHandler) completionHandler(nil);
    }];
    
  } else {
    if (completionHandler) completionHandler([NSError errorWithDomain:@"RN模块为初始化" code:-1 userInfo:nil]);
  }
}
@end
