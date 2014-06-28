//
//  PGMainMenuTableViewController.m
//  PGAutoLayout
//
//  Created by PC Nguyen on 6/28/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGMainMenuTableViewController.h"

typedef enum {
	MainMenuTableRowXibLayout = 0,
	MainMenuTableRowSimpleLayout,
} MainMenuTableRow;

NSString *const PGMainMenuTableViewControllerCellID = @"PGMainMenuTableViewControllerCellID";

@interface PGMainMenuTableViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation PGMainMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSArray *)menuItems
{
	if (!_menuItems) {
		_menuItems = @[@"Xib Layout",
					   @"Simple Layout"];
	}
	
	return _menuItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PGMainMenuTableViewControllerCellID];
    
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PGMainMenuTableViewControllerCellID];
	}
	
	cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"SegueSimpleLayout" sender:self];
}

@end
