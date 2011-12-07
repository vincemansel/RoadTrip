//
//  EventsController.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "EventsController.h"
#import "RoadTripAppDelegate.h"
#import "Trip.h"
#import "EventPageController.h"

@interface EventsController () {
    NSUInteger pageCount;
    UIPageViewController *pageViewController;
}
@end

@implementation EventsController

#pragma mark - Custom Methods

- (EventPageController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    if ((pageCount == 0) || (index >= pageCount)) {
        return nil;
    }
    EventPageController *eventPageController = [storyboard instantiateViewControllerWithIdentifier:@"EventPageController"];
    eventPageController.page = index;
    return eventPageController;
}

#pragma mark - Delegate Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EventPageController *)viewController).page;
    if (index == 0) return nil;
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EventPageController *)viewController).page;
    index++;
    if (index == pageCount) return nil;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}



#pragma mark - Supplied Stubs

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RoadTripAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    pageCount = [delegate.trip numberOfEvents];
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                       options:nil];
    pageViewController.dataSource = self;
//    pageViewController.delegate = self;
    
    EventPageController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = [NSArray arrayWithObject:startingViewController];
    [pageViewController setViewControllers:viewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:NULL];
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    self.view.gestureRecognizers = pageViewController.gestureRecognizers;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
