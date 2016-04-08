//
//  YDViewControllerProtocol.h
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDViewProtocol;

@protocol YDViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <YDViewProtocol>)viewModel;

- (void)yd_bindViewModel;
- (void)yd_addSubviews;
- (void)yd_layoutNavigation;
- (void)yd_getNewData;
- (void)recoverKeyboard;

@end
