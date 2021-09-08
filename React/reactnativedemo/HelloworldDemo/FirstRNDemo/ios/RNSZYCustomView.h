//
//  RNSZYCustomView.h
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/5/27.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface RNSZYCustomView : UIView
@property (nonatomic, assign) BOOL touchEnabled;

// 必须以on开头
@property (nonatomic, copy) RCTBubblingEventBlock onClickHandler;
@end

