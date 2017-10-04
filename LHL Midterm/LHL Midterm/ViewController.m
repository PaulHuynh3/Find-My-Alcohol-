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
#import "DetailedViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic)NSArray* promotionalAlcoholArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkRequest queryProductComplete:^(NSArray<LCBO *> *results) {
        self.promotionalAlcoholArray = results;
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        
    }];

}
//optional unless more than one section.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.promotionalAlcoholArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MainPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    [cell setProduct:self.promotionalAlcoholArray[indexPath.row]];
    
    return cell;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"dvcSegue"]){
    DetailedViewController *dvc = segue.destinationViewController;
    
    dvc.product = self.promotionalAlcoholArray[self.collectionView.indexPathsForSelectedItems[0].row];
        
    }
    
}








@end
