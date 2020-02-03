//
//  DPDaysOfTheWeek.h
//  DinnerPlans
//
//  Created by Ana Muniz on 10/4/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDaysOfWeek;

@interface DPDaysOfTheWeekViewController : UIViewController
{
    IBOutlet UISwitch * sunday;
    IBOutlet UISwitch * monday;
    IBOutlet UISwitch * tuesday;
    IBOutlet UISwitch * wednesday;
    IBOutlet UISwitch * thursday;
    IBOutlet UISwitch * friday;
    IBOutlet UISwitch * saturday;
    IBOutlet UIButton * doneButton;
    IBOutlet UILabel *titleLabel;
    
}
@property bool isModal;
@property (nonatomic, strong) DPDaysOfWeek * daysOfWeek;
@property (nonatomic, copy) void(^dismissBlock)(void);
@property (nonatomic, copy) NSString *title;

-(IBAction)Done:(id)sender;
@end
