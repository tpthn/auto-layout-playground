//
//  UIView+ALPosition.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/20/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "UIView+ALPosition.h"

@implementation UIView (ALPosition)

#pragma mark - Configure

- (void)enableAutoLayout
{
	self.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)disableAutoLayout
{
	self.translatesAutoresizingMaskIntoConstraints = YES;
}

#pragma mark - Sizing

- (NSArray *)fixedSize:(CGSize)size
{
	NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==width)]"
																		options:0
																		metrics:@{@"width":@(size.width)}
																		  views:@{@"view":self}];
	NSArray *heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==height)]"
																		options:0
																		metrics:@{@"height":@(size.height)}
																		  views:@{@"view":self}];
	
	NSMutableArray *sizeArray = [NSMutableArray array];
	[sizeArray addObjectsFromArray:widthConstraints];
	[sizeArray addObjectsFromArray:heightConstraint];
	
	[self addConstraints:sizeArray];
	
	return sizeArray;
}

- (NSMutableArray *)matchSizeOfView:(UIView *)view ratio:(CGSize)sizeRatio
{
	NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self
																	   attribute:NSLayoutAttributeWidth
																	   relatedBy:NSLayoutRelationEqual
																		  toItem:view
																	   attribute:NSLayoutAttributeWidth
																	  multiplier:sizeRatio.width
																		constant:0.0f];
	NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
																		attribute:NSLayoutAttributeHeight
																		relatedBy:NSLayoutRelationEqual
																		   toItem:view
																		attribute:NSLayoutAttributeHeight
																	   multiplier:sizeRatio.height
																		 constant:0.0f];
	
	NSMutableArray *sizeArray = [NSMutableArray arrayWithObjects:widthConstraint, heightConstraint, nil];
	[self addConstraints:sizeArray];
	
	return sizeArray;
}

#pragma mark - Alignment

- (NSMutableArray *)horizontalAlign:(NSLayoutFormatOptions)alignmentOption
						   withView:(UIView *)siblingView
						   distance:(NSInteger)distance
						leftToRight:(BOOL)isLeftToRight
{
	return [self alignDirection:@"H"
				alignmentOption:alignmentOption
					   withView:siblingView
					   distance:distance
				   naturalOrder:isLeftToRight];
}

- (NSMutableArray *)verticalAlign:(NSLayoutFormatOptions)alignmentOption
						 withView:(UIView *)siblingView
						 distance:(NSInteger)distance
					  topToBottom:(BOOL)isTopToBottom
{
	return [self alignDirection:@"V"
				alignmentOption:alignmentOption
					   withView:siblingView
					   distance:distance
				   naturalOrder:isTopToBottom];
}

- (NSMutableArray *)centerAlignWithView:(UIView *)view
{
	NSLayoutConstraint *horizontalConstraint = [self centerAlignWithView:view direction:@"H"];
	NSLayoutConstraint *verticalConstraint = [self centerAlignWithView:view direction:@"V"];
	NSMutableArray *allignmentArray = [NSMutableArray arrayWithObjects:horizontalConstraint, verticalConstraint, nil];
	
	return allignmentArray;
}

- (NSLayoutConstraint *)centerAlignWithView:(UIView *)view direction:(NSString *)direction
{
	NSLayoutAttribute attribute = NSLayoutAttributeCenterX;
	
	if ([direction isEqualToString:@"H"]) {
		attribute = NSLayoutAttributeCenterY;
	}
	
	NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self
																		attribute:attribute
																		relatedBy:NSLayoutRelationEqual
																		   toItem:view
																		attribute:attribute
																	   multiplier:1.0f
																		 constant:0.0f];
	return layoutConstraint;
}

#pragma mark - Containment

- (NSMutableArray *)pinWithInset:(UIEdgeInsets)inset
{
	NSArray *topConstraint = [self constraintsForPinDistance:inset.top direction:@"V" naturalOrder:YES];
	NSArray *bottomConstraint = [self constraintsForPinDistance:inset.bottom direction:@"V" naturalOrder:NO];
	NSArray *leftConstraint = [self constraintsForPinDistance:inset.left direction:@"H" naturalOrder:YES];
	NSArray *rightConstraint = [self constraintsForPinDistance:inset.right direction:@"H" naturalOrder:NO];
	
	NSMutableArray *alignmentArray = [NSMutableArray array];
	[alignmentArray addObjectsFromArray:topConstraint];
	[alignmentArray addObjectsFromArray:bottomConstraint];
	[alignmentArray addObjectsFromArray:leftConstraint];
	[alignmentArray addObjectsFromArray:rightConstraint];	
	return alignmentArray;
}

#pragma mark - Reset

- (void)removePositionConstraints
{
	
}

#pragma mark - Private

- (NSMutableArray *)alignDirection:(NSString *)direction
				   alignmentOption:(NSLayoutFormatOptions)alignmentOption
						  withView:(UIView *)siblingView
						  distance:(NSInteger)distance
					  naturalOrder:(BOOL)isNaturalOrder
{
	NSString *spacer = @"-";
	NSString *firstView =@"view";
	NSString *secondView = @"otherView";
	
	NSDictionary *metrics = nil;
	
	if (distance != kUIViewAquaDistance) {
		spacer = @"-distance-";
		metrics = @{@"distance":@(distance)};
	}
	
	if (!isNaturalOrder) {
		firstView = @"otherView";
		secondView = @"view";
	}
	
	NSString *formatLayout = [NSString stringWithFormat:@"%@:[%@]%@[%@]",direction, firstView, spacer, secondView];
	NSArray *layouts = [NSLayoutConstraint constraintsWithVisualFormat:formatLayout
															   options:alignmentOption
															   metrics:metrics
																 views:@{@"view":self, @"otherView":siblingView}];
	
	NSMutableArray *alignmentArray = [NSMutableArray arrayWithArray:layouts];
	return alignmentArray;
}

- (NSArray *)constraintsForPinDistance:(NSInteger)distance
							 direction:(NSString *)direction
						  naturalOrder:(BOOL)isNaturalOrder
{
	NSArray *layoutConstraint = [NSArray array];
	
	if (distance != kUIViewUnpinInset) {
		NSString *spacer = @"-";
		NSString *firstView = @"|";
		NSString *secondView = @"[view]";
		NSDictionary *metrics = nil;
		
		if (distance != kUIViewAquaDistance) {
			spacer = @"-distance-";
			metrics = @{@"distance":@(distance)};
		}
		
		if (!isNaturalOrder) {
			firstView = @"[view]";
			secondView = @"|";
		}
		
		NSString *formatLayout = [NSString stringWithFormat:@"%@:%@%@%@", direction, firstView, spacer, secondView];
		layoutConstraint = [NSLayoutConstraint constraintsWithVisualFormat:formatLayout
																   options:0
																   metrics:metrics
																	 views:@{@"view": self}];
	}
	
	return layoutConstraint;
}

@end
