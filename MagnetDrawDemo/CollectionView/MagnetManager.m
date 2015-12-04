//
//  MagnetManager.m
//  BreakoutSpriteKitTutorial
//
//  Created by Z on 11/21/15.
//  Copyright © 2015 Zedenem. All rights reserved.
//

#import "MagnetManager.h"
#import "CalibrateViewController.h"

@implementation MagnetManager

+ (id)sharedManager {
    static MagnetManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)setup{
    
    self.isTopBottomCalibrated = false;
    self.isPlayingPong = false;
    self.isPlayingJump = false;
    
    [self checkLocationServicesAuthorization];
    
    // setup the location manager
    self.locationManager = [[CLLocationManager alloc] init];
    
    // setup delegate callbacks
    self.locationManager.delegate = self;
    
    //request permission for the app to use location services
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // heading service configuration
    self.locationManager.headingFilter = kCLHeadingFilterNone;
    
    // start the compass
    [self.locationManager startUpdatingHeading];
    
    //initialize vector
    self.vector = [[MagnetVector alloc] init];
    
    //initialize calibration vector
    self.calibrationData = [[MagneticCalibrationData alloc] init];
}

-(void)checkLocationServicesAuthorization{
    // check if the hardware has a compass
    if ([CLLocationManager headingAvailable] == NO) {
        
        //alert user that there is no compass
        UIAlertController *noCompassAlert = [UIAlertController alertControllerWithTitle:@"No Compass" message:@"This device is not able to detect magnetic fields" preferredStyle:UIAlertControllerStyleAlert];
       // [self presentViewController:noCompassAlert animated:YES completion:^{}];
        
    } else {
        //check if location services are authorized
        //alert user that location services are disabled
        if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) ||
            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)){
            UIAlertController *noLocationServicesAlert = [UIAlertController alertControllerWithTitle:@"Location Services Disabled" message:@"Enable location services to detect magnetic fields" preferredStyle:UIAlertControllerStyleAlert];
          //  [self presentViewController:noLocationServicesAlert animated:YES completion:^{}];
        }
    }
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    
    
    if (self.isPlayingPong == true) {
         self.onHeadingUpdateListener(heading);
    } else if (self.isPlayingJump == true){
        self.onHeadingUpdateListener(heading);
    }
   
    
    self.heading = heading;
    self.vector.magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    self.vector.direction = [self rawHeadingAngleInDeg];
    
//    if ([self isCalibrated]) {
//        if (self.myView == nil) { //only called once
//            [self addBox];
//            [self logCalibrationData];
//        }
//        //moveBox
//        [self moveBox];
//    }
 //   [self logDebugData];
    
    
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}


-(CGFloat)rawHeadingAngleInDeg{
    CGFloat xVec = [[self class] degreesToRadians:self.heading.x];
    CGFloat yVec = [[self class] degreesToRadians:self.heading.y];
    //  CGFloat zVec = [[self class] degreesToRadians:self.heading.z];
    
    CGFloat rawHeading = [self rawHeadingFromX:xVec Y:yVec];
    // CGFloat rawHeadingAngle = -[[self class] degreesToRadians:rawHeading];
    return rawHeading;
}

- (CGFloat) rawHeadingFromX:(CGFloat)xVec Y:(CGFloat)yVec{
    /*
     to obtain this X and Y we really need to use the original mag XYZ and do some kind of matrix multiplication with the rotation matrix for the device.
     Here we are only using the original X and Y values, so this only works if the device is held flat.
     
     //http://stackoverflow.com/questions/11383968/which-ios-class-code-returns-the-magnetic-north/11384054#11384054
     //http://www51.honeywell.com/aero/common/documents/myaerospacecatalog-documents/Defense_Brochures-documents/Magnetic__Literature_Application_notes-documents/AN203_Compass_Heading_Using_Magnetometers.pdf
     */
    
    CGFloat rawHeading = 0;
    if (yVec > 0) rawHeading = 90.0 - atan(xVec/yVec)*180.0/M_PI;
    if (yVec < 0) rawHeading = 270.0 - atan(xVec/yVec)*180.0/M_PI;
    if (yVec == 0 && xVec < 0) rawHeading = 180.0;
    if (yVec == 0 && xVec > 0) rawHeading = 0.0;
    rawHeading -=90;
    
    //added to fix -90 -> 0 being displayed for 270 -> 360
    //may need to remove this
    if (rawHeading < 0) {
        rawHeading +=270;
    }
    
    return rawHeading;
}

