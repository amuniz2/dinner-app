//
//  DPWeek.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/22/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DPDinnerOption;

@interface DPWeek : NSObject
{
}
@property (readonly) NSString * filePath;

- (id) load;
- (void)save;
- (void)deleteDoc;@property NSString* name;

+(DPWeek *)loadDinnerPlans;

@property (readonly) NSMutableDictionary *dinnerPlans;
@property (readonly) NSArray *plansAsArray;

-(id)initWithDinnerPlanForMonday:(DPDinnerOption*)mondayPlan tusday:(DPDinnerOption*)tuesday wednesday:(DPDinnerOption*)wednesday thursday:(DPDinnerOption*)thursday friday:(DPDinnerOption*)friday;

/*@property DPDinnerOption *mondayDinner;
@property DPDinnerOption *tuesdayDinner;
@property DPDinnerOption * wednesdayDinner;
@property DPDinnerOption *thursdayDinner;
@property DPDinnerOption * fridayDinner;
*/
@end
