//
//  DPEditDinnerOptionViewController.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/24/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPEditDinnerOptionViewController.h"
#import "DPDaysOfTheWeekViewController.h"
#import "NSString+StringExtensions.h"
#import "DPScheduler.h"
#import "dpdinnerOption.h"

enum date
{ none, planned, last } ;

@interface DPEditDinnerOptionViewController ()
{
    
    enum date _dateBeingEdited;
}
@end

@implementation DPEditDinnerOptionViewController

#pragma mark Initialization / Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_dinnerDescription setDelegate:self];
    [_datePickerView setHidden:YES];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [self loadData];
    if ([NSString isEmptyOrNil:[[self dinnerOption] name]])
    {
        [_dinnerDescription becomeFirstResponder];
        [_removeFromPlans setHidden:YES];

    }
    else
        [_removeFromPlans setHidden:![[self dinnerOption] dinnerPlanned] ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DPDaysOfTheWeekViewController *editDaysOfWeekController = segue.destinationViewController;
    
    [editDaysOfWeekController setIsModal:YES];
    
    NSString *title = [NSString stringWithFormat:@"Days to Serve: %@", [[self dinnerOption] name]];
    [editDaysOfWeekController setTitle:title];
    [editDaysOfWeekController setDaysOfWeek:[[self dinnerOption] daysOfWeekServed] ];
    
    /*[editDaysOfWeekController setDismissBlock:^{
        [self handleReturnFromEditDaysOfWeekController:weakRefToController];
    }];*/
    
}

#pragma mark Actions
-(IBAction) changeDaysOfWeekServed:(id)sender
{
}

-(IBAction) changeDatePlanned:(id)sender
{
    [self editDate:planned];
}
-(IBAction) changeLastDateServed:(id)sender
{
    [self editDate:last];
}
-(IBAction) done:(id)sender
{
    if (_dateBeingEdited != none)
        [self setNewDate];
    
    if ((![[[self dinnerOption] name] isEqualToString:[_dinnerDescription text]])  && (![NSString isEmptyOrNil:[_dinnerDescription text]]))
    {
        [self setChanged:YES];
        [[self dinnerOption] setName:[_dinnerDescription text]];
    }
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:[self dismissBlock]];

}
-(IBAction) donePickingDate:(id)sender
{
    [self setNewDate];
    if (_dateBeingEdited == planned)
        [self displayPlannedDate];
    else
        [self displayLastServedDate];
    
    [self editDate:none];
}
-(IBAction) cancelEditingDate:(id)sender
{
    [self editDate:none];
}
-(IBAction) removeFromPlans:(id)sender
{
    
    [[self dinnerOption] removeFromPlans];
    
    [self setChanged:YES];
    [self loadData];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark Private
-(void) editDate:(enum date )dateNowBeingEdited
{
    if (dateNowBeingEdited == _dateBeingEdited)
        return;
    
    _dateBeingEdited = dateNowBeingEdited;
    if (dateNowBeingEdited == none)
    {
        [_removeFromPlans setHidden:![[self dinnerOption] dinnerPlanned]];
        [_datePickerView setHidden:YES];
        [_datePlanned setEnabled:YES];
        [_lastDateServed setEnabled:YES];
        return;
    }
    if (dateNowBeingEdited == planned)
    {
        
        [_datePicker setDate:[[self dinnerOption] nextDateScheduled]];
    }
    else if (dateNowBeingEdited == last)
    {
        [_datePicker setDate:[[self dinnerOption] lastDateServed]];
    }
    [_removeFromPlans setHidden:YES];
    [_datePickerView setHidden:NO];
    [_datePlanned setEnabled:NO];
    [_lastDateServed setEnabled:NO];
    [_dinnerDescription resignFirstResponder];
    
}

-(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return[dateFormatter stringFromDate:date];
    
}
-(void) loadData
{
    [_dinnerDescription setText:[[self dinnerOption] name]];
    
    [_removeFromPlans setHidden:![[self dinnerOption] dinnerPlanned] ];

    [self displayPlannedDate];
    [self displayLastServedDate];
}
-(void) displayPlannedDate
{
    [_datePlanned setTitle:[self formatDate:[_dinnerOption nextDateScheduled]]  forState:UIControlStateNormal];

}
-(void) displayLastServedDate
{
    [_lastDateServed setTitle:[self formatDate:[_dinnerOption lastDateServed]] forState:UIControlStateNormal];
    
}

-(void) setNewDate
{
    NSDate* datePicked = [_datePicker date];
    if ((_dateBeingEdited == planned) && datePicked != [[self dinnerOption] nextDateScheduled])
    {
        [self setChanged:YES];
        [[self dinnerOption] setNextDateScheduled:datePicked];
        
    }
    else if (datePicked != [[self dinnerOption] lastDateServed])
    {
        [self setChanged:YES];
        [[self dinnerOption] setLastDateServed:datePicked];
    }
    
}
/*
-(void) handleReturnFromEditDaysOfWeekController:(DPDaysOfTheWeekViewController*)controller
{
    [[self dinnerOption] setDaysOfWeekServed:[controller daysOfWeek];
}*/

@end
