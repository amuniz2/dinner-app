//
//  DPDaysOfWeek.h
//  DinnerPlans
//
//  Created by Ana Muniz on 10/4/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPDaysOfWeek : NSObject <NSCoding, NSCopying>
{
    
}
+(DPDaysOfWeek*)loadDaysOfWeekToPlanFor;

-(void)planDinnerForDays:(bool)sunday monday:(bool)monday tuesday:(bool)tuesday wednesday:(bool)wednesday thursday:(bool)thursday friday:(bool)friday saturday:(bool)saturday;

+(DPDaysOfWeek *)load;
-(void) save;
-(bool)isDinnerToBePlannedOn:(NSString*)weekday;
-(int)numberOfDaysToPlan;

@property bool sunday;
@property bool monday;
@property bool tuesday;
@property bool wednesday;
@property bool thursday;
@property bool friday;
@property bool saturday;
@end
