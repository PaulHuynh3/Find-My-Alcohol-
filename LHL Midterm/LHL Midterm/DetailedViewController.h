//
//  DetailedViewController.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-03.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Store.h"
#import "AllProducts.h"


@interface DetailedViewController : UIViewController

@property (nonatomic) Product *product;
@property (nonatomic) Store *store;
@property (nonatomic) AllProducts *allProducts;

@end
