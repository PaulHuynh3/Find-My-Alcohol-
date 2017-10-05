//
//  SearchBarViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-05.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "SearchBarViewController.h"
#import "SearchViewCell.h"
#import "DetailedViewController.h"
#import "NetworkRequest.h"
#import "AllProducts.h"

@interface SearchBarViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *productsArray;

@end



@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkRequest queryForAllProducts:^(NSArray<AllProducts *>* results) {
            self.productsArray = results;
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
        
    }];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.productsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchViewCell *SVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchIdentifier" forIndexPath:indexPath];
    

    SVC.allProducts = self.productsArray[indexPath.row];
    
    
    return SVC;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"DetailedView"]){
        DetailedViewController *dvc = segue.destinationViewController;
        dvc.allProducts = self.productsArray[self.collectionView.indexPathsForSelectedItems[0].row];
    
    }
    

}





@end
