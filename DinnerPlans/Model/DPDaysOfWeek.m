//
//  DPDaysOfWeek.m
//  DinnerPlans
//
//  Created by Ana Muniz on 10/4/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDaysOfWeek.h"
#define USER_PREF_KEY @"DaysOfWeekToPlanDinnerFor"

// NSCoding keys
#define SUNDAY @"Sunday"
#define MONDAY @"Monday"
#define TUESDAY @"Tuesday"
#define WEDNESDAY @"Wednesday"
#define THURSDAY @"Thursday"
#define FRIDAY @"Friday"
#define SATURDAY @"Saturday"


@implementation DPDaysOfWeek
#pragma mark Initialization
+(DPDaysOfWeek*)loadDaysOfWeekToPlanFor
{
    return [DPDaysOfWeek load];
    
}
-(int)numberOfDaysToPlan
{
    int result = 0;
    
    if ([self sunday]) ++result;
    if ([self monday]) ++result;
    if ([self tuesday]) ++result;
    if ([self wednesday]) ++result;
    if ([self thursday]) ++result;
    if ([self friday]) ++result;
    if ([self saturday]) ++result;
    
    return result;
}
-(bool)isDinnerToBePlannedOn:(NSString*)weekday
{
    if ([weekday isEqualToString:SUNDAY])
        return [self sunday];

    if ([weekday isEqualToString:MONDAY])
        return [self monday];

    if ([weekday isEqualToString:TUESDAY])
        return [self tuesday];

    if ([weekday isEqualToString:WEDNESDAY])
        return [self wednesday];
 
    if ([weekday isEqualToString:THURSDAY])
        return [self thursday];

    if ([weekday isEqualToString:FRIDAY])
        return [self friday];

    if ([weekday isEqualToString:SATURDAY])
        return [self saturday];
    
    return NO;
}
-(void)planDinnerForDays:(bool)sunday monday:(bool)monday tuesday:(bool)tuesday wednesday:(bool)wednesday thursday:(bool)thursday friday:(bool)friday saturday:(bool)saturday
{
    [self setSunday:sunday];
    [self setMonday:monday];
    [self setTuesday:tuesday];
    [self setWednesday:wednesday];
    [self setThursday:thursday];
    [self setFriday:friday];
    [self setSaturday:saturday];
}
#pragma mark Persistence
+(DPDaysOfWeek *)load {
    
    DPDaysOfWeek * returnObject;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:USER_PREF_KEY];
    
    if (encodedObject == nil)
    {
        returnObject = [[DPDaysOfWeek alloc] init];
        [returnObject planDinnerForDays:NO monday:YES tuesday:YES wednesday:YES thursday:YES friday:YES saturday:NO];
    }
    else
        returnObject =  [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return returnObject;
    
}
-(void) save
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:USER_PREF_KEY];
    [defaults synchronize];
}


#pragma mark NSCoding

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeBool:[self sunday] forKey:SUNDAY] ;
    [encoder encodeBool:[self monday] forKey:MONDAY] ;
    [encoder encodeBool:[self tuesday] forKey:TUESDAY] ;
    [encoder encodeBool:[self wednesday] forKey:WEDNESDAY] ;
    [encoder encodeBool:[self thursday] forKey:THURSDAY] ;
    [encoder encodeBool:[self friday] forKey:FRIDAY] ;
    [encoder encodeBool:[self saturday] forKey:SATURDAY] ;

}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self)
    {
        [self setSunday:[decoder decodeBoolForKey:SUNDAY]];
        [self setMonday:[decoder decodeBoolForKey:MONDAY]];
        [self setTuesday:[decoder decodeBoolForKey:TUESDAY]];
        [self setWednesday:[decoder decodeBoolForKey:WEDNESDAY]];
        [self setThursday:[decoder decodeBoolForKey:THURSDAY]];
        [self setFriday:[decoder decodeBoolForKey:FRIDAY]];
        [self setSaturday:[decoder decodeBoolForKey:SATURDAY]];
        
    }
    return self;
}
#pragma mark NSCopying
-(id)copyWithZone:(NSZone *)zone
{
    DPDaysOfWeek *copy = [[DPDaysOfWeek alloc] init];
    
    [copy setSunday:[self sunday]];
    [copy setMonday:[self monday]];
    [copy setTuesday:[self tuesday]];
    [copy setWednesday:[self wednesday]];
    [copy setThursday:[self thursday]];
    [copy setFriday:[self friday]];
    [copy setSaturday:[self saturday]];
    
    return copy;
}

@end
