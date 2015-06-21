//
//  DeepCreationZoomOutTransition.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 21/6/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "DeepCreationZoomOutTransition.h"

@implementation DeepCreationZoomOutTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    DeepCreationViewController* fromVC = (DeepCreationViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController* toVC = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    
    UIView* container = [transitionContext containerView];
    
    fromVC.clothImgView.alpha = 0;
    UIView* snapshootOfProduct = [fromVC.clothImgView snapshotViewAfterScreenUpdates:NO];
    snapshootOfProduct.frame = fromVC.clothImgView.frame;
    [container addSubview:snapshootOfProduct];
    
    [UIView animateWithDuration:1 animations:^{
        snapshootOfProduct.frame = toVC.imageView.frame;
        
    } completion:^(BOOL finished) {
        [container addSubview:toVC.view];
        [transitionContext completeTransition:YES];
    }];
}
@end
