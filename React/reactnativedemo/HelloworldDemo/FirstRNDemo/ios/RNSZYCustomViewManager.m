//
//  RNSZYCustomViewManager.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/5/27.
//

#import "RNSZYCustomViewManager.h"

@implementation RNSZYCustomViewManager
RCT_EXPORT_MODULE(RNSZYView)

- (UIView *)view {
  return [[RNSZYCustomView alloc] init];
}

// 定义属性
RCT_EXPORT_VIEW_PROPERTY(touchEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onClickHandler, RCTBubblingEventBlock)

@end
