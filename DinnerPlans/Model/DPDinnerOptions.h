//
//  DPDinnerOptions.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/22/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DPDinnerOption;

@interface DPDinnerOptions : NSObject
{
}
//@property NSMutableDictionary * options;
@property (readonly) NSString * filePath;
@property NSMutableArray *options;
@property (readonly)NSArray * plans;
//@property (readonly) NSMutableArray *plansAsArray;

- (void) load;
- (void)save;
- (void)deleteDoc;

//@property NSString* name;

+(DPDinnerOptions *)loadDinnerOptions;

-(void)addOption:(DPDinnerOption*)newOption;

@end
