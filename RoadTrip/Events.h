//
//  Events.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Events : NSObject

- (id)initWithDestinationIndex:(NSUInteger)destinationIndex;
- (int)numberOfEvents;
- (NSString *)getEvent:(int)index;

@end
