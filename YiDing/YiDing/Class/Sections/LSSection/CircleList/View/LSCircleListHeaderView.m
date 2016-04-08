//
//  LSCircleListHeaderView.m
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSCircleListHeaderView.h"
#import "LSCircleListHeaderViewModel.h"
#import "LSCircleListCollectionCell.h"

@interface LSCircleListHeaderView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) LSCircleListHeaderViewModel *viewModel;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation LSCircleListHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithViewModel:(id<YDViewModelProtocol>)viewModel {

    self.viewModel = (LSCircleListHeaderViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)yd_setupViews {

    [self addSubview:self.bgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {

    WS(weakSelf)
    CGFloat paddingEdge = 10;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(weakSelf);
        make.bottom.equalTo(-paddingEdge);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(paddingEdge);
        make.top.equalTo(paddingEdge);
        make.right.equalTo(-paddingEdge);
        make.height.equalTo(20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-paddingEdge);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(paddingEdge);
    }];
    
    [super updateConstraints];
}

- (void)yd_bindViewModel {

    @weakify(self);
    [[self.viewModel.refreshUISubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    RAC(self.titleLabel, text) = [[RACObserve(self, viewModel.title) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal];
}

#pragma mark - lazyLoad
- (LSCircleListHeaderViewModel *)viewModel {

    if (!_viewModel) {
        
        _viewModel = [[LSCircleListHeaderViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UIView *)bgView {

    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = white_color;
    }
    
    return _bgView;
}

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MAIN_BLACK_TEXT_COLOR;
        _titleLabel.font = SYSTEMFONT(15);
    }
    
    return _titleLabel;
}

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.collectionViewLayout = self.flowLayout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = white_color;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[LSCircleListCollectionCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([LSCircleListCollectionCell class])]];

    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {

    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.minimumLineSpacing = 10;
    }
    
    return _flowLayout;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.viewModel.dataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCircleListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([LSCircleListCollectionCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    if (self.viewModel.dataArray.count == indexPath.row) {
        
        cell.type = @"加入新圈子";
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(80, 105);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.viewModel.cellClickSubject sendNext:nil];
}

@end