#pragma mark - calibration methods

- (IBAction)calibrateLeft:(UIButton *)sender {
    self.calibrationData.left = [[MagnetVector alloc] initWithVector:self.vector];
    NSLog(@"Left Calibrated: %@",self.calibrationData.left);
}

- (IBAction)calibrateMiddle:(UIButton *)sender {
    self.calibrationData.middle = [[MagnetVector alloc] initWithVector:self.vector];
    NSLog(@"Middle Calibrated: %@",self.calibrationData.middle);
}

- (IBAction)calibrateRight:(UIButton *)sender {
    self.calibrationData.right = [[MagnetVector alloc] initWithVector:self.vector];
    NSLog(@"Right Calibrated: %@",self.calibrationData.right);
}

- (IBAction)calibrateBottom:(UIButton *)sender {
    self.calibrationData.bottom = [[MagnetVector alloc] initWithVector:self.vector];
    NSLog(@"Bottom Calibrated: %@",self.calibrationData.bottom);
}

-(BOOL)isCalibrated{
    if ((self.calibrationData.left != nil) &&
        (self.calibrationData.middle != nil) &&
        (self.calibrationData.right != nil) &&
        (self.calibrationData.bottom != nil)){
        return YES;
    }
    return NO;
}

-(void)calibrateTopBottom{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
    [top presentViewController:calibrateVC animated:YES completion: nil];
}

#pragma mark - angle conversions
+ (CGFloat) degreesToRadians:(CGFloat) degrees {return degrees * M_PI / 180;};
+ (CGFloat) radiansToDegrees:(CGFloat) radians {return radians * 180/M_PI;};

#pragma mark - debug methods

-(void)logCalibrationData{
    CGPoint leftXY = [self.calibrationData.left XYpointFromMagnitudeAndDirectionInDegrees];
    CGPoint middleXY = [self.calibrationData.middle XYpointFromMagnitudeAndDirectionInDegrees];
    CGPoint rightXY = [self.calibrationData.right XYpointFromMagnitudeAndDirectionInDegrees];
    CGPoint bottomXY = [self.calibrationData.bottom XYpointFromMagnitudeAndDirectionInDegrees];
    
    NSLog(@"~~~~~~~~~~~CALIBRATED~~~~~~~~~~");
    NSLog(@"left = %.1f,%.1f | middle = %.1f,%.1f | right = %.1f,%.1f | bottom = %.1f,%.1f",leftXY.x,leftXY.y,middleXY.x,middleXY.y,rightXY.x,rightXY.y,bottomXY.x,bottomXY.y);
}

-(void)logDebugData{
    
    // Update the labels with the raw x, y, and z values.
    NSString *Xstring = [NSString stringWithFormat:@"%.1f", self.heading.x];
    NSString *Ystring = [NSString stringWithFormat:@"%.1f", self.heading.y];
    NSString *Zstring = [NSString stringWithFormat:@"%.1f", self.heading.z];
    self.xLabel.text = Xstring;
    self.yLabel.text = Ystring;
    self.zLabel.text = Zstring;
    
    //calculate magnitude of current magnet vector
    CGFloat magnitude = sqrt(self.heading.x*self.heading.x + self.heading.y*self.heading.y + self.heading.z*self.heading.z);
    NSString *magnitudeString = [NSString stringWithFormat:@"%.1f", magnitude];
    
    //calculate direction of current magnet vector
    CGFloat rawHeadingAngleInDeg = [self rawHeadingAngleInDeg];
    
    //calculate curent physical XY location of magnetic pen on paper
    CGPoint paperXY = [self.vector XYpointFromMagnitudeAndDirectionInDegrees];
    
    //log stuff
    //NOTE WE ARE MULTIPLYING paperXY.y by -1 !!!!!!!
    NSLog(@"X = %@, Y = %@, Z = %@, Magnitude = %@, angle = %.1f, paperXY = %.1f,%.1f", Xstring,Ystring,Zstring,magnitudeString,rawHeadingAngleInDeg, paperXY.x, (paperXY.y *-1));
}

@end
