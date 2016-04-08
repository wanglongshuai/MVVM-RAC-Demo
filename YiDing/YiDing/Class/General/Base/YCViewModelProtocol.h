//
//  YCViewModelProtocol.h
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

@property (strong, nonatomic)CMRequest *request;

@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, copy) NSString *currentVCName;
/**
 *  0 不需要更新 1 需要更新
 */
@property (nonatomic, copy) NSString *canLayOutUI;

/**
 *  初始化
 */
- (void)yc_initialize;

/**
 *  下拉刷新
 */
- (void)yc_refreshData;

/**
 *  上拉加载
 */
- (void)yc_addNextPageData;
/**
 *  更新UI
 */
- (void)yc_refreshUI;

@end
