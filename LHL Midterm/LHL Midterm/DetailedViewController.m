//
//  DetailedViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-03.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "DetailedViewController.h"
#import "LocationManager.h"
@import MapKit;

@interface DetailedViewController ()<CoreLocationDelegate>
@property (nonatomic) LocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *alcoholNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *alcoholOriginLabel;

@property (weak, nonatomic) IBOutlet UILabel *alcoholPriceLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation DetailedViewController
//enter the label in view did load.
- (void)viewDidLoad {
    [super viewDidLoad];;
    [self updateDisplay];
    self.locationManager = [[LocationManager alloc]init];
    self.locationManager.locationDelegate = self;
    //    [self.locationManager requestLocationPermissionIfNeeded];
    
}

-(void)updateDisplay{
    
    if (!self.product.image) {
        [NetworkRequest loadImageForPhoto:self.product complete:^(UIImage *result) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.product.image = result;
                self.imageView.image = self.product.image;
            }];
        }];
    }
    
    self.imageView.image = self.product.image;
    self.alcoholNameLabel.text = self.product.name;
    self.alcoholOriginLabel.text = self.product.origin;

    
    int priceAlcohol = self.product.priceInCents / 1000;
    self.alcoholPriceLabel.text =[NSString stringWithFormat:@"$%i",priceAlcohol];
    
}

#pragma mark delegate
-(void)passCurrentLocation:(CLLocation*)currentLocation{
    //currentLocation has a property .coordinate.latitude to access CLLocation's latitude and longitude.
    [NetworkRequest queryLocationPromotionItem:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude product:self.product.productID display:10 complete:^(NSArray<Store *> *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addAnnotations:results];
            self.mapView.showsUserLocation = YES;
            [self.mapView showAnnotations:results animated:YES];
        });
        
    }];
    
}










@end
