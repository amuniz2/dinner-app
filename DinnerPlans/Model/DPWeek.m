//
//  DPWeek.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/22/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPWeek.h"
#import "DPDinnerOption.h"

@implementation DPWeek
#define kMonday       @"Monday"
#define kTuesday      @"Tuesday"
#define kWednesday    @"Wednesday"
#define kThursday    @"Thursday"
#define kFriday    @"Friday"

#define kDataFile       @"dinnerPlans.plist"


#pragma mark initialization

-(id)init
{
    return [self initWithDinnerPlanForMonday:nil tusday:nil wednesday:nil thursday:nil friday:nil];
}
-(id)initWithDinnerPlanForMonday:(DPDinnerOption*)mondayPlan tusday:(DPDinnerOption*)tuesday wednesday:(DPDinnerOption*)wednesday thursday:(DPDinnerOption*)thursday friday:(DPDinnerOption*)friday
{
    if ((self = [super init])) {
        _dinnerPlans = [NSDictionary dictionaryWithObjectsAndKeys:mondayPlan, kMonday,
                        tuesday,kTuesday, wednesday,kWednesday, thursday, kThursday,friday, kFriday, nil ];
        
    }
    return self;
    
}
#pragma mark Persistence

- (id)load {
    
    if ([self dinnerPlans] != nil)
        return [self dinnerPlans];
    
    _dinnerPlans = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    
    return _dinnerPlans;
    
}
-(void) save
{
    if ([self dinnerPlans] == nil)
        return;
    
    [NSKeyedArchiver archiveRootObject:[self dinnerPlans] toFile:[self filePath]];
}

- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

-(NSString *)filePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // for ios, there will only be one director in the list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [[documentDirectory stringByAppendingPathComponent:[self name]]stringByAppendingPathComponent:kDataFile];
    
}


@end
