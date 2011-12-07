//
//  RoadTripAppDelegate.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/2/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trip;

@interface RoadTripAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Trip *trip;

- (void)createDestinationModel:(int)destinationIndex;

@end
