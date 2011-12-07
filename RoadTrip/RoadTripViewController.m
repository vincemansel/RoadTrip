//
//  RoadTripViewController.m
//  RoadTrip
//
//  Created by Vince Mansel on 12/2/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import "RoadTripViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface RoadTripViewController () {
    AVAudioPlayer *backgroundAudioPlayer;
    SystemSoundID burnRubberSoundID;
    BOOL touchInCar;
}
@end

@implementation RoadTripViewController
@synthesize car;
@synthesize testDriveButton;
@synthesize backgroundImage;

#pragma mark - Override Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(car.frame, [touch locationInView:self.view]))
        touchInCar = YES;
    else {
        touchInCar = NO;
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchInCar) {
        UITouch *touch = [touches anyObject];
        car.center = [touch locationInView:self.view];
    }
    else
        [super touchesMoved:touches withEvent:event];
}

#pragma mark - Added Selectors

- (IBAction)handleSwipeGesture:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"Content"];
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma mark - Default Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Road Trip";
    
    NSURL *backgroundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"CarRunning" ofType:@"aif"]];
    backgroundAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundURL error:nil];
    backgroundAudioPlayer.numberOfLoops = -1;
    [backgroundAudioPlayer prepareToPlay];
    
    NSURL* burnRubberURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BurnRubber" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)burnRubberURL, &burnRubberSoundID);
    
    [testDriveButton setBackgroundImage:[UIImage animatedImageNamed:@"Button" duration:1.0] forState:UIControlStateNormal];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)viewDidUnload
{
    [self setCar:nil];
    [self setTestDriveButton:nil];
    [self setBackgroundImage:nil];
   [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom methods

- (IBAction)testDrive:(id)sender {
    NSLog(@"testDriveButton Pressed");
    
    AudioServicesPlaySystemSound(burnRubberSoundID);
    [self performSelector:@selector(playCarSound) withObject:self afterDelay:.2];
    
    
    
    CGPoint center = CGPointMake(car.center.x, self.view.frame.origin.y + car.frame.size.height/2);
    
    void (^animation)() = ^() {
        car.center = center;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
    [self rotate];
    };
    
    [UIView animateWithDuration:3 animations:animation completion:completion];  
    
}


- (void)rotate
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
    
    void (^animation)() = ^(){
        car.transform = transform;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        [self returnCar];
    };
    
    [UIView animateWithDuration:2 animations:animation completion:completion];  

}
- (void)returnCar
{
//    UIImage *carWheelie = [UIImage imageNamed:@"carWheelie2.png"];
//    carWheelie. = CGSizeMake(self.car.image.size.width * 2, self.car.image.size.height);
//    self.car.image = carWheelie;

    CGPoint center = CGPointMake(car.center.x, self.view.frame.origin.y +
                                 self.view.frame.size.height - car.frame.size.height/2);
    
    void (^animation)() = ^() {
        car.center = center;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        [self continueRotation];
    };
    
    [UIView animateWithDuration:2 animations:animation completion:completion];  

}

- (void)continueRotation
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    
    void (^animation)() = ^(){
        car.transform = transform;
//        self.car.image = [UIImage imageNamed:@"carImage.png"];
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        [backgroundAudioPlayer stop];
        [backgroundAudioPlayer prepareToPlay];
    };
    
    [UIView animateWithDuration:1 animations:animation completion:completion];
}

- (void)playCarSound
{
    [backgroundAudioPlayer play];
}

@end
