//
//  LSCircleListViewModel.h
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YDViewModel.h"
#import "LSCircleListHeaderViewModel.h"
#import "LSCircleListSectionHeaderViewModel.h"

@interface LSCircleListViewModel : YDViewModel

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) LSCircleListHeaderViewModel *listHeaderViewModel;

@property (nonatomic, strong) LSCircleListSectionHeaderViewModel *sectionHeaderViewModel;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
