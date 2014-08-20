//
//  NSLayoutConstraint+UL.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/20/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "NSLayoutConstraint+UL.h"
#import "UIView+Hierachy.h"

@implementation NSLayoutConstraint (UL)

- (void)remove
{
	if ([self isUnary]) {
		[[self firstView] removeConstraint:self];
	} else {
		UIView *view = [[self firstView] nearestCommonAncestorToView:[self secondView]];
		
		if (view) {
			[view removeConstraint:self];
		}
	}
}

- (UIView *)firstView
{
	return (UIView *)self.firstItem;
}

- (UIView *)secondView
{
	return (UIView *)self.secondItem;
}

- (BOOL)isUnary
{
	return ([self secondView] == nil);
}

@end
