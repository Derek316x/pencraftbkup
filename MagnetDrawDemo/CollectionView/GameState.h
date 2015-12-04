//
//  GameState.h
//  Santa
//
//  Created by Xiulan Shi on 11/30/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

@property (nonatomic, assign) int score;
@property (nonatomic, assign) int highScore;
@property (nonatomic, assign) int stars;

+ (instancetype)sharedInstance;

- (void) saveState;


@end
