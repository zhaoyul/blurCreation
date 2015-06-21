//
//  DeepCreationViewController.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "DeepCreationViewController.h"



@interface DeepCreationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clothImgView;

@end

@implementation DeepCreationViewController

#define IMAGE_HEIGHT 700


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.clothImgView.image = self.clothImg;
    self.clothImgView.frame = CGRectMake(0, 0, IMAGE_HEIGHT, IMAGE_HEIGHT);
    CGPoint anchorPoint = CGPointMake(IMAGE_HEIGHT * self.pinPoint.x, IMAGE_HEIGHT *self.pinPoint.y);
    [self.view addSubview:self.clothImgView];
    CGPoint anchorInParent = [self.view convertPoint:anchorPoint fromView:self.clothImgView];
    CGFloat x = self.view.center.x - anchorInParent.x;
    CGFloat y = self.view.center.y - anchorInParent.y;
    self.clothImgView.transform = CGAffineTransformMakeTranslation(x, y);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}


@end
