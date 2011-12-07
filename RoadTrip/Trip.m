//
//  Trip.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "Trip.h"
#import "Destination.h"
#import "Events.h"

@interface Trip () {
    NSDictionary *destinationData;
    Destination* destination;
    Events *events;
}
@end

@implementation Trip

- (id)initWithDestinationIndex:(int)destinationIndex
{
    if ((self = [super init])) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Destinations" ofType:@"plist"];
        NSDictionary *destinations = [NSDictionary dictionaryWithContentsOfFile: filePath];
        NSArray *destinationsArray = [destinations objectForKey:@"DestinationData"];
        destinationData = [destinationsArray objectAtIndex:destinationIndex];
        destination = [[Destination alloc] initWithDestinationIndex:destinationIndex];
        events = [[Events alloc] initWithDestinationIndex:destinationIndex];
    }
    return self;
}

- (UIImage *) destinationImage
{
    return destination.destinationImage;
}

- (NSString *) destinationName
{
    return destination.destinationName;
}

- (CLLocationCoordinate2D) destinationCoordinate
{
    return destination.coordinate;
}

- (NSString *)weather
{
    return [destinationData objectForKey:@"Weather"];
}

- (int)numberOfEvents {
    return [events numberOfEvents];
}

- (NSString *)getEvent:(int)index
{
    return [events getEvent:index];
}

@end
