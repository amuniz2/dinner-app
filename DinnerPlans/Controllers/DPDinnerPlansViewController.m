//
//  DPDinnerPlansViewController.m
//  DinnerPlans
//
//  Created by Ana Muniz on 9/28/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import "DPDinnerPlansViewController.h"
#import "DPTabBarController.h"

#import "DPDinnerOptions.h"
#import "DPDinnerOption.h"

@interface DPDinnerPlansViewController ()

@end

@implementation DPDinnerPlansViewController
{
    //DPWeek *_dinnerPlans;
    DPDinnerOptions *_dinnerPlans;
    NSArray *_dinnerPlansAsArray;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //CGSize sizeOfTabBar = [[[self tabBarController] view] frame].size;
    //[_collectionView frame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - sizeOfTabBar.height) ];
    //[_collectionView setContentSize:CGSizeMake(self.view.frame.size.width,  ) ];
    //_dinnerPlans = [DPWeek loadDinnerPlans] ;
    _dinnerPlans = [DPDinnerOptions loadDinnerOptions] ;
    [[self collectionView] setDataSource:self];
    [[self collectionView] setDelegate:self];
    //[[self collectionView] setcoll]
}
-(void)viewWillAppear:(BOOL)animated
{
    DPTabBarController * tabBarController = (DPTabBarController *)[self tabBarController];
    if ([tabBarController plansHaveChanged])
    {
        _dinnerPlans = [DPDinnerOptions loadDinnerOptions] ;
        _dinnerPlansAsArray = nil;
        [tabBarController setPlansHaveChanged:NO];
        [[self collectionView] reloadData];
    }
    
    [super viewWillAppear:animated];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dinnerPlansAsArray == nil)
        _dinnerPlansAsArray = [_dinnerPlans plansAsArray];
    
    // Return the number of rows in the section.
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
/*
 -(CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 //return CGSizeMake(self.view.frame.Size.wide, 84);
 return CGSizeMake(self.view.frame.size.width - 20, 84);
 }

 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
 {
 return UIEdgeInsetsMake(0, 10, 0, 10);
 }
 */
@end
