//
//  AllProducts.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-05.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllProducts : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic)NSString *origin;
@property (nonatomic) int priceInCents;
@property (nonatomic) int productID;
@property (nonatomic) int alcoholContent;
@property (nonatomic) NSString* urlImage;



-(instancetype)initWithInfo:(NSDictionary*)info;



@end
