//
//  DPScheduler.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/29/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DPDinnerOptions;
@class DPDaysOfWeek;

@interface DPScheduler : NSObject
{}
+(DPScheduler *) schedulerWithOptions:(DPDinnerOptions*)options;
-(void)scheduleNext;
//+(BOOL)isDateInThePast:(NSDate*)date;
+(NSDate *)nextAvailableDate;
+(NSDate *)yesterday;
@end
