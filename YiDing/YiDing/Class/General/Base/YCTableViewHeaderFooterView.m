//
//  YCTableViewHeaderFooterView.m
//  RenCheRen
//
//  Created by 王隆帅 on 16/2/23.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "YCTableViewHeaderFooterView.h"

@implementation YCTableViewHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self yc_setupViews];
    }
    return self;
}

- (void)yc_setupViews{}

@end
