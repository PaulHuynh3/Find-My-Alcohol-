//
//  Location.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Store : NSObject <MKAnnotation>

//required mkAnnotation property.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *intersection;
@property (nonatomic) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;


-(instancetype)initWithInfo:(NSDictionary*)info;







@end
