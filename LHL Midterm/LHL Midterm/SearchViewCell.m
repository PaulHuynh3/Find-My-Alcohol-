//
//  SearchViewCell.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-05.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "SearchViewCell.h"
#import "NetworkRequest.h"

@interface SearchViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SearchViewCell



-(void)setAllProducts:(AllProducts *)allProducts{
    _allProducts = allProducts;
 
    [NetworkRequest loadImageForAllProducts:allProducts complete:^(UIImage *results) {
       [[NSOperationQueue mainQueue]addOperationWithBlock:^{
           allProducts.image = results;
           self.imageView.image = results;
           self.nameLabel.text = allProducts.name;
           
       }];
        
    }];


}




@end
