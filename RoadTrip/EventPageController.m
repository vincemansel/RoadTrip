//
//  EventPageController.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "EventPageController.h"
#import "RoadTripAppDelegate.h"
#import "Trip.h"

@implementation EventPageController
@synthesize eventDataView;
@synthesize activityIndicator;
@synthesize page = _page;

#pragma mark - Delegates Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:
                                       [NSString stringWithFormat:@"Back to %@", self.parentViewController.parentViewController.title]
                                        style:UIBarButtonItemStylePlain
                                        target:self action:@selector(goBack:)];
        self.parentViewController.parentViewController.navigationItem.rightBarButtonItem = backButton;
    }
    return YES;
}

- (void)goBack:(id)sender {
    [self.eventDataView goBack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    
    if ([self.eventDataView canGoBack] == NO) {
        self.parentViewController.parentViewController.navigationItem.rightBarButtonItem = nil;
    }
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
    
    self.eventDataView.delegate = self;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.eventDataView setScalesPageToFit:YES];
    RoadTripAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self.eventDataView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[appDelegate.trip getEvent:self.page]]]];
}


- (void)viewDidUnload
{
    [self setEventDataView:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
