//
//  DeepCreationViewController.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "DeepCreationViewController.h"
#import "DeepCreationZoomInTransition.h"



@interface DeepCreationViewController () <UINavigationControllerDelegate>

@end

@implementation DeepCreationViewController

#define IMAGE_HEIGHT 700


- (void)viewDidLoad {
    [super viewDidLoad];
    self.clothImgView.image = self.clothImg;
    self.clothImgView.frame = CGRectMake(0, 0, IMAGE_HEIGHT, IMAGE_HEIGHT);
    CGPoint anchorPoint = CGPointMake(IMAGE_HEIGHT * self.pinPoint.x, IMAGE_HEIGHT *self.pinPoint.y);
    [self.view addSubview:self.clothImgView];
    CGPoint anchorInParent = [self.view convertPoint:anchorPoint fromView:self.clothImgView];
    CGFloat x = self.view.center.x - anchorInParent.x;
    CGFloat y = self.view.center.y - anchorInParent.y;
    self.clothImgView.transform = CGAffineTransformMakeTranslation(x, y);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UINavigationControllerDelegate

@end
