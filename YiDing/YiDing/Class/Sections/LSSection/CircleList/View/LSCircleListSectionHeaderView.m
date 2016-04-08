//
//  LSCircleListSectionHeaderView.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListSectionHeaderView.h"
#import "LSCircleListSectionHeaderViewModel.h"

@interface LSCircleListSectionHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) LSCircleListSectionHeaderViewModel *viewModel;

@end
@implementation LSCircleListSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithViewModel:(id<YDViewModelProtocol>)viewModel {

    self.viewModel = (LSCircleListSectionHeaderViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)yd_setupViews {

    [self addSubview:self.bgImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineImageView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

- (void)updateConstraints {

    WS(weakSelf)
    CGFloat paddingEdge = 10;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(paddingEdge);
        make.right.equalTo(-paddingEdge);
        make.height.equalTo(20);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(1.0);
    }];
    
    [super updateConstraints];
}

- (void)yd_bindViewModel {

    RAC(self.titleLabel, text) = [[RACObserve(self, viewModel.title) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal];
}

#pragma mark - lazyLoad
- (UIImageView *)bgImageView {

    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = white_color;
    }
    
    return _bgImageView;
}

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SYSTEMFONT(17);
        _titleLabel.textColor = MAIN_BLACK_TEXT_COLOR;
    }
    
    return _titleLabel;
}

- (UIImageView *)lineImageView {

    if (!_lineImageView) {
        
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = MAIN_LINE_COLOR;
    }
    
    return _lineImageView;
}

@end
