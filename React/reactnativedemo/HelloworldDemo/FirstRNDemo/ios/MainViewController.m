//
//  MainViewController.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/3/24.
//

#import "MainViewController.h"
#import "LocalLoadViewController.h"

#import <React/RCTBridge.h>
#import <React/RCTRootView.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  if (@available(iOS 13.0, *)) {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
  } else {
    self.view.backgroundColor = [UIColor whiteColor];
  }
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(100, 100, 100, 40);
  [btn setTitle:@"跳转RN模块" forState:UIControlStateNormal];
  [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
  [self.view addSubview:btn];
  [btn addTarget:self action:@selector(clickHandler) forControlEvents:UIControlEventTouchUpInside];
  
  
  btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(100, 200, 150, 40);
  [btn setTitle:@"跳转-本地加载RN" forState:UIControlStateNormal];
  [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
  [self.view addSubview:btn];
  [btn addTarget:self action:@selector(clickLocalLoadHandler) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickHandler {
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:self.bridge
                                                   moduleName:@"HelloFirstRNDemo"
                                            initialProperties:nil];
  rootView.frame = [UIScreen mainScreen].bounds;
  
  UIViewController *vc = [[UIViewController alloc] init];
  vc.view = rootView;

  [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLocalLoadHandler {
  LocalLoadViewController *vc = [[LocalLoadViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
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
