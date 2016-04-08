//
//  YDStartAPP.m
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YDStartAPP.h"

@implementation YDStartAPP

+ (void)load {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        [[self class] ls_initPersonData];
        
    });
}

#pragma mark - 初始化个人数据
+ (void)ls_initPersonData {
    
}

@end
