//
//  UIView+Hierachy.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/20/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "UIView+Hierachy.h"

@implementation UIView (Hierachy)

- (NSArray *)superviews
{
	NSMutableArray *array = [NSMutableArray array];
	UIView *view = self.superview;
	while (view) {
		[array addObject:view];
		view = view.superview;
	}
	
	return array;
}

- (BOOL)isAncestorOfView:(UIView *)view
{
	return [[view superviews] containsObject:self];
}

- (UIView *)nearestCommonAncestorToView:(UIView *)view
{
	// Check for same view
	if ([self isEqual:view]) {
		return self;
	}
	
	// Check for direct superview relationship
	if ([self isAncestorOfView:view]) {
		return self;
	}
	
	if ([view isAncestorOfView:self]) {
		return view;
	}
	
	// Search for indirect common ancestor
	NSArray *ancestors = [self superviews];
	for (UIView *superView in [view superviews]) {
		if ([ancestors containsObject:superView]) {
			return superView;
		}
	}
	
	// No common ancestor
	return nil;
}

@end
