//
//  LCBO.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "LCBO.h"

@implementation LCBO

-(instancetype)initWithInfo:(NSDictionary *)info{

    if (self = [super init]){
    
        _name = info[@"name"];
        _origin = info[@"origin"];
        _priceInCents = [info[@"price_in_cents"]intValue];
        _isSeasonal = [info[@"is_seasonal"]boolValue];
        _alcoholContent = [info[@"alcohol_content"]intValue];
        _productID = [info[@"id"]intValue];
        
        _alcoholDescription = info[@"description"];
        if ([_alcoholDescription isEqual:[NSNull null]]) {
            _alcoholDescription = nil;
        }
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
