//
//  DetailedViewController.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-03.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCBO.h"
#import "Location.h"
#import "NetworkRequest.h"

@interface DetailedViewController : UIViewController

@property (nonatomic) LCBO *product;
@property (nonatomic) Location *location;


@end
