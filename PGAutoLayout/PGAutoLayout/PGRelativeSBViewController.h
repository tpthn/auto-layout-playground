//
//  PGSimpleLayoutViewController.h
//  PGAutoLayout
//
//  Created by PC Nguyen on 6/28/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGRelativeSBViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *positionPickerView;

@end
