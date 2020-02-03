//
//  DPEditDinnerOptionViewController.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/24/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPDinnerOption;

@interface DPEditDinnerOptionViewController : UIViewController<UITextViewDelegate>
{
    IBOutlet UITextView *_dinnerDescription;
    IBOutlet UIButton *_datePlanned;
    IBOutlet UIButton *_lastDateServed;
    IBOutlet UIDatePicker *_datePicker;
    IBOutlet UIView *_datePickerView;
    IBOutlet UIButton *_removeFromPlans;
}
-(IBAction) changeDaysOfWeekServed:(id)sender;
-(IBAction) removeFromPlans:(id)sender;
-(IBAction) changeDatePlanned:(id)sender;
-(IBAction) changeLastDateServed:(id)sender;
-(IBAction) donePickingDate:(id)sender;
-(IBAction) cancelEditingDate:(id)sender;
-(IBAction) done:(id)sender;

@property (strong, nonatomic) DPDinnerOption *dinnerOption;
@property BOOL changed;
@property (nonatomic, copy) void(^dismissBlock)(void);

@end
