//
//  YDViewProtocol.h
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDViewModelProtocol;

@protocol YDViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <YDViewModelProtocol>)viewModel;

/**
 *  添加控件
 *  最好最后加上[self setNeedsUpdateConstraints]和[self updateConstraintsIfNeeded]，以防不调用updateConstraints，但是若view的controller已经调用setNeedsUpdateConstraints和updateConstraintsIfNeeded，则这里可以不用加上这些
 */
- (void)yd_setupViews;

/**
 *  更新约束
 *  一定要在最后调用[super updateConstraints]
 */
- (void)yd_updateConstraints;

/**
 *  绑定
 */
- (void)yd_bindViewModel;

- (void)yd_addReturnKeyBoard;

@end

