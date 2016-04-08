//
//  YCViewModel.m
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YCViewModel.h"

@implementation YCViewModel

@synthesize errors   = _errors;
@synthesize request  = _request;
@synthesize currentVCName = _currentVCName;
@synthesize canLayOutUI = _canLayOutUI;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    YCViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel yc_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (RACSubject *)errors {
    
    if (!_errors) {
        
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (CMRequest *)request {
    
    if (!_request) {
        
        _request = [CMRequest request];
    }
    return _request;
}

- (NSString *)currentVCName {
    
    if (!_currentVCName) {
        
        _currentVCName = @"";
    }
    
    return _currentVCName;
}

- (void)yc_initialize {}

- (void)yc_refreshData {}

- (void)yc_addNextPageData {}


@end
