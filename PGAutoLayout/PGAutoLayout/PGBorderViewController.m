//
//  PGBorderViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/21/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGBorderViewController.h"
#import "UIView+ALPosition.h"
#import "NSLayoutConstraint+UL.h"

@interface PGBorderViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *locationPicker;
@property (nonatomic, strong) UILabel *blockLabel;
@property (nonatomic, strong) NSArray *supportedPositions;
@property (nonatomic, strong) NSArray *blockLayout;

@end

@implementation PGBorderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.extendedLayoutIncludesOpaqueBars = YES;
	
	[self.view addSubview:self.locationPicker];
	[self.view addSubview:self.blockLabel];
	
	[self.locationPicker fixedSize:CGSizeMake(170, 162)];
	[self.view addConstraints:[self.locationPicker centerAlignWithView:self.view]];
	
	self.supportedPositions = @[@"Top Left",
								@"Top Center",
								@"Top Right",
								@"Left Center",
								@"Right Center",
								@"Bottom Left",
								@"Bottom Center",
								@"Bottom Right",
								@"Stretch Top",
								@"Stretch Left",
								@"Stretch Bottom",
								@"Stretch Right"];
	
	[self placeBlockAtPosition:@"Top Left"];
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
		_blockLabel.backgroundColor = [UIColor blueColor];
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
	for (NSLayoutConstraint *constraint in self.blockLayout) {
		[constraint remove];
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
	
	NSMutableArray *compoundLayouts = [NSMutableArray array];
	
	if ([supportPosition isEqualToString:@"Top Left"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(8, 8, kUIViewUnpinInset, kUIViewUnpinInset)];
	
	} else if ([supportPosition isEqualToString:@"Top Center"]) {
		[compoundLayouts addObjectsFromArray:[self.blockLabel pinWithInset:UIEdgeInsetsMake(8, kUIViewUnpinInset, kUIViewUnpinInset, kUIViewUnpinInset)]];
		[compoundLayouts addObject:[self.blockLabel centerAlignWithView:self.view direction:@"V"]];
		self.blockLayout = compoundLayouts;
	
	} else if ([supportPosition isEqualToString:@"Top Right"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(8, kUIViewUnpinInset, kUIViewUnpinInset, 8)];
	
	} else if ([supportPosition isEqualToString:@"Left Center"]) {
		[compoundLayouts addObjectsFromArray:[self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, 8, kUIViewUnpinInset, kUIViewUnpinInset)]];
		[compoundLayouts addObject:[self.blockLabel centerAlignWithView:self.view direction:@"H"]];
		self.blockLayout = compoundLayouts;
	
	} else if ([supportPosition isEqualToString:@"Right Center"]) {
		[compoundLayouts addObjectsFromArray:[self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, kUIViewUnpinInset, kUIViewUnpinInset, 8)]];
		[compoundLayouts addObject:[self.blockLabel centerAlignWithView:self.view direction:@"H"]];
		self.blockLayout = compoundLayouts;
	
	} else if ([supportPosition isEqualToString:@"Bottom Left"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, 8, 8, kUIViewUnpinInset)];
	
	} else if ([supportPosition isEqualToString:@"Bottom Center"]) {
		[compoundLayouts addObjectsFromArray:[self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, kUIViewUnpinInset, 8, kUIViewUnpinInset)]];
		[compoundLayouts addObject:[self.blockLabel centerAlignWithView:self.view direction:@"V"]];
		self.blockLayout = compoundLayouts;
		
	} else if ([supportPosition isEqualToString:@"Bottom Right"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, kUIViewUnpinInset, 8, 8)];
	
	} else if ([supportPosition isEqualToString:@"Stretch Top"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(8, 8, kUIViewUnpinInset, 8)];
		
	} else if ([supportPosition isEqualToString:@"Stretch Left"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(8, 8, 8, kUIViewUnpinInset)];
		
	} else if ([supportPosition isEqualToString:@"Stretch Right"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(8, kUIViewUnpinInset, 8, 8)];
		
	} else if ([supportPosition isEqualToString:@"Stretch Bottom"]) {
		self.blockLayout = [self.blockLabel pinWithInset:UIEdgeInsetsMake(kUIViewUnpinInset, 8, 8, 8)];
		
	}
	
	[self installAllContrain];
}

@end
