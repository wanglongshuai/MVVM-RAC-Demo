//
//  LSCircleListHeaderViewModel.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListHeaderViewModel.h"

@implementation LSCircleListHeaderViewModel

- (NSArray *)dataArray {

    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}

- (RACSubject *)refreshUISubject {

    if (!_refreshUISubject) {
        
        _refreshUISubject = [RACSubject subject];
    }
    
    return _refreshUISubject;
}

- (RACSubject *)cellClickSubject {

    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}

@end
