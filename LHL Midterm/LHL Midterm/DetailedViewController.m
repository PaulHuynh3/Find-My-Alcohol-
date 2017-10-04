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
@property (weak, nonatomic) IBOutlet UILabel *alcoholDescriptionLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation DetailedViewController
//enter the label in view did load.
- (void)viewDidLoad {
    [super viewDidLoad];;
    [self updateDisplay];
    self.locationManager = [[LocationManager alloc]init];
    self.locationManager.locationDelegate = self;
    [self.locationManager requestLocationPermissionIfNeeded];
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
    self.alcoholDescriptionLabel.text = self.product.alcoholDescription;
    
    int priceAlcohol = self.product.priceInCents / 1000;
    self.alcoholPriceLabel.text =[NSString stringWithFormat:@"$%i",priceAlcohol];
    
}

#pragma mark delegate
-(void)passCurrentLocation:(CLLocation*)currentLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 2000, 2000);
    [self.mapView setRegion:region animated:YES];
    
   
    [NetworkRequest queryLocationSeasonalItem:currentLocation product:self.product.productID display:2 complete:^(NSArray<Location *> *results) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            //            // remove existing annotations first
            //            NSArray *annotations = [_mapView annotations];
            //            [self.mapView removeAnnotations:annotations];
                 [self.mapView addAnnotations:results];
        }];
        
        
    }];
    
}










@end
