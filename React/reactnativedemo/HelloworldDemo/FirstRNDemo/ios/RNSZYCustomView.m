//
//  RNSZYCustomView.m
//  FirstRNDemo
//
//  Created by ChaohuiChen on 2021/5/27.
//

#import "RNSZYCustomView.h"

@implementation RNSZYCustomView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self __initSubviewes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self __initSubviewes];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self __initSubviewes];
}

- (void)__initSubviewes {
  self.backgroundColor = UIColor.orangeColor;
  self.frame = CGRectMake(0, 0, 100, 50);
  
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHandler)];
  self.userInteractionEnabled = YES;
  [self addGestureRecognizer:tapper];
}

- (void)didClickHandler {
  if (self.onClickHandler) self.onClickHandler(@{@"event":@123});
}
@end
