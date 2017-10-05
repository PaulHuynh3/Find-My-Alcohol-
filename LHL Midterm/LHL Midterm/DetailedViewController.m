//
//  DetailedViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-03.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "DetailedViewController.h"
#import "NetworkRequest.h"
#import "LocationManager.h"
@import MapKit;

@interface DetailedViewController ()<CoreLocationDelegate, MKMapViewDelegate>
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
    self.mapView.delegate = self;
    
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



#pragma mark locationManager delegate
-(void)passCurrentLocation:(CLLocation*)currentLocation{
    //currentLocation has a property .coordinate.latitude to access CLLocation's latitude and longitude.
    [NetworkRequest queryLocationPromotionItem:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude product:self.product.productID display:10 complete:^(NSArray<Store *> *results) {
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            [self.mapView addAnnotations:results];
            
            self.mapView.showsUserLocation = YES;
            [self.mapView showAnnotations:results animated:YES];
            
        }];
        
    }];
    
}

#pragma mark - customize annotation views.
//customize the pin that the user sees
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //the user's location itself is an annotation pin make sure we do not remove it.
    if ([annotation class] == MKUserLocation.class) {
        return nil;
    }
    
    NSString *identifier = @"StorePin";
    //customize the pin not the view.
    MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        view.canShowCallout = YES;
        view.pinTintColor = [UIColor blueColor];
    } else {
        view.annotation = annotation;
    }
    
    return view;
}






@end
