//
//  DeepCreationZoomTransition.m
//  
//
//  Created by Zhaoyu Li on 21/6/15.
//
//

#import "DeepCreationZoomTransition.h"
#import "DeepCreationViewController.h"
#import "ViewController.h"

@implementation DeepCreationZoomTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ViewController* fromVC = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DeepCreationViewController* toVC = (DeepCreationViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    [toVC.view layoutIfNeeded];
    
    UIView* container = [transitionContext containerView];
    
    fromVC.imageView.alpha = 0;
    UIView* snapshootOfProduct = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapshootOfProduct.frame = fromVC.imageView.frame;
    [container addSubview:snapshootOfProduct];
    
    [UIView animateWithDuration:1 animations:^{
        snapshootOfProduct.frame = toVC.clothImgView.frame;
        
    } completion:^(BOOL finished) {
        fromVC.imageView.alpha = 1;
        [container addSubview:toVC.view];
        [transitionContext completeTransition:YES];
    }];
}

@end
