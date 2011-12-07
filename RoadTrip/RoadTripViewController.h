//
//  RoadTripViewController.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/2/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoadTripViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *car;
@property (weak, nonatomic) IBOutlet UIButton *testDriveButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

- (IBAction)testDrive:(id)sender;
- (void)rotate;
- (void)returnCar;
- (void)continueRotation;

@end
