//
//  HomeCollectionViewCell.m
//  CollectionView
//
//  Created by Xiulan Shi on 11/18/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    
    // background color
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = bgView;
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    
    // selected background
    UIView *selectedView = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedView;
//    self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink"]];
    
    self.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
}

@end
