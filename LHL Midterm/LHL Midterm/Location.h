//
//  Location.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Location : NSObject <MKAnnotation>

//required mkAnnotation property.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *intersection;
@property (nonatomic) NSString *address;




-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate intersection:(NSString*)intersection address:(NSString*)address;





@end
