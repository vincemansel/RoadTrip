//
//  WeatherController.h
//  RoadTrip
//
//  Created by Vince Mansel on 12/4/11.
//  Copyright (c) 2011 waveOcean Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *weatherView;

@end
