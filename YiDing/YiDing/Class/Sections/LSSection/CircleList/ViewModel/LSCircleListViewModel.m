//
//  LSCircleListViewModel.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListViewModel.h"
#import "LSCircleListCollectionCellViewModel.h"

@interface LSCircleListViewModel ()

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation LSCircleListViewModel

- (void)yd_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        
        NSMutableArray *alArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            
            LSCircleListCollectionCellViewModel *viewModel = [[LSCircleListCollectionCellViewModel alloc] init];
            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"财税培训圈子";
            [alArray addObject:viewModel];
        }
        
        self.listHeaderViewModel.dataArray = alArray;
        
        NSMutableArray *reArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            
            LSCircleListCollectionCellViewModel *viewModel = [[LSCircleListCollectionCellViewModel alloc] init];
            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"财税培训圈子";
            viewModel.articleNum = @"1568";
            viewModel.peopleNum = @"568";
            viewModel.topicNum = @"5749";
            viewModel.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        
        [self.listHeaderViewModel.refreshUISubject sendNext:nil];
        [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            ShowMaskStatus(@"正在加载");
        }
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        
        NSMutableArray *reArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        for (int i = 0; i < 8; i++) {
            
            LSCircleListCollectionCellViewModel *viewModel = [[LSCircleListCollectionCellViewModel alloc] init];
            viewModel.headerImageStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            viewModel.name = @"财税培训圈子";
            viewModel.articleNum = @"1568";
            viewModel.peopleNum = @"568";
            viewModel.topicNum = @"5749";
            viewModel.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        DismissHud();
    }];
    
}

- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    
    return _refreshEndSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                self.currentPage = 1;
                [self.request POST:REQUEST_URL parameters:nil success:^(CMRequest *request, NSString *responseString) {
                    
                    NSDictionary *dict = [responseString objectFromJSONString];
                    [subscriber sendNext:dict];
                    [subscriber sendCompleted];
                    
                } failure:^(CMRequest *request, NSError *error) {
                    
                    ShowErrorStatus(@"网络连接失败");
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}

- (RACCommand *)nextPageCommand {
    
    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                self.currentPage ++;
                [self.request POST:REQUEST_URL parameters:nil success:^(CMRequest *request, NSString *responseString) {
                    
                    NSDictionary *dict = [responseString objectFromJSONString];
                    [subscriber sendNext:dict];
                    [subscriber sendCompleted];
                    
                } failure:^(CMRequest *request, NSError *error) {
                    
                    @strongify(self);
                    self.currentPage --;
                    ShowErrorStatus(@"网络连接失败");
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    
    return _nextPageCommand;
}

- (LSCircleListHeaderViewModel *)listHeaderViewModel {
    
    if (!_listHeaderViewModel) {
        
        _listHeaderViewModel = [[LSCircleListHeaderViewModel alloc] init];
        _listHeaderViewModel.title = @"已加入的圈子";
        _listHeaderViewModel.cellClickSubject = self.cellClickSubject;
    }
    
    return _listHeaderViewModel;
}

- (LSCircleListSectionHeaderViewModel *)sectionHeaderViewModel {
    
    if (!_sectionHeaderViewModel) {
        
        _sectionHeaderViewModel = [[LSCircleListSectionHeaderViewModel alloc] init];
        _sectionHeaderViewModel.title = @"推荐圈子";
    }
    
    return _sectionHeaderViewModel;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}

- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}

@end
