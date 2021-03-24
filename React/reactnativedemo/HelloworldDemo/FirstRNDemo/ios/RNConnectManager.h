//
//  RNConnectManager.h
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import<React/RCTBridgeModule.h>

@interface RNConnectManager : RCTEventEmitter <RCTBridgeModule>

- (void)startInit:(NSString *)msg;
- (void)startLogin;
@end

