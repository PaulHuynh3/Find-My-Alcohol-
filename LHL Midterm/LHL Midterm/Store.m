//
//  Location.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "Store.h"
@interface Store ()

@end

@implementation Store

-(instancetype)initWithInfo:(NSDictionary *)info{

    if(self = [super init]){
    _intersection = info[@"name"];
    _address = info[@"address_line_1"];
    _latitude = [info[@"latitude"]doubleValue];
    _longitude = [info[@"longitude"]doubleValue];

    }
    return self;

}

-(CLLocationCoordinate2D)coordinate{

    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}


//override default properties of mkannotation and setting it as the title.

- (NSString *)title {
    return self.intersection;
}

- (NSString *)subtitle {
    return self.address;
}



@end
