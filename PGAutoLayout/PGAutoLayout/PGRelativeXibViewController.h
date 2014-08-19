//
//  PGRelativeXibViewController.h
//  PGAutoLayout
//
//  Created by PC Nguyen on 8/13/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGRelativeXibViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (weak, nonatomic) IBOutlet UILabel *blockLabel;

@end
