//
//  DeepCreationViewController.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "DeepCreationViewController.h"
#import "DeepCreationZoomOutTransition.h"
#import <GPUImage.h>



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
    
    self.navigationController.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self dimImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self dimImage];
    // Dispose of any resources that can be recreated.
}

#pragma mark UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    self.navigationController.delegate = nil;
    return [DeepCreationZoomOutTransition new];
}

#pragma mark GPUImage
-(void) dimImage{
    UIImage *inputImage = self.clothImgView.image;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageGaussianSelectiveBlurFilter *stillImageFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
    [stillImageFilter setExcludeCircleRadius:0.15f];
    CGPoint pointInImage = [self.clothImgView convertPoint:self.view.center fromView:self.view];
    CGPoint relateivePoint = CGPointMake(pointInImage.x/IMAGE_HEIGHT, pointInImage.y/IMAGE_HEIGHT);
    [stillImageFilter setExcludeCirclePoint:relateivePoint];
    
    [stillImageFilter setBlurRadiusInPixels:5];
    
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    self.clothImgView.image = currentFilteredVideoFrame;
}
@end
