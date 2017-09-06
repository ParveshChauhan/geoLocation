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
    
    NSLog(@"in viewdidload ");
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    
    NSLog(@"in delegate method ");

    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil&& [placemarks count] >0) {
            placeMark = [placemarks lastObject];
            
           // NSString *latitude, *longitude, *state, *country;
            
            self.latitude.text = [NSString  stringWithFormat:@"%f",newLocation.coordinate.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            self.state.text = placeMark.administrativeArea;
            self.country.text = placeMark.country;
            NSLog(@"Latitide%@ \n longitude  %@\n state %@\n contry %@", self.latitude.text,self.longitude.text,self.state.text,self.country.text);

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
