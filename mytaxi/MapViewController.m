//
//  MapViewController.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "MapViewController.h"

#import "MapAnnotation.h"
#import "CarModel.h"
#import "MapViewModel.h"

#import "UIColor+ColorManager.h"
#import "UIImage+Tint.h"

#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *locateMeButton;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.title = self.mapViewModel.navigationBarTitle;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    if (self.mapViewModel.mapType == MapTypeShowUserLocation) {
        
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
        
    }
    
    for (CarModel *carModel in self.mapViewModel.carModels) {
        
        if (carModel.longitude && carModel.latitude) {
            
            MapAnnotation *mapAnnotation = [[MapAnnotation alloc] initWithImage:@"pinCar"];
            
            float longitude = [carModel.longitude floatValue];
            float latitude = [carModel.latitude floatValue];
            
            mapAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            
            [self.mapView addAnnotation:mapAnnotation];
        }
    }
    
    if (self.mapViewModel.mapType == MapTypeShowCarLocation && self.mapViewModel.carModels.count > 0) {
        
        CarModel *carModel = self.mapViewModel.carModels.lastObject;
        
        if (carModel.longitude && carModel.latitude) {
            
            float longitude = [carModel.longitude floatValue];
            float latitude = [carModel.latitude floatValue];
            
            [self showLocationOnMapAtCoordinates:CLLocationCoordinate2DMake(latitude, longitude)];
        }
    }
    
    [self.locateMeButton setImage:[[UIImage imageNamed:@"location_icon"] tintedImage:[UIColor mainThemeColor]] forState:UIControlStateNormal];
}

#pragma mark - Show Location On Map

- (void)showLocationOnMapAtCoordinates:(CLLocationCoordinate2D)coordinate {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = coordinate;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    
    [self.mapView setRegion:mapRegion animated: YES];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.firstObject;
    [self showLocationOnMapAtCoordinates:location.coordinate];
    [manager stopUpdatingLocation];
    
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass: [MapAnnotation class]]) {
        MapAnnotation *ann = (MapAnnotation *)annotation;
        return ann.annotationView;
    }
    
    return nil;
}

- (IBAction)updateLocation:(id)sender {
    
    self.mapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    
}


@end
