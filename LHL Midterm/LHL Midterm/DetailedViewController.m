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

    self.imageView.image = self.product.image;
    self.alcoholNameLabel.text = self.product.name;
    self.alcoholNameLabel.text = self.product.origin;
    self.alcoholDescriptionLabel.text = self.product.alcoholDescription;
//    self.alcoholPriceLabel.text = self.product.priceInCents;
//    self.mapView.region =
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(.25f, .25f);
//    //sets the region for the user
//    self.mapView.region = MKCoordinateRegionMake(self.photo.coordinate, span);
//    
//    //adds the red pin on the map
//    [self.mapView addAnnotation:self.photo];
    
}









@end
