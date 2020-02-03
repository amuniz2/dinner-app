//
//  DPDaysOfTheWeek.m
//  DinnerPlans
//
//  Created by Ana Muniz on 10/4/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDaysOfTheWeekViewController.h"
#import "DPAppDelegate.h"
#import "DPDaysOfWeek.h"

@implementation DPDaysOfTheWeekViewController
{
    DPDaysOfWeek *_daysOfWeek;
}
#pragma mark Initialization / Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self daysOfWeek] == nil)
    {
        DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate] ;
        [self setDaysOfWeek:[app daysOfWeekToPlanFor]];
        
    }
    [self initDisplay];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_daysOfWeek planDinnerForDays:[sunday isOn] monday:[monday isOn] tuesday:[tuesday isOn] wednesday:[wednesday isOn] thursday:[thursday isOn] friday:[friday isOn] saturday:[saturday isOn]];

    if (![self isModal])
        [_daysOfWeek save];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
-(IBAction)Done:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:[self dismissBlock]];
    
}

#pragma mark Property Overrides
-(DPDaysOfWeek *)daysOfWeek
{
    return _daysOfWeek;
}
-(void)setDaysOfWeek:(DPDaysOfWeek *)daysOfWeek
{
    _daysOfWeek = daysOfWeek;
    
}
#pragma mark Private Helpers
-(void) initDisplay
{
    [sunday setOn:[_daysOfWeek sunday]];
    [monday setOn:[_daysOfWeek monday]];
    [tuesday setOn:[_daysOfWeek tuesday]];
    [wednesday setOn:[_daysOfWeek wednesday]];
    [thursday setOn:[_daysOfWeek thursday]];
    [friday setOn:[_daysOfWeek friday]];
    [saturday setOn:[_daysOfWeek saturday]];
    
    if ([self title] != nil)
        [titleLabel setText:[self title]];
    
    [doneButton setHidden:![self isModal]];

    
}
@end
