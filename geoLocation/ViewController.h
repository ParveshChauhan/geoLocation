//
//  ViewController.h
//  geoLocation
//
//  Created by Parvesh Chauhan on 06/09/17.
//  Copyright © 2017 Parvesh Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
     MKMapView *mapView;
}
@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *country;

@end

