//
//  PGSimpleLayoutViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 6/28/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGRelativeSBViewController.h"

@interface PGRelativeSBViewController ()

@property (nonatomic, strong) NSArray *supportedPositions;

@property (weak, nonatomic) IBOutlet UIPickerView *positionPickerView;

@property (weak, nonatomic) IBOutlet UILabel *blockLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alignmentConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spacingConstraint;

@end

@implementation PGRelativeSBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.supportedPositions = @[@"Top", @"Bottom", @"Left", @"Right"];
	
	[self.positionPickerView selectRow:2 inComponent:0 animated:NO];
}

#pragma mark - UIPickerView Delegate / DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.supportedPositions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.supportedPositions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *supportPosition = [self.supportedPositions objectAtIndex:row];
	
	[self resetConstraint];
	
	if ([supportPosition isEqualToString:@"Top"]) {
		[self adjustAlignmentConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																	 attribute:NSLayoutAttributeCenterX
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.positionPickerView
																	 attribute:NSLayoutAttributeCenterX
																	multiplier:1.0f
																	  constant:0.0f]];
		[self adjustSpacingConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																   attribute:NSLayoutAttributeBottom
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.positionPickerView
																   attribute:NSLayoutAttributeTop
																  multiplier:1.0f constant:-8.0f]];
	} else if ([supportPosition isEqualToString:@"Bottom"]) {
		[self adjustAlignmentConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																	 attribute:NSLayoutAttributeCenterX
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.positionPickerView
																	 attribute:NSLayoutAttributeCenterX
																	multiplier:1.0f
																	  constant:0.0f]];
		[self adjustSpacingConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																   attribute:NSLayoutAttributeTop
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.positionPickerView
																   attribute:NSLayoutAttributeBottom
																  multiplier:1.0f constant:8.0f]];
	} else if ([supportPosition isEqualToString:@"Left"]) {
		[self adjustAlignmentConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																	 attribute:NSLayoutAttributeCenterY
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.positionPickerView
																	 attribute:NSLayoutAttributeCenterY
																	multiplier:1.0f
																	  constant:0.0f]];
		[self adjustSpacingConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																   attribute:NSLayoutAttributeTrailing
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.positionPickerView
																   attribute:NSLayoutAttributeLeading
																  multiplier:1.0f
																	constant:-8.0f]];
	} else {
		[self adjustAlignmentConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																	 attribute:NSLayoutAttributeCenterY
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.positionPickerView
																	 attribute:NSLayoutAttributeCenterY
																	multiplier:1.0f
																	  constant:0.0f]];
		[self adjustSpacingConstraint:[NSLayoutConstraint constraintWithItem:self.blockLabel
																   attribute:NSLayoutAttributeLeading
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.positionPickerView
																   attribute:NSLayoutAttributeTrailing
																  multiplier:1.0f
																	constant:8.0f]];
	}
}

#pragma mark - Reset Constraint

- (void)resetConstraint
{
	[self.view removeConstraint:self.alignmentConstraint];
	[self.view removeConstraint:self.spacingConstraint];
}

- (void)adjustSpacingConstraint:(NSLayoutConstraint *)constraint
{
	self.spacingConstraint = constraint;
	[self.view addConstraint:self.spacingConstraint];
}

- (void)adjustAlignmentConstraint:(NSLayoutConstraint *)constraint
{
	self.alignmentConstraint = constraint;
	[self.view addConstraint:self.alignmentConstraint];
}

@end
