//
//  DPSchedule.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/22/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPSchedule.h"
#import "DPTabBarController.h"
#import "DPScheduler.h"
#import "DPDaysOfWeek.h"
#import "DPAppDelegate.h"
//#import "DPWeek.h"
#import "DPDinnerOptions.h"
#import "DPDinnerOption.h"

@implementation DPSchedule
{
    //DPWeek *_dinnerPlans;
    DPDinnerOptions *_dinnerPlans;
    NSArray *_dinnerPlansAsArray;
    
}
#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // _dinnerPlans = [DPDinnerOptions loadDinnerOptions] ;
    
    DPAppDelegate *app = (DPAppDelegate*)[[UIApplication sharedApplication] delegate];
    _dinnerPlans = [app dinnerOptions];
    
    DPScheduler *scheduler = [DPScheduler schedulerWithOptions:_dinnerPlans];
    [scheduler scheduleNext];
    
    [super reloadInputViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    DPTabBarController * tabBarController = (DPTabBarController *)[self tabBarController];
    if ([tabBarController plansHaveChanged])
    {
        //_dinnerPlans = [DPDinnerOptions loadDinnerOptions] ;
        //_dinnerPlansAsArray = nil;
        [tabBarController setPlansHaveChanged:NO];
        [[self collectionView] reloadData];
    }
    
    [super viewWillAppear:animated];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //if (_dinnerPlansAsArray == nil)
    _dinnerPlansAsArray = [_dinnerPlans plans];
    
    // Return the number of rows in the section.
    [[self collectionView] setContentSize:CGSizeMake(284, 90 * [_dinnerPlansAsArray count])];
    return [_dinnerPlansAsArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString * labels[] = {@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"};
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayOfWeekCell" forIndexPath:indexPath];
    DPDinnerOption *plan = [_dinnerPlansAsArray objectAtIndex:[indexPath row]];
    UILabel *dayOfWeekLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    [nameLabel setText:[plan name]];
    [dayOfWeekLabel setText:[plan scheduledForDayOfWeek]];
    return cell;
}

-(CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout    sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake(self.view.frame.Size.wide, 84);
    return CGSizeMake(self.view.frame.size.width - 20, 80);
}
/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
         return UIEdgeInsetsMake(0, 10, 0, 10);
}
 */
@end
