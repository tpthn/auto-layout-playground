//
//  PGRelativeViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/19/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGRelativeViewController.h"

#import "UIView+ALPosition.h"

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
	[self.locationPicker fixedSize:CGSizeMake(118, 162)];
	[self.view addConstraints:[self.locationPicker centerAlignWithView:self.view]];
	
	[self refreshBlockLayoutWithVisualFormat:@"H:[block]-8-[picker]" options:NSLayoutFormatAlignAllCenterY];
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
	
	if ([supportPosition isEqualToString:@"Top"]) {
		[self refreshBlockLayoutWithVisualFormat:@"V:[block]-8-[picker]" options:NSLayoutFormatAlignAllCenterX];
	} else if ([supportPosition isEqualToString:@"Bottom"]) {
		[self refreshBlockLayoutWithVisualFormat:@"V:[picker]-8-[block]" options:NSLayoutFormatAlignAllCenterX];
	} else if ([supportPosition isEqualToString:@"Left"]) {
		[self refreshBlockLayoutWithVisualFormat:@"H:[block]-8-[picker]" options:NSLayoutFormatAlignAllCenterY];
	} else {
		[self refreshBlockLayoutWithVisualFormat:@"H:[picker]-8-[block]" options:NSLayoutFormatAlignAllCenterY];
	}
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

- (void)refreshBlockLayoutWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)option
{
	[self removeAllConstrain];
	
	self.blockLayout = [NSLayoutConstraint constraintsWithVisualFormat:format
															   options:option
															   metrics:nil
																 views:@{@"block":self.blockLabel,
																		 @"picker":self.locationPicker}];
	
	[self installAllContrain];
}

@end
