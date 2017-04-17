//
//  YDViewControllerProtocol.h
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDViewModelProtocol;

@protocol YDViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <YDViewModelProtocol>)viewModel;

/**
 *  添加控件
 *  最好最后加上[self.view setNeedsUpdateConstraints]和[self.view updateConstraintsIfNeeded]，以防不调用updateViewConstraints
 */
- (void)yd_addSubviews;

/**
 *  更新约束
 */
- (void)yd_updateViewConstraints;

/**
 *  绑定
 */
- (void)yd_bindViewModel;

/**
 *  设置navation
 */
- (void)yd_layoutNavigation;

/**
 *  初次获取数据
 */
- (void)yd_getNewData;

- (void)recoverKeyboard;

@end
