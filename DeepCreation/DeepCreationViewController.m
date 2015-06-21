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

@implementation DeepCreationViewController{
    UIImageView *blureImageView;
}

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
    blureImageView = [UIImageView new];
    blureImageView.frame = self.clothImgView.frame;
    
    self.navigationController.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self dimImage];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [blureImageView removeFromSuperview];
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
    UIImage *toBeBluredImage = self.clothImgView.image;
    {
        GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:toBeBluredImage];
        GPUImageGaussianSelectiveBlurFilter *blurFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
        [blurFilter setExcludeCircleRadius:0.13f];
        CGPoint pointInImage = [self.clothImgView convertPoint:self.view.center fromView:self.view];
        CGPoint relateivePoint = CGPointMake(pointInImage.x/IMAGE_HEIGHT, pointInImage.y/IMAGE_HEIGHT);
        [blurFilter setExcludeCirclePoint:relateivePoint];
        
        [blurFilter setBlurRadiusInPixels:15];
        [stillImageSource addTarget:blurFilter];
        [blurFilter useNextFrameForImageCapture];
        [stillImageSource processImage];
        
        UIImage *currentFilteredVideoFrame = [blurFilter imageFromCurrentFramebuffer];
        blureImageView.image = currentFilteredVideoFrame;
        [self.view addSubview:blureImageView];
        
        [self cutHoleInImageView:blureImageView atPoint:pointInImage withRadius:100];

    }
    
    GPUImageBrightnessFilter *brightFilter = [[GPUImageBrightnessFilter alloc] init];
    brightFilter.brightness = 0.01;
    
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    
    [stillImageSource addTarget:brightFilter];
    [brightFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [brightFilter imageFromCurrentFramebuffer];
    self.clothImgView.image = currentFilteredVideoFrame;
    
}

-(void)cutHoleInImageView:(UIImageView*)imageView atPoint:(CGPoint)point withRadius: (float)circleRadius
{
    CGRect imageViewFrame = imageView.bounds;
    CGRect circleFrame = CGRectMake(point.x-circleRadius/2,point.y-circleRadius/2,circleRadius,circleRadius);
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, circleFrame);
    CGPathAddRect(path, nil, imageViewFrame);
    shapeLayer.path = path;
    CGPathRelease(path);
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    imageView.layer.mask = shapeLayer;
}
@end
