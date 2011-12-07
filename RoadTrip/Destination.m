//
//  Destination.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "Destination.h"

@implementation Destination

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize destinationName = _destinationName;
@synthesize destinationImage = _destinationImage;

- (id)initWithDestinationIndex:(NSUInteger)destinationIndex
{
    if ((self = [super init])) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Destinations" ofType:@"plist"];
        NSDictionary *destinations = [NSDictionary dictionaryWithContentsOfFile: filePath];
        NSArray *destinationsArray = [destinations objectForKey:@"DestinationData"];
        NSDictionary *data = [destinationsArray objectAtIndex:destinationIndex];
        
        self.destinationImage = [UIImage imageNamed:[data objectForKey:@"DestinationImage"]];
        self.destinationName = [data objectForKey:@"DestinationName"];
        
        NSDictionary *destinationLocation = [data objectForKey:@"DestinationLocation"];
        CLLocationCoordinate2D destinationCoordinate;
        destinationCoordinate.latitude = [[destinationLocation objectForKey:@"Latitude"]doubleValue];
        destinationCoordinate.longitude = [[destinationLocation objectForKey:@"Longitude"]doubleValue];
        self.coordinate = destinationCoordinate;
        self.title = [destinationLocation objectForKey:@"Title"];
        self.subtitle = [destinationLocation objectForKey:@"Subtitle"];
        
        
    }
    return self;
}

@end
