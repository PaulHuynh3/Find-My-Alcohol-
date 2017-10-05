//
//  LocationManager.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-04.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol CoreLocationDelegate <NSObject>

- (void)passCurrentLocation:(CLLocation*)location;

@end

//acts as delegator here and delegate of cllLocationManagerDelage.
@interface LocationManager : NSObject

@property (nonatomic) id<CoreLocationDelegate> locationDelegate;



@end
