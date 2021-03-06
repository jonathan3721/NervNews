//
//  LBNMapViewController.m
//  Nerv
//
//  Created by Jonathan Long on 2/3/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNMapViewController.h"
#import "LBNMapAnnotation.h"
#import <CoreLocation/CoreLocation.h>

static NSString* const mapToAustinSegue = @"MapToAustinSegue";

@interface LBNMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation LBNMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpMapView];
}

- (void)setUpMapView{
    
    CLLocationDegrees northDegree = 30.2669;
    CLLocationDegrees westDegree = -97.7428;
    LBNMapAnnotation* austinAnnotation = [[LBNMapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(northDegree, westDegree)];
    CLLocationDegrees northportDegree = 45.5236;
    CLLocationDegrees westportDegree = -122.6750;
    LBNMapAnnotation* portlandAnnotation = [[LBNMapAnnotation alloc] initWithCoordinate: CLLocationCoordinate2DMake(northportDegree, westportDegree)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    [self.mapView addAnnotation:austinAnnotation];
    [self.mapView addAnnotation:portlandAnnotation];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self performSegueWithIdentifier:mapToAustinSegue sender:nil];
}


@end
