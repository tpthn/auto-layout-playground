//
//  UIView+ALPosition.h
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/20/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger kUIViewAquaDistance	= -1;
static NSInteger kUIViewUnpinInset		= 0;

@interface UIView (ALPosition)

#pragma mark - Configure

- (void)enableAutoLayout;
- (void)disableAutoLayout;

#pragma mark - Sizing

- (NSMutableArray *)fixedSize:(CGSize)size;
- (NSMutableArray *)matchSizeOfView:(UIView *)view ratio:(CGSize)sizeRatio;

#pragma mark - Alignment

- (NSMutableArray *)horizontalAlign:(NSLayoutFormatOptions)alignmentOption
						   withView:(UIView *)siblingView
						   distance:(NSInteger)distance
						leftToRight:(BOOL)isLeftToRight;

- (NSMutableArray *)verticalAlign:(NSLayoutFormatOptions)alignmentOption
						 withView:(UIView *)siblingView
						 distance:(NSInteger)distance
					  topToBottom:(BOOL)isTopToBottom;

- (NSMutableArray *)centerAlignWithView:(UIView *)view;

#pragma mark - Containment

- (NSMutableArray *)pinWithInset:(UIEdgeInsets)inset;

@end
