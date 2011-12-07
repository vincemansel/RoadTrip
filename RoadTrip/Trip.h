//
//  Trip.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Trip : NSObject

- (UIImage *)destinationImage;
- (NSString *)destinationName;
- (CLLocationCoordinate2D)destinationCoordinate;

- (id)initWithDestinationIndex:(int)destinationIndex;
- (NSString *)weather;
- (int)numberOfEvents;
- (NSString *)getEvent:(int)index;

@end
