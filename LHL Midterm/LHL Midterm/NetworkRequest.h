//
//  NetworkRequest.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Store.h"
#import "AllProducts.h"

@interface NetworkRequest : NSObject


+ (void)queryProductComplete:(void (^)(NSArray<Product*>* results))complete;

// load images in viewCell.
+ (void)loadImageForPhoto:(Product*)photo
                 complete:(void(^)(UIImage* result))complete;


+ (void)queryLocationPromotionItem:(double)latitude longitude:(double)longitude product:(int)productId display:(int)stores complete:(void (^)(NSArray<Store*>* results))complete;


+(void)queryForAllProducts:(void (^)(NSArray<AllProducts*> *))complete;


@end
