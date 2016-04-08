//
//  LSCircleListCollectionCell.h
//  ZhongShui
//
//  Created by 王隆帅 on 16/3/10.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YDCollectionViewCell.h"
#import "LSCircleListCollectionCellViewModel.h"

@interface LSCircleListCollectionCell : YDCollectionViewCell

@property (nonatomic, strong) LSCircleListCollectionCellViewModel *viewModel;

/**
 *  加入新圈子
 */
@property (nonatomic, strong) NSString *type;

@end
