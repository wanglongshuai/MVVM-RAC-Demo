//
//  YDTableVIewCellProtocol.h
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDTableVIewCellProtocol <NSObject>
@optional

- (void)yd_setupViews;
- (void)yd_bindViewModel;

@end
