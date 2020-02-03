//
//  DPDinnerOptions.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/22/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDinnerOptions.h"
#import "DPDinnerOption.h"

#define kDataFile       @"dinnerOptions.plist"
//#define kDataKey        @"dinnerOptions"

@implementation DPDinnerOptions
{
    NSMutableArray *_options;
}
// Add new methods
- (id)init {
    if ((self = [super init])) {
    }
    return self;
}
-(void)sortOptions
{
    [_options sortUsingSelector:@selector(compareOption:)];

}
#pragma mark Property Overrides
-(NSArray *)options
{
    if (_options == nil)
        [self load];
    else
        [self sortOptions];
    
    return _options;
    
    
    /*[returnArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        DPDinnerOption *option1 = obj1;
        DPDinnerOption *option2 = obj2;
        
        return [[option1 lastDateServed ] compare:[option2 lastDateServed]];
        
    }];*/
}
-(void)setOptions:(NSMutableArray *)value
{
    _options = value;
}
-(NSArray *) plans
{
    if (_options == nil)
        [self load];
    
    DPDinnerOption * option;
    
    NSMutableArray * returnArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_options count]; i++)
    {
        option = [_options objectAtIndex:i];
        if ([option dinnerPlanned])
            [returnArray addObject:option];
    }
    /*[returnArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        DPDinnerOption *plannedDinner1 = obj1;
        DPDinnerOption *plannedDinner2 = obj2;
        
        return [[plannedDinner1 nextDateScheduled] compare:[plannedDinner2 nextDateScheduled]];
        
    }];
    */
    return returnArray;
    
}


#pragma mark List Maintenance
-(void)addOption:(DPDinnerOption *)option
{
    [[self options] addObject:option];
    [self sortOptions];
    //[_options addEntriesFromDictionary:[NSDictionary dictionaryWithObject:option forKey:[option name]]];
}
-(void)deleteOption:(DPDinnerOption *)dinnerOption
{
    [[self options] removeObject:dinnerOption];
}
#pragma mark Pesistence
+(DPDinnerOptions*)loadDinnerOptions
{
    DPDinnerOptions * options = [[DPDinnerOptions alloc] init];
    [options load];
    return options;
}

-(void)load {
    
    if (_options != nil)
        return;
    
    NSMutableArray * optionsOnFile = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    if (optionsOnFile == nil)
        optionsOnFile = [[NSMutableArray alloc] init];
   
    [self setOptions:optionsOnFile];
    [self sortOptions];
    
}
-(void) save
{
    if (_options == nil)
        return;
    
    [NSKeyedArchiver archiveRootObject:[self options] toFile:[self filePath]];
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
    
    return [documentDirectory stringByAppendingPathComponent:kDataFile];

}

@end
