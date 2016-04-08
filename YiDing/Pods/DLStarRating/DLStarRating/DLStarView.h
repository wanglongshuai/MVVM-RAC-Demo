/*

    DLStarRating
    Copyright (C) 2011 David Linsin <dlinsin@gmail.com> 

    All rights reserved. This program and the accompanying materials
    are made available under the terms of the Eclipse Public License v1.0
    which accompanies this distribution, and is available at
    http://www.eclipse.org/legal/epl-v10.html

 */

#import <UIKit/UIKit.h>

#define kEdgeInsetBottom 20

@interface DLStarView : UIButton {
    
}

- (id)initWithDefault:(UIImage*)star highlighted:(UIImage*)highlightedStar position:(int)index allowFractions:(BOOL)fractions;
- (void)centerIn:(CGRect)_frame with:(int)numberOfStars;
- (void)setStarImage:(UIImage*)starImage highlightedStarImage:(UIImage*)highlightedImage;
- (UIImage *)croppedImage:(UIImage*)image;
@end
