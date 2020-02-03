//
//  DPDinnerOption.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/19/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDinnerOption.h"
#import "DPScheduler.h"
#import "DPDaysOfWeek.h"
#import "DPAppDelegate.h"

#import "NSDate+Extensions.h"

@implementation DPDinnerOption

#pragma mark Lifecycle
-(id) init
{
    return [self initWithName:@"" lastDateServed:[NSDate distantPast]  nextScheduledDate:[NSDate date] daysOfWeek:nil];
}

-(id)initWithName:(NSString *)name lastDateServed:(NSDate*)lastDateServed nextScheduledDate:(NSDate*)nextDate daysOfWeek:(DPDaysOfWeek*)daysOfWeek
{
    if ((self = [super init])) {
        
        [self setName:name];
        [self setLastDateServed:lastDateServed];
        [self setNextDateScheduled:nextDate];
        
        if (![self dinnerPlanned] && [[self nextDateScheduled] compare:[self lastDateServed]] == NSOrderedDescending)
        {
            [self setLastDateServed:[self nextDateScheduled]];
        }
        
        if (daysOfWeek == nil)
        {
            DPAppDelegate *app = (DPAppDelegate *)[[UIApplication sharedApplication] delegate];
            daysOfWeek = [app daysOfWeekToPlanFor] ;
        }
        [self setDaysOfWeekServed:[daysOfWeek copy]];
    }
    return self;
}

#pragma mark NSCoding

#define kNameKey       @"Name"
#define kNextScheduledDateKey      @"NextScheduledDate"
#define kLastDateServedKey      @"LastDateServed"
#define kDaysOfWeekServedKey    @"DaysOfWeekServed"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kNameKey];
    [encoder encodeObject:_nextDateScheduled forKey:kNextScheduledDateKey];
    [encoder encodeObject:_lastDateServed forKey:kLastDateServedKey];
    [encoder encodeObject:_daysOfWeekServed forKey:kDaysOfWeekServedKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    NSString *name = [decoder decodeObjectForKey:kNameKey];
    NSDate * lastDate = [decoder decodeObjectForKey:kLastDateServedKey];
    NSDate * nextDate = [decoder decodeObjectForKey:kNextScheduledDateKey];
    DPDaysOfWeek *daysOfWeekToServe = [decoder decodeObjectForKey:kDaysOfWeekServedKey];
    
    return [self initWithName:name lastDateServed:lastDate nextScheduledDate:nextDate daysOfWeek:daysOfWeekToServe];
}
#pragma mark Property Overrides
-(NSDate*) lastDateServed
{
    return _lastDateServed;
}
-(void) setLastDateServed:(NSDate*)dateLastServed
{
    _lastDateServed = [dateLastServed dateWithoutTime];
    //_lastDateServed = [self dateWithoutTime:dateLastServed];
}
-(NSDate*) nextDateScheduled
{
    return _nextDateScheduled;
}

-(void) setNextDateScheduled:(NSDate*)nextDate
{
    _nextDateScheduled = [nextDate dateWithoutTime];
}
//@property NSDate* nextDateScheduled;

#pragma mark Public Methods
-(NSString*)scheduledForDayOfWeek
{
    if (![self dinnerPlanned])
        return @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[self nextDateScheduled]]];
}
-(BOOL)dinnerPlanned
{
    NSComparisonResult comparisonResult = [[self nextDateScheduled] compare:[[NSDate date] dateWithoutTime]];
    return ((comparisonResult == NSOrderedDescending) ||(comparisonResult == NSOrderedSame));
}

-(NSComparisonResult)compareOption:(DPDinnerOption*)option
{
    if ([option dinnerPlanned] && [self dinnerPlanned])
        return [[self nextDateScheduled] compare:[option nextDateScheduled]];
    
    if ([self dinnerPlanned])
        return NSOrderedAscending;
    
    if([option dinnerPlanned])
        return NSOrderedDescending;
    
    return [[self lastDateServed] compare:[option lastDateServed]];
        
}
-(void)removeFromPlans
{
    NSDate *yesterday = [DPScheduler yesterday];

    [self setLastDateServed:[yesterday earlierDate:[self lastDateServed]]];
    
    [self setNextDateScheduled:yesterday];
}

@end
