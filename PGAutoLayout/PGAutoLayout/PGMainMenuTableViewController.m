//
//  PGMainMenuTableViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 6/28/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGMainMenuTableViewController.h"
#import "PGRelativeXibViewController.h"
#import "PGRelativeViewController.h"
#import "PGBorderViewController.h"

#define kPGMainMenuTableViewControllerXibKey				@"Xib Layout"
#define kPGMainMenuTableViewControllerStoryboardKey			@"Storyboard Layout"
#define kPGMainMenuTableViewControllerProgrammaticKey		@"Programmatic Layout"

#define kPGMainMenuTableViewControllerBorderLayout				@"Border Layout"
#define kPGMainMenuTableViewControllerRelativeLayout			@"Relative Layout"

typedef enum {
	MainMenuTableSectionXib = 0,
	MainMenuTableSectionStoryBoard,
	MainMenuTableSectionProgrammatic,
} MainMenuTableSection;

typedef enum {
	MainMenuTableRowBorderLayout = 0,
	MainMenuTableRowRelativeLayout,
} MainMenuTableRow;

NSString *const PGMainMenuTableViewControllerCellID = @"PGMainMenuTableViewControllerCellID";

@interface PGMainMenuTableViewController ()

@property (nonatomic, strong) NSDictionary *menuItems;

@end

@implementation PGMainMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSDictionary *)menuItems
{
	if (!_menuItems) {
		_menuItems = @{kPGMainMenuTableViewControllerXibKey : @[kPGMainMenuTableViewControllerBorderLayout,
																kPGMainMenuTableViewControllerRelativeLayout],
					   kPGMainMenuTableViewControllerStoryboardKey : @[kPGMainMenuTableViewControllerBorderLayout,
																	   kPGMainMenuTableViewControllerRelativeLayout],
					   kPGMainMenuTableViewControllerProgrammaticKey: @[kPGMainMenuTableViewControllerBorderLayout,
																		kPGMainMenuTableViewControllerRelativeLayout]};
	}
	
	return _menuItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.menuItems allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *key = [self keyForSection:section];
	NSInteger count = [[self.menuItems valueForKey:key] count];
	
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PGMainMenuTableViewControllerCellID];
    
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PGMainMenuTableViewControllerCellID];
	}
	
	NSString *key = [self keyForSection:indexPath.section];
	NSArray *labels = [self.menuItems valueForKey:key];
	cell.textLabel.text = [labels objectAtIndex:indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger section = indexPath.section;
	
	switch (section) {
		case MainMenuTableSectionStoryBoard:
			[self loadRelativeStoryBoard];
			break;
		case MainMenuTableSectionXib:
			[self loadRelativeXibController];
			break;
		case MainMenuTableSectionProgrammatic:
			if (indexPath.row == 0) {
				[self loadBorderViewController];
			} else {
				[self loadRelativeController];
			}
			break;
		default:
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *title = [self keyForSection:section];
	return title;
}

#pragma mark - Private

- (NSString *)keyForSection:(NSInteger)section
{
	NSString *key = @"";
	
	switch (section) {
		case MainMenuTableSectionXib:
			key = kPGMainMenuTableViewControllerXibKey;
			break;
		case MainMenuTableSectionStoryBoard:
			key = kPGMainMenuTableViewControllerStoryboardKey;
			break;
		case MainMenuTableSectionProgrammatic:
			key = kPGMainMenuTableViewControllerProgrammaticKey;
			break;
		default:
			break;
	}
	
	return key;
}

#pragma mark - Action Factory

- (void)loadRelativeStoryBoard
{
	[self performSegueWithIdentifier:@"SegueRelativeLayout" sender:self];
}

- (void)loadRelativeXibController
{
	PGRelativeXibViewController *xibController = [[PGRelativeXibViewController alloc] init];
	
	[self.navigationController pushViewController:xibController animated:YES];
}

- (void)loadRelativeController
{
	PGRelativeViewController *viewController = [[PGRelativeViewController alloc] init];
	
	[self.navigationController pushViewController:viewController animated:YES];
}

- (void)loadBorderViewController
{
	PGBorderViewController *viewCOntroller = [[PGBorderViewController alloc] init];
	
	[self.navigationController pushViewController:viewCOntroller animated:YES];
}

@end
