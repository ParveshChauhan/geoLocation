//
//  ViewController.m
//  geoLocation
//
//  Created by Parvesh Chauhan on 06/09/17.
//  Copyright © 2017 Parvesh Chauhan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placeMark;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder=[[CLGeocoder alloc]init];
    
    if(_locationManager == nil){
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.delegate = self;
    }
    
    [_locationManager startUpdatingLocation];
    mapView = [[MKMapView alloc]initWithFrame: CGRectMake(100, 400, 400, 400)];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];

    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil&& [placemarks count] >0) {
            placeMark = [placemarks lastObject];
            self.latitude.text = [NSString  stringWithFormat:@"%f",newLocation.coordinate.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            self.state.text = placeMark.administrativeArea;
            self.country.text = placeMark.country;
            
            NSLog(@"Latitide%@ \n longitude  %@\n state %@\n contry %@", self.latitude.text,self.longitude.text,self.state.text,self.country.text);
            
            mapView.centerCoordinate = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            mapView.mapType = MKMapTypeHybrid;
            CLLocationCoordinate2D location;
            location.latitude = (double) newLocation.coordinate.latitude;
            location.longitude = (double) newLocation.coordinate.longitude;
            // for zoom in
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
            (newLocation.coordinate, 40, 40);
            [mapView setRegion:region animated:YES];
        } else {
            NSLog(@"error %@", error.debugDescription);
        }
    }];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}



@end
