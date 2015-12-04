//
//  PlatformNode.h
//  Santa
//
//  Created by Xiulan Shi on 11/30/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "GameObjectNode.h"

typedef NS_ENUM(int, PlatformType) {
    PLATFORM_NORMAL,
    PLATFORM_BREAK,
};

@interface PlatformNode : GameObjectNode

@property (nonatomic, assign) PlatformType platformType;

@end
