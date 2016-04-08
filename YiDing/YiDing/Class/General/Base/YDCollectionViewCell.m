//
//  YDCollectionViewCell.m
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YDCollectionViewCell.h"

@implementation YDCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self yd_setupViews];
    }
    return self;
}

- (void)yd_setupViews {}

@end
