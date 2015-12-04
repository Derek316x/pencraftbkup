//
//  MagnetManager.h
//  BreakoutSpriteKitTutorial
//
//  Created by Z on 11/21/15.
//  Copyright © 2015 Zedenem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MagnetVector.h"
#import "MagneticCalibrationData.h"


@interface MagnetManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLHeading *heading;

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@property (nonatomic) MagnetVector *vector;
@property (nonatomic) MagneticCalibrationData *calibrationData;

@property(nonatomic) double topCalibrationVal;
@property(nonatomic) double bottomCalibrationVal;
@property(nonatomic) double leftCalibrationVal;
@property(nonatomic) double rightCalibrationVal;

@property(nonatomic) BOOL isTopBottomCalibrated;
@property(nonatomic) BOOL isLeftRightCalibrated;

@property (nonatomic) UIView *myView;

@property (nonatomic, copy) void (^onHeadingUpdateListener)(CLHeading *);

@property(nonatomic) BOOL isPlayingPong;
@property(nonatomic) BOOL isPlayingJump;


- (void) setup;
-(void)checkLocationServicesAuthorization;
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading;
-(void)logDebugData;
-(BOOL)isTopBottomCalibrated;
-(void)calibrateTopBottom;

+ (id)sharedManager;

@end
