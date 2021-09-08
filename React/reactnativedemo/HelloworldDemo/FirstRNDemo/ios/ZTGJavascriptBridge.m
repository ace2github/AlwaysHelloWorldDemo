//
//  ZTGJavascriptBridge.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/5/18.
//

#import "ZTGJavascriptBridge.h"
#import "RNBUtil.h"
@implementation ZTGJavascriptBridge
- (void)jumpTo:(id)json :(void (^)(NSString * _Nullable result, BOOL complete))completionHandler {
  if ([json isKindOfClass:[NSString class]]) {
    NSLog(@"%s %@", __func__,[RNBUtil jsonStringToObject:json]);
  }
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if (completionHandler) completionHandler(@"success", YES);
  });
}
@end
