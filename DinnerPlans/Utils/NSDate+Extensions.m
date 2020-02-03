//
//  NSDate+Extensions.m
//  DinnerPlans
//
//  Created by Ana Muniz on 3/10/15.
//  Copyright (c) 2015 Ana Muniz. All rights reserved.
//

#import "NSDate+Extensions.h"


@implementation NSDate (NSDateExtensions)

-(NSDate *)dateWithoutTime
{
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

@end
