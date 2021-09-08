//
//  RNBridge.m
//  dsbridge
//
//  Created by ChaohuiChen on 2021/5/14.
//  Copyright © 2021 杜文. All rights reserved.
//

#import "RNBridge.h"
#import <objc/message.h>
#import "RNBUtil.h"

typedef NS_ENUM(NSInteger, RNBridgeCallCode) {
    RNBridgeCallCodeFailure = -1,
    RNBridgeCallCodeSuccess = 0,
};

@interface RNBridge ()
@property (nonatomic, strong) NSMutableDictionary *rnInterfacePools;
@property (nonatomic, assign) int callId;
@end

@implementation RNBridge
- (void)addReactNativeObject:(id)object ns:(NSString *)ns{
    if(object && ns){
        [self.rnInterfacePools setObject:object forKey:ns];
    }
}
- (void)removeReactNativeObject:(NSString *)ns{
    if(ns){
        [self.rnInterfacePools removeObjectForKey:ns];
    }
}

#pragma mark - js call native
- (void)callMethod:(NSString *)method args:(id)args callBack:(RNBridgeCallBack)callBack
{
  method = [method stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSArray *arr = [RNBUtil parseNamespace:method];
  if (arr.count >= 2) {
    [self callMethod:arr[1] args:args callBack:callBack ns:arr[0]];
  } else {
    if (callBack) callBack([RNBUtil callResult:RNBridgeCallCodeFailure data:@"未设置命名空间~"]);
  }
}
  
- (void)callMethod:(NSString *)method args:(id)args callBack:(RNBridgeCallBack)callBack ns:(NSString *)ns
{
    id rnInterfaceObj = [self.rnInterfacePools objectForKey:ns ? : @""];
    if (rnInterfaceObj) {
        NSString *methodOne = [RNBUtil methodByNameArg:1 selName:method cls:[rnInterfaceObj class]];
        SEL sel = NSSelectorFromString(methodOne);

        NSString *methodTwo = [RNBUtil methodByNameArg:2 selName:method cls:[rnInterfaceObj class]];
        SEL asyncSel = NSSelectorFromString(methodTwo);
        
        do {
            if (callBack && asyncSel && [rnInterfaceObj respondsToSelector:asyncSel]) {
                // handler:(NSString *jsonStr) :(id value, BOOL complete)callBack
                RNBridgeInnerCallBack completionHandler = ^(id value, BOOL complete){
                    id data = [RNBUtil objToJsonString:value];
                    if (callBack) callBack([RNBUtil callResult:complete ? RNBridgeCallCodeSuccess : RNBridgeCallCodeFailure data:data]);
                };
                
                void(*action)(id,SEL,id,id) = (void(*)(id,SEL,id,id))objc_msgSend;
                action(rnInterfaceObj, asyncSel, args, completionHandler);
                return;
            }
            
            if (sel && [rnInterfaceObj respondsToSelector:sel]) {
                // handler:(NSString *jsonStr)
                id(*action)(id,SEL,id) = (id(*)(id,SEL,id))objc_msgSend;
                id data = action(rnInterfaceObj, sel, args);
                if (callBack) callBack([RNBUtil callResult:RNBridgeCallCodeSuccess data:data]);
                return;
            }
          
        } while (0);
    }
    
    if (callBack) callBack([RNBUtil callResult:RNBridgeCallCodeFailure data:@""]);
}


#pragma mark - native call js
-(void)callHandler:(NSString *)methodName arguments:(NSArray *)args {
  [self callHandler:methodName arguments:args completionHandler:nil];
}

-(void)callHandler:(NSString *)methodName
         arguments:(NSArray *)args
 completionHandler:(RNBridgeCallJavascriptCompleteBlock)completionHandler
{
    NSArray *argsArr = args==nil ? @[] : args;
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(callJSHandler:arguments:completionHandler:)]) {
        [self.cDelegate callJSHandler:methodName arguments:argsArr completionHandler:^(id value) {
            if (completionHandler) completionHandler(value);
        }];
    }
}

#pragma mark - getter & setter
- (NSMutableDictionary *)rnInterfacePools {
    if (!_rnInterfacePools) {
        _rnInterfacePools = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    return _rnInterfacePools;
}
@end
