//
//  LSCircleListCollectionCell.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListCollectionCell.h"
@interface LSCircleListCollectionCell ()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@end
@implementation LSCircleListCollectionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)yd_setupViews {

    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {

    WS(weakSelf)
    CGFloat paddingEdge = 10;
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(weakSelf.contentView);
        make.height.equalTo(80);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.headerImageView.mas_bottom).offset(paddingEdge);
        make.height.equalTo(15);
        make.left.right.equalTo(weakSelf.headerImageView);
    }];
    
    [super updateConstraints];
}

- (void)setViewModel:(LSCircleListCollectionCellViewModel *)viewModel {

    if (!viewModel) {
        
        return;
    }
    
    _viewModel = viewModel;
    
    [self.headerImageView sd_setImageWithURL:URL(viewModel.headerImageStr) placeholderImage:ImageNamed(@"yc_circle_placeHolder.png")];
    self.nameLabel.text = viewModel.name;
}

- (void)setType:(NSString *)type {

    self.headerImageView.image = ImageNamed(@"circle_plus.png");
    self.nameLabel.text = @"加入新圈子";
}

#pragma mark - lazyLoad
- (UIImageView *)headerImageView {

    if (!_headerImageView) {
        
        _headerImageView = [[UIImageView alloc] init];
    }
    
    return _headerImageView;
}

- (UILabel *)nameLabel {

    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = SYSTEMFONT(12);
        _nameLabel.textColor = MAIN_LINE_COLOR;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nameLabel;
}

@end
