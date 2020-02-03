//
//  DPScheduler.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/29/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPScheduler.h"
#import "DPDinnerOptions.h"
#import "DPDinnerOption.h"
#import  "DPDaysOfWeek.h"
#import "DPAppDelegate.h"

#import "NSDate+Extensions.h"

#define SECONDS_PER_DAY 86400

@implementation DPScheduler
{
    DPDinnerOptions* _optionsAvailable ;
}
#pragma mark Initialization
+(DPScheduler *) schedulerWithOptions:(DPDinnerOptions *)options
{
    return [[DPScheduler alloc] initWithOptions:options];
}
-(id)initWithOptions:(DPDinnerOptions*)options
{
    if ((self = [super init])) {
        _optionsAvailable = options;
    }
    return self;
}
- (id)init {
    
    return [self initWithOptions:[[DPDinnerOptions alloc] init]];
}
#pragma mark Public Methods
-(DPDinnerOption *) nextDinnerToBeServedOn:(NSString *)dayOfWeek
{
    NSEnumerator *options = [[_optionsAvailable options] objectEnumerator];

    for (DPDinnerOption * option in options)
    {
        if (![option dinnerPlanned] &&
            [[option daysOfWeekServed] isDinnerToBePlannedOn:dayOfWeek])
        {
            return option;
        }
    }
    return nil;
}
-(bool) dinnerIsPlannedOn:(NSDate*)date
{
    for (DPDinnerOption *plan in [_optionsAvailable options])
    {
        if ([[plan nextDateScheduled] compare:date] == NSOrderedSame)
            return YES;
    }
    return NO;
}

-(void)scheduleNext
{
    
    NSDate *dateToPlan =  [NSDate date];
    
    DPDinnerOption *currentOption;
    
    DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate] ;
    DPDaysOfWeek *daysOfWeek = [app daysOfWeekToPlanFor];
    
    bool plansChanged = NO;
    int numberScheduled = 0;
    int numberOfDaysToPlan = [daysOfWeek numberOfDaysToPlan];
    while(numberScheduled <  numberOfDaysToPlan)
    {
        if ([self dinnerIsPlannedOn:[dateToPlan dateWithoutTime]])
            numberScheduled++;

        else
        {
            NSString * dayOfWeek = [DPScheduler dayOfWeek:dateToPlan];
            if ([daysOfWeek isDinnerToBePlannedOn:dayOfWeek])
            {
                currentOption = [self nextDinnerToBeServedOn:dayOfWeek];
                if (currentOption != nil)
                {
                    [currentOption setNextDateScheduled:dateToPlan];
                    numberScheduled++;
                    plansChanged = YES;
                }
                else
                    numberOfDaysToPlan--;
            }
        }
        dateToPlan = [DPScheduler nextDay:dateToPlan];
    }
    if (plansChanged)
        [_optionsAvailable save];
}
/*
-(void)scheduleNext
{
    int numberScheduled = 0;
    DPDinnerOption *currentOption;
    
    DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate] ;
    DPDaysOfWeek *daysOfWeek = [app daysOfWeekToPlanFor];
    
    NSArray *sortedOptions = [_optionsAvailable options];
    NSDate *lastDateScheduled = [[NSDate alloc] initWithTimeInterval:SECONDS_PER_DAY sinceDate:[NSDate date]];
    bool plansChanged = NO;
    
    NSEnumerator *optionsEnumerator = [sortedOptions objectEnumerator];
    
    while((numberScheduled < [daysOfWeek numberOfDaysToPlan]) && (currentOption = [optionsEnumerator nextObject]))
    {
        if ([currentOption dinnerPlanned])
        {
            numberScheduled++;
            lastDateScheduled = [currentOption nextDateScheduled];
          
        }
        else
        {
            NSDate *nextDate = [DPScheduler nextDinnerDayAfterDate:lastDateScheduled onOneOf:[currentOption daysOfWeekServed]];
            [currentOption setNextDateScheduled:nextDate];
            numberScheduled++;
            plansChanged = YES;
            
        }
        
    }
    if (plansChanged)
        [_optionsAvailable save];
}
*/
+(NSDate *) yesterday
{
    return [[NSDate date] dateByAddingTimeInterval:0- SECONDS_PER_DAY];
}
+(NSDate *) nextDay:(NSDate*)asOf
{
    return [asOf dateByAddingTimeInterval:0+SECONDS_PER_DAY];
}
+(NSString*) dayOfWeek:(NSDate*)date
{
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
     [dateFormatter setDateFormat:@"EEEE"];
     return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}
+(NSDate *)nextDinnerDayAfterDate:(NSDate*)priorDate onOneOf:(DPDaysOfWeek*)daysOfWeek
{
    NSDate* nextProposedDate;
    bool dateFound = NO;
    while (!dateFound)
    {
        nextProposedDate = [priorDate dateByAddingTimeInterval:SECONDS_PER_DAY];
        if ([daysOfWeek isDinnerToBePlannedOn:[DPScheduler dayOfWeek:nextProposedDate]])
        {
            dateFound = YES;
        }
        else
            priorDate = nextProposedDate;
    }
    return nextProposedDate;
    
}

+(NSDate *)nextAvailableDate
{
    DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate] ;
    DPDaysOfWeek *daysOfWeek = [app daysOfWeekToPlanFor];
    NSDate * lastDatePlanned = [self dateOfLastPlannedDinner:[app dinnerOptions]];
    
    return [DPScheduler nextDinnerDayAfterDate:lastDatePlanned onOneOf:daysOfWeek];
    
}
+(NSDate*)dateOfLastPlannedDinner:(DPDinnerOptions*)dinnerOptions
{
    
    NSDate *latestDateScheduled = [NSDate distantPast];
    
    NSArray * options = [dinnerOptions options];
    for (int i = 0; i < [options count]; i++)
    {
        DPDinnerOption *option = [options objectAtIndex:i];
        if ([option dinnerPlanned])
            latestDateScheduled = [latestDateScheduled laterDate:[option nextDateScheduled]];
        
    }
    return latestDateScheduled;
}


@end
