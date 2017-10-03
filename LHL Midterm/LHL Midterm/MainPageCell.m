//
//  MainPageCell.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "MainPageCell.h"
#import "NetworkRequest.h"

@interface MainPageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation MainPageCell

-(void)setProduct:(LCBO *)product{
    _product = product;
 

    if ([product url] == nil) {
        // TODO: set imageView to placeholder
    } else {
        [NetworkRequest loadImageForPhoto:product complete:^(UIImage *result) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                product.image = result;
                self.imageView.image = result;
                self.titleLabel.text = product.name;
            }];
            
        }];
    }
}





@end
