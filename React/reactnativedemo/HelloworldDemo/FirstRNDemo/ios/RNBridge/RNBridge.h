//
//  RNBridge.h
//  dsbridge
//
//  Created by ChaohuiChen on 2021/5/14.
//  Copyright © 2021 杜文. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RNBridgeCallBack)(NSString *result);
typedef void(^RNBridgeInnerCallBack)(NSString *result, BOOL complete);
typedef void(^RNBridgeCallJavascriptCompleteBlock)(id value);

@protocol RNBridgeDelegate;
@interface RNBridge : NSObject
@property (nonatomic, weak) id<RNBridgeDelegate> cDelegate;

- (void)addReactNativeObject:(id)object ns:(NSString *)ns;

- (void)removeReactNativeObject:(NSString *)ns;

/*
 * method
    同步方法：handler(NSString *jsonStr)
    异步方法：handler(NSString *jsonStr, (id value, BOOL complete)callBack)
 */
- (void)callMethod:(NSString *)method args:(id)args callBack:(RNBridgeCallBack)callBack
;

/*
 call rn method
 */
-(void)callHandler:(NSString *)methodName arguments:(NSArray *)args completionHandler:(RNBridgeCallJavascriptCompleteBlock)completionHandler;
@end

@protocol RNBridgeDelegate <NSObject>
-(void)callJSHandler:(NSString *)methodName
           arguments:(NSArray *)args
   completionHandler:(RNBridgeCallJavascriptCompleteBlock)completionHandler;
@end

