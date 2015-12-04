//
//  GameScene.h
//  Santa
//

//  Copyright (c) 2015 Xiulan Shi. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MagnetManager.h"

@interface GameScene : SKScene

@property(nonatomic) MagnetManager *manager;
@property(nonatomic) NSMutableArray *lastTenXPositions;

@end
