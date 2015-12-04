//
//  StarNode.h
//  Santa
//
//  Created by Xiulan Shi on 11/30/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "GameObjectNode.h"

typedef NS_ENUM(int, StarType) {
    STAR_NORMAL,
    STAR_SPECIAL,
};


@interface StarNode : GameObjectNode

@property (nonatomic, assign) StarType starType;

@end
