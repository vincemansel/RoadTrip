//
//  Events.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "Events.h"

@interface Events() {
    NSMutableArray *events;
}
@end

@implementation Events

- (id)initWithDestinationIndex:(NSUInteger)destinationIndex
{
    if ((self = [super init])) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Destinations" ofType:@"plist"];
        NSDictionary *destinations = [NSDictionary dictionaryWithContentsOfFile: filePath];
        NSArray *destinationsArray = [destinations objectForKey:@"DestinationData"];
        NSDictionary *data = [destinationsArray objectAtIndex:destinationIndex];
        
        events = [NSMutableArray arrayWithArray:[data objectForKey:@"Events"]];
        
    }
    return self;
}

- (int)numberOfEvents {
    return [events count];
}

- (NSString *)getEvent:(int)index
{
    return [events objectAtIndex:index];
}

@end
