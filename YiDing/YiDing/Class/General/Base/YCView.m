//
//  YCView.m
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YCView.h"

@implementation YCView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self yc_setupViews];
        [self yc_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<YCViewModelProtocol>)viewModel {

    self = [super init];
    if (self) {
        
        [self yc_setupViews];
        [self yc_bindViewModel];
    }
    return self;
}

- (void)yc_bindViewModel {
}

- (void)yc_setupViews {
}

- (void)yc_addReturnKeyBoard {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

@end
