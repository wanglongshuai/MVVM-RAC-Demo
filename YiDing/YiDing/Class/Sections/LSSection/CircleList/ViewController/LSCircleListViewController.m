//
//  LSCircleListViewController.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListViewController.h"
#import "LSCircleListView.h"
#import "LSCircleListViewModel.h"

@interface LSCircleListViewController ()

@property (nonatomic, strong) LSCircleListView *mainView;

@property (nonatomic, strong) LSCircleListViewModel *viewModel;

@end

@implementation LSCircleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - system
- (void)updateViewConstraints {
    
    WS(weakSelf)
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - private
- (void)yd_addSubviews {
    
    [self.view addSubview:self.mainView];
}

- (void)yd_bindViewModel {
    
    @weakify(self);
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        YDViewController *circleMainVC = [[YDViewController alloc] init];
        [self.navigationController pushViewController:circleMainVC animated:YES];
    }];
}

- (void)yd_layoutNavigation {
    
    self.title = @"圈子列表";
}

#pragma mark - layzLoad
- (LSCircleListView *)mainView {
    
    if (!_mainView) {
        
        _mainView = [[LSCircleListView alloc] initWithViewModel:self.viewModel];
    }
    
    return _mainView;
}

- (LSCircleListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[LSCircleListViewModel alloc] init];
    }
    
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
