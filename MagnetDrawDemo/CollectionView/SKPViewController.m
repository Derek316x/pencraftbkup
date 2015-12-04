//
//  SKPViewController.m
//  Sprite Kit Pong
//
//  Created by Božidar Ševo on 10/05/14.
//  Copyright (c) 2014 Božidar Ševo. All rights reserved.
//

#import "SKPViewController.h"
#import "SKPMyScene.h"
#import <SpriteKit/SpriteKit.h>
#import "CalibrateViewController.h"

#import "UINavigationController+Orientation.h"


@implementation SKPViewController

-(void)loadView{
    self.view = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad{
    [super viewDidLoad];

//    // Configure the view.
    SKView *skView = (SKView*)self.view;
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    CGFloat w = skView.bounds.size.width;
    CGFloat h = skView.bounds.size.height;
    CGSize sceneSize = CGSizeMake(w, h);
    //to make sure that scene size is made for landscape mode :)
    if (h > w) {
        sceneSize = CGSizeMake(h, w);
    }
    
    SKScene * scene = [SKPMyScene sceneWithSize:sceneSize];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void)pongCalibrateTopBottom{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    UIViewController *top = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [top presentViewController:calibrateVC animated:YES completion: nil];
    
}

- (BOOL)shouldAutorotate{
    //returns true if want to allow orientation change
    return TRUE;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
