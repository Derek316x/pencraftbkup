//
//  HomeCollectionViewController.m
//  CollectionView
//
//  Created by Xiulan Shi on 11/18/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "HomeCollectionViewCell.h"
#import "DetailViewController.h"
#import "CalibrateViewController.h"

#import "UIImage+animatedGIF.h"
#import "UINavigationController+Orientation.h"

#import "SKPViewController.h" //pong
#import "GameViewController.h" //jump
//#import "ViewController.h" //flappy


#import "CollectionView-Swift.h"

@interface HomeCollectionViewController ()

@property NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundImage];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
   
}

-(void)setBackgroundImage{
    NSString *pathForGif = [[NSBundle mainBundle] pathForResource: @"BackgroundWarp" ofType: @"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile: pathForGif];
    self.backgroundImageView.image = [UIImage animatedImageWithAnimatedGIFData:gifData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
                                
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) { //pong
        SKPViewController *pongVC = [[SKPViewController alloc] init];
        [self.navigationController presentViewController:pongVC animated:YES completion:^{}];
    }
    else if (indexPath.row == 1){//drop charge
        
    }
    else if (indexPath.row == 2){//jump
        
        GameViewController *jumpVC = [[GameViewController alloc] init];
        [self presentViewController:jumpVC animated:YES completion:nil];
//        [self.navigationController pushViewController:jumpVC animated:YES];
    }
    else if (indexPath.row == 3){//space invaders

    }
    
    if (indexPath.row == 4) { //calibrate
        [self showCalibrateViewController];
    }
    
    if (indexPath.row == 5) { //flappy
//        CalibrateViewController *flappyVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FlappyID"];
//        
//        [self presentViewController:flappyVC animated:YES completion:nil];
    }
    
    
}

-(void)showCalibrateViewController{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    [self presentViewController:calibrateVC animated:YES completion:nil];
    
}

- (BOOL)shouldAutorotate{
    //returns true if want to allow orientation change
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
