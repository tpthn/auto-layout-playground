//
//  PGRelativeViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/19/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGRelativeViewController.h"

@interface PGRelativeViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *locationPicker;
@property (nonatomic, strong) UILabel *blockLabel;
@property (nonatomic, strong) NSArray *supportedPositions;
@property (nonatomic, strong) NSArray *blockLayout;

@end

@implementation PGRelativeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self.view addSubview:self.locationPicker];
	[self.view addSubview:self.blockLabel];
	
	self.supportedPositions = @[@"Top", @"Bottom", @"Left", @"Right"];
	
	[self.locationPicker selectRow:2 inComponent:0 animated:NO];
	[self.locationPicker ul_fixedSize:CGSizeMake(118, 162)];
	[self.view addConstraints:[self.locationPicker ul_centerAlignWithView:self.view]];
	
	[self placeBlockAtPosition:@"Left"];
}

- (UIPickerView *)locationPicker
{
	if (!_locationPicker) {
		_locationPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
		_locationPicker.delegate = self;
		_locationPicker.dataSource = self;
		_locationPicker.translatesAutoresizingMaskIntoConstraints = NO;
	}
	
	return _locationPicker;
}

- (UILabel *)blockLabel
{
	if (!_blockLabel) {
		_blockLabel = [[UILabel alloc] init];
		_blockLabel.text = @"Code";
		_blockLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		_blockLabel.textAlignment = NSTextAlignmentCenter;
		_blockLabel.textColor = [UIColor blackColor];
		_blockLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	
	return _blockLabel;
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
	
	[self placeBlockAtPosition:supportPosition];
}

#pragma mark - Private

- (void)removeAllConstrain
{
	if ([self.blockLayout count] > 0) {
		[self.view removeConstraints:self.blockLayout];
	}
}

- (void)installAllContrain
{
	if ([self.blockLayout count] > 0) {
		[self.view addConstraints:self.blockLayout];
	}
}

- (void)placeBlockAtPosition:(NSString *)supportPosition
{
	[self removeAllConstrain];
	
	if ([supportPosition isEqualToString:@"Top"]) {
		self.blockLayout = [self.blockLabel ul_verticalAlign:NSLayoutFormatAlignAllCenterX
												 withView:self.locationPicker
												 distance:8
											  topToBottom:YES];
	} else if ([supportPosition isEqualToString:@"Bottom"]) {
		self.blockLayout = [self.blockLabel ul_verticalAlign:NSLayoutFormatAlignAllCenterX
												 withView:self.locationPicker
												 distance:8
											  topToBottom:NO];
	} else if ([supportPosition isEqualToString:@"Left"]) {
		self.blockLayout = [self.blockLabel ul_horizontalAlign:NSLayoutFormatAlignAllCenterY
												   withView:self.locationPicker
												   distance:8
												leftToRight:YES];
	} else {
		self.blockLayout = [self.blockLabel ul_horizontalAlign:NSLayoutFormatAlignAllCenterY
												   withView:self.locationPicker
												   distance:8
												leftToRight:NO];
	}
	
	[self installAllContrain];
}

@end
