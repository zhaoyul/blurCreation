//
//  ViewController.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ViewController.h"
#import "DeepCreationViewController.h"
#import "DCRippleButton.h"
#import "DeepCreationZoomInTransition.h"

@interface ViewController () <UINavigationControllerDelegate>
@end

@implementation ViewController{
    NSArray *_pointArray;
    NSMutableArray *_buttonArray;
    CGPoint _pinPoint;
    UIImage *_image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0.5, 0.1)],
                    [NSValue valueWithCGPoint:CGPointMake(0.4, 0.7)],
                    [NSValue valueWithCGPoint:CGPointMake(0.5, 0.2)],
                    [NSValue valueWithCGPoint:CGPointMake(0.6, 0.7)],
                    [NSValue valueWithCGPoint:CGPointMake(0.3, 0.8)],
                    ];
    _buttonArray = [NSMutableArray array];
    self.imageView.userInteractionEnabled = YES;
    
    [_pointArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint pinPoint = [obj CGPointValue];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"diyuan"] forState:UIControlStateNormal];
#define BUTTON_HEIGHT 40
            button.frame = CGRectMake(self.imageView.bounds.size.width * pinPoint.x - BUTTON_HEIGHT/2, self.imageView.bounds.size.height * pinPoint.y - BUTTON_HEIGHT/2, BUTTON_HEIGHT, BUTTON_HEIGHT);
            [self.imageView addSubview:button];
            [button setTag:idx];
            [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
        });
    }];
}

#pragma mark segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DeepCreationViewController *deepVC = segue.destinationViewController;
    deepVC.pinPoint = _pinPoint;
    deepVC.clothImg = _image;
}

-(void)clickBtn:(UIButton*) sender{
    
    self.navigationController.delegate = self;
    NSLog(@"Button %ld clicked", sender.tag);
    _pinPoint = [(NSValue*)_pointArray[sender.tag] CGPointValue];
    _image = self.imageView.image;
    [self performSegueWithIdentifier:@"toDetail" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    self.navigationController.delegate = nil;
    if ([fromVC isMemberOfClass:[self class]] && [toVC isMemberOfClass:[DeepCreationViewController class]]) {
        return [DeepCreationZoomInTransition new];
    }
    return nil;
}
@end
