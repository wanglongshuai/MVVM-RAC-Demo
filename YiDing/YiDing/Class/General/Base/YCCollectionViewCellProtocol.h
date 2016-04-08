//
//  YCCollectionViewCellProtocol.h
//  RenCheRen
//
//  Created by 王隆帅 on 15/12/22.
//  Copyright © 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCCollectionViewCellProtocol <NSObject>

@optional

- (void)yc_setupViews;
- (void)yc_bindViewModel;

@end
