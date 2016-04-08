//
//  YCCollectionViewCell.m
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import "YCCollectionViewCell.h"

@implementation YCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self yc_setupViews];
        [self yc_bindViewModel];
        
    }
    return self;
}

- (void)yc_setupViews {}

- (void)yc_bindViewModel {}

@end
