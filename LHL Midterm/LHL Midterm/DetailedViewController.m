//
//  DetailedViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-03.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "DetailedViewController.h"


@interface DetailedViewController ()<MKMapViewDelegate>

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
    [super viewDidLoad];
    
    if (!self.product.image) {
        [NetworkRequest loadImageForPhoto:self.product complete:^(UIImage *result) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.product.image = result;
                self.imageView.image = self.product.image;
            }];
        }];
        }
    
    [self updateDisplay];

    
}

-(void)updateDisplay{

    self.imageView.image = self.product.image;
    self.alcoholNameLabel.text = self.product.name;
    self.alcoholOriginLabel.text = self.product.origin;
    self.alcoholDescriptionLabel.text = self.product.alcoholDescription;
    
    int priceAlcohol = self.product.priceInCents;
    int dollar = 1000;
    int sum = priceAlcohol/dollar;
    
    self.alcoholPriceLabel.text =[NSString stringWithFormat:@"$%i",sum];
    
    
    //creates the map span
    MKCoordinateSpan span = MKCoordinateSpanMake(.25f, .25f);
    //sets the region for the user
    self.mapView.region = MKCoordinateRegionMake(self.location.coordinate, span);
    //adds the red pin on the map
    [self.mapView addAnnotation:self.location];

}







@end
