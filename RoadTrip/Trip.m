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
#import "PointOfInterest.h"
#import "RoadTripAppDelegate.h"

@interface Trip () {
    NSDictionary *destinationData;
    Destination* destination;
    Events *events;
    NSMutableArray *pointsOfInterestData;
    NSMutableArray *pointsOfInterest;
    NSMutableArray *itineraryData;
    NSMutableArray *itinerary;
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
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        filePath = [documentsDirectory stringByAppendingPathComponent:@"POI.poi"];
        pointsOfInterestData = [NSMutableArray arrayWithContentsOfFile:filePath];
        if (!pointsOfInterestData) {
            pointsOfInterestData = [NSMutableArray arrayWithArray:[destinationData objectForKey:@"POIs"]];
            [pointsOfInterestData addObject:[destinationData objectForKey:@"DestinationLocation"] ];
            [pointsOfInterestData writeToFile:filePath atomically:YES];
        }
        pointsOfInterest = [[NSMutableArray alloc] initWithCapacity:[pointsOfInterestData count]+1];
        for (NSDictionary *aPOI in pointsOfInterestData) {
            PointOfInterest *pointOfInterest = [[PointOfInterest alloc] init];
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[aPOI objectForKey:@"Latitude"]doubleValue];
            coordinate.longitude = [[aPOI objectForKey:@"Longitude"]doubleValue];
            pointOfInterest.coordinate = coordinate;
            pointOfInterest.title = [aPOI objectForKey:@"Title"];
            pointOfInterest.subtitle = [aPOI objectForKey:@"Subtitle"];
            [pointsOfInterest addObject:pointOfInterest];
        }
        
        filePath = [documentsDirectory stringByAppendingPathComponent:@"Itineary.poi"];
        itineraryData = [NSMutableArray arrayWithContentsOfFile:filePath];
        if (!itinerary) {
            itineraryData = [[NSMutableArray alloc] initWithCapacity:1];
            [itineraryData addObjectsFromArray:pointsOfInterestData];
            [itineraryData writeToFile:filePath atomically:YES];
        }
        itinerary = [[NSMutableArray alloc] initWithCapacity:[itinerary count]+1];
        
        for (NSDictionary *aPOI in itineraryData) {
            PointOfInterest *pointOfInterest = [[PointOfInterest alloc] init];
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[aPOI objectForKey:@"Latitude"]doubleValue];
            coordinate.longitude = [[aPOI objectForKey:@"Longitude"]doubleValue];
            pointOfInterest.coordinate = coordinate;
            pointOfInterest.title = [aPOI objectForKey:@"Title"];
            pointOfInterest.subtitle = [aPOI objectForKey:@"Subtitle"];
            [itinerary addObject:pointOfInterest];
        }
    }
    return self;
}

- (NSArray *)createAnnotations
{
    NSMutableArray *annotations = [NSMutableArray arrayWithObject:destination];
    
    [annotations addObjectsFromArray:itinerary];
    return annotations;
}

- (NSString *)mapTitle
{
    return destination.destinationName;
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
