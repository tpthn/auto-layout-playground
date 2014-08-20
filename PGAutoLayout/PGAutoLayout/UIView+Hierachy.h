//
//  UIView+Hierachy.h
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/20/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Hierachy)

- (UIView *)nearestCommonAncestorToView:(UIView *)view;

@end
