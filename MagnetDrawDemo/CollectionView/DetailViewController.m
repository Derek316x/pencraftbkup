//
//  DetailViewController.m
//  CollectionView
//
//  Created by Xiulan Shi on 11/18/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
}

@end
