//
//  LocationManager.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-04.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "LocationManager.h"
@import CoreLocation;

@interface LocationManager ()<CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *clLocationManager;

@property(nonatomic, strong) CLLocation *lastLocation;
@end


@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clLocationManager = [[CLLocationManager alloc] init];
        _clLocationManager.delegate = self;
//        _clLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self requestLocationPermissionIfNeeded];
        
    }
    return self;
}

//prompt user to use their location
- (void)requestLocationPermissionIfNeeded {
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusNotDetermined) {
            // we can ask for it
            [self.clLocationManager requestWhenInUseAuthorization];
        } else if (status == kCLAuthorizationStatusAuthorizedAlways
                   || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.clLocationManager requestLocation];
        }
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"status changed to %d", status);
//    [_clLocationManager startUpdatingLocation];
//    [self.clLocationManager requestLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    locationManager:didFailWithError:
    NSLog(@"%@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //returns an array of user's locations set it to first one.
    CLLocation *location = locations.firstObject;
//    if (location) {
//        if (self.lastLocation) {
//            CLLocationDistance distance = [location distanceFromLocation:self.lastLocation];
//            if (distance < 200) {
//                return;
//            }
//        }
//        self.lastLocation = location;
//        
        [self.locationDelegate passCurrentLocation:location];
//    }
}


@end
