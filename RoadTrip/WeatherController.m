//
//  WeatherController.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "WeatherController.h"
#import "RoadTripAppDelegate.h"
#import "Trip.h"

@implementation WeatherController
@synthesize weatherView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Delegate Methods

- (void)goBack:(id)sender
{
    [weatherView goBack];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"Back to %@", self.title] style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
        
        self.navigationItem.rightBarButtonItem = backButton;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([weatherView canGoBack] == NO) {
        self.navigationItem.rightBarButtonItem = nil;
    }
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
    self.title = @"Weather";
    self.weatherView.scalesPageToFit = YES;
    RoadTripAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.weatherView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[appDelegate.trip weather]]]];
}


- (void)viewDidUnload
{
    [self setWeatherView:nil];
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
