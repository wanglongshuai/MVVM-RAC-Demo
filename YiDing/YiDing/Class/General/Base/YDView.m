//
//  YDView.m
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YDView.h"

@implementation YDView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    YDView *view = [super allocWithZone:zone];
    
    @weakify(view)
    
    [[view rac_signalForSelector:@selector(updateConstraints)] subscribeNext:^(id x) {
        @strongify(view)
        [view yd_updateConstraints];
    }];
    
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self yd_setupViews];
        [self yd_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<YDViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self yd_setupViews];
        [self yd_bindViewModel];
    }
    return self;
}

#pragma mark - YDViewProtocol
- (void)yd_bindViewModel {
}

- (void)yd_setupViews {
}

/**
 *  更新约束
 *  一定要在最后调用[super updateConstraints]
 */
- (void)yd_updateConstraints {}

- (void)yd_addReturnKeyBoard {
    
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
