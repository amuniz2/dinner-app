//
//  DPAppDelegate.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/19/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDinnerOptions;
@class DPDaysOfWeek;

@interface DPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DPDinnerOptions *dinnerOptions;
@property (strong, nonatomic) DPDaysOfWeek *daysOfWeekToPlanFor;
@end
