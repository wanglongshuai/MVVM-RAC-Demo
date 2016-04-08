//
//  YCRequestProtocol.h
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCRequestProtocol <NSObject>

@optional

/**
 *  代理去处理刷新状态
 *
 *  @param type 1 下拉 有更多数据  2 下拉 无更多数据 3 上拉 有更多数据 4 上拉 无更多数据 5 刷新出错
 */
- (void)ls_reloadDataWithType:(NSInteger)type;

@end
