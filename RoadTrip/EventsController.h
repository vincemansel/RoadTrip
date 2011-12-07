//
//  EventsController.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventPageController;

@interface EventsController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

- (EventPageController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;


@end
