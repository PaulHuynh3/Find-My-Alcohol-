//
//  NetworkRequest.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCBO.h"
#import "Location.h"

@interface NetworkRequest : NSObject


+ (void)queryProductComplete:(void (^)(NSArray<LCBO*>* results))complete;

// load images in viewCell.
+ (void)loadImageForPhoto:(LCBO*)photo
                 complete:(void(^)(UIImage* result))complete;


+ (void)queryLocationSeasonalProduct:(int)productId complete:(void (^)(NSArray<Location*>* results))complete;



@end
