//
//  ViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"
#import "MainPageCell.h"
#import "NetworkRequest.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic)NSArray* seasonalAlcoholArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkRequest queryProductComplete:^(NSArray<LCBO *> *results) {
        self.seasonalAlcoholArray = results;
    }];
    
    
}
//optional unless more than one section.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.seasonalAlcoholArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MainPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    [cell setProduct:self.seasonalAlcoholArray[indexPath.row]];
    
    return cell;

}










@end
