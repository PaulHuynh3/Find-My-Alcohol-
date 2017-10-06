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

@property (weak, nonatomic) IBOutlet UILabel *packageDescripLabel;

@property (weak, nonatomic) IBOutlet UILabel *primaryCategLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondCategLabel;


@property (weak, nonatomic) IBOutlet UILabel *alcoholPriceLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation DetailedViewController
//enter the label in view did load.
- (void)viewDidLoad {
    [super viewDidLoad];;
    [self updateDisplay];
    [self updateAllProductsDisplay];
    self.locationManager = [[LocationManager alloc]init];
    //delegate of locationmanager
    self.locationManager.locationDelegate = self;
    //to customize annotations
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
    self.packageDescripLabel.text = self.product.packageDescription;
    self.primaryCategLabel.text = self.product.primaryCategory;
    self.secondCategLabel.text =self.product.secondaryCategory;

    float priceAlcohol = self.product.priceInCents / 100.0;
    self.alcoholPriceLabel.text =[NSString stringWithFormat:@"$%.2f",priceAlcohol];
    
}

-(void)updateAllProductsDisplay{
    
    if (!self.product.image) {
        [NetworkRequest loadImageForAllProducts:self.allProducts complete:^(UIImage *results) {
            self.allProducts.image =results;
            self.imageView.image = results;
            
        }];
        
        self.imageView.image = self.allProducts.image;
        self.alcoholNameLabel.text = self.allProducts.name;
        self.alcoholOriginLabel.text = self.allProducts.origin;
        self.packageDescripLabel.text =self.allProducts.packageDescription;
        self.primaryCategLabel.text = self.allProducts.primaryCategory;
        self.secondCategLabel.text = self.allProducts.secondaryCategory;
        
        
        float priceAlcohol = self.allProducts.priceInCents / 100.0;
        
        self.alcoholPriceLabel.text =[NSString stringWithFormat:@"$%.2f",priceAlcohol];
        
    }
    
}

#pragma mark locationManager delegate
-(void)passCurrentLocation:(CLLocation*)currentLocation{
    //currentLocation has a property .coordinate.latitude to access CLLocation's latitude and longitude.
    //pass in promotional products.
    
    [NetworkRequest queryLocationPromotionItem:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude product:self.product.productID display:5 complete:^(NSArray<Store *> *results) {
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            [self.mapView addAnnotations:results];
            
            self.mapView.showsUserLocation = YES;
            //show the span of map relative to annotation positioning.
            [self.mapView showAnnotations:results animated:YES];
            
        }];
        
    }];
    
  
    
    //pass in all products
    [NetworkRequest queryLocationPromotionItem:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude product:self.allProducts.productID display:5 complete:^(NSArray<Store *> *results) {
       
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
        view.pinTintColor = [UIColor greenColor];
    } else {
        view.annotation = annotation;
    }
    
    return view;
}






@end
