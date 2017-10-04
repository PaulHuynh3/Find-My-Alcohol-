//
//  Location.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "Location.h"

@implementation Location

-(instancetype)initWithInfo:(NSDictionary *)info{

    if (self = [super init]){
        _latitude = [info[@"latitude"]doubleValue];
        _longitude = [info[@"longitude"]doubleValue];
        _intersection = info[@"name"]; //displays intersection
        _address = info[@"address_line_1"];
        
    
    }

    return self;
}


-(CLLocationCoordinate2D)coordinate{

    return CLLocationCoordinate2DMake(self.latitude, self.longitude);

}



@end
