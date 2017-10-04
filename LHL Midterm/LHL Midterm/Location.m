//
//  Location.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "Location.h"
@interface Location ()

@end

@implementation Location

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate intersection:(NSString *)intersection address:(NSString *)address{
    if (self = [super init]){
    _coordinate = coordinate;
    _intersection = intersection;
    _address = address;
    }
    return self;
}





@end
