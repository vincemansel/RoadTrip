//
//  MapController.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/6/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)mapType:(id)sender;
- (void)setInitialRegion;
- (void)addAnnotations;

@end
