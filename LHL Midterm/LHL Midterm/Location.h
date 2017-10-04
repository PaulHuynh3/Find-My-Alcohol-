//
//  Location.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol CoreLocationDelegate <NSObject>

- (void)passCurrentLocation: (CLLocation*)location;

@end

@interface Location : NSObject <MKAnnotation>


@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSString *intersection;
@property (nonatomic) NSString *address;



-(instancetype)initWithInfo:(NSDictionary*)info;

//required mkAnnotation property.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;



@end
