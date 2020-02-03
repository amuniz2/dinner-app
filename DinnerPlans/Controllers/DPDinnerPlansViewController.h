//
//  DPDinnerPlansViewController.h
//  DinnerPlans
//
//  Created by Ana Muniz on 9/28/14.
//  Copyright (c) 2014 Ana Muniz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDinnerPlansViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *_collectionView;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@end
