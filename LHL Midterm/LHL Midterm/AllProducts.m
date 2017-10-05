//
//  AllProducts.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-05.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "AllProducts.h"

@implementation AllProducts

-(instancetype)initWithInfo:(NSDictionary *)info{
    
    if (self = [super init]){
        
        _name = info[@"name"];
        _origin = info[@"origin"];
        _priceInCents = [info[@"price_in_cents"]intValue];
        _alcoholContent = [info[@"alcohol_content"]intValue];
        _productID = [info[@"id"]intValue];
        _urlImage = info[@"image_url"];
        if([_urlImage isEqual:[NSNull null]]){
            _urlImage = nil;
        }
        
    }
    return self;
    
}


@end
