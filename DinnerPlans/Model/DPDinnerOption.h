//
//  DPDinnerOption.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/19/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPDaysOfWeek;

@interface DPDinnerOption : NSObject <NSCoding>
{
    NSDate* _lastDateServed;
    NSDate* _nextDateScheduled;
}
- (id)initWithName:(NSString*)name lastDateServed:(NSDate*)lastDate nextScheduledDate:(NSDate*)nextDate daysOfWeek:(DPDaysOfWeek*)daysOfWeek;

-(NSString*)scheduledForDayOfWeek;
-(BOOL)dinnerPlanned;
-(NSComparisonResult)compareOption:(DPDinnerOption*)option;
-(void)removeFromPlans;

//- (id)initWithDocPath:(NSString *)docPath;
//- (void)saveData;
//- (void)deleteDoc;@property NSString* name;

@property NSString* name;
@property NSDate* lastDateServed;
@property NSDate* nextDateScheduled;
@property DPDaysOfWeek* daysOfWeekServed;

@end
