//
//  LocalLoadViewController.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/24.
//

#import "LocalLoadViewController.h"
#import <React/RCTRootView.h>

@interface LocalLoadViewController ()

@end

@implementation LocalLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.ios.bundle" withExtension:nil];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"HelloFirstRNDemo" initialProperties:nil launchOptions:nil];
  rootView.frame = [UIScreen mainScreen].bounds;
  [self.view addSubview:rootView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
