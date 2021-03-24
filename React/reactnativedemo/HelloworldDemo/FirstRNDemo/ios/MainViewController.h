//
//  MainViewController.h
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RCTBridge;
@interface MainViewController : UIViewController
@property (nonatomic, strong) RCTBridge *bridge;
@end

NS_ASSUME_NONNULL_END
