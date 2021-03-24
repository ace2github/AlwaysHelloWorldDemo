#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>
#import "RNConnectManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>
@property (nonatomic, strong) RNConnectManager *rnConector;
@property (nonatomic, strong) UIWindow *window;

@end
