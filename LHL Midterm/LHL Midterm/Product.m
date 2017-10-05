//
//  LCBO.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "Product.h"

@implementation Product

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

//put if statement incase images return 
- (NSURL *)url
{

    return [NSURL URLWithString:self.urlImage];
}




@end
