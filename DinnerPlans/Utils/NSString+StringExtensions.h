//
//  NSString+Extensions.h
//  DinnerPlans
//
//  Created by Ana Muniz on 12/15/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringExtensions)
- (BOOL)endsWith:(NSString *)end;
+(BOOL) isEmptyOrNil:(NSString*)string;

@end
