//
//  ViewController.m
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import "ViewController.h"
#import "DCRippleButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController{
    NSArray *_pointArray;
    NSMutableArray *_buttonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.height.constant = 0.9f;
    _pointArray = @[[NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)]];
    _buttonArray = [NSMutableArray array];
    [_pointArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint pinPoint = [obj CGPointValue];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"diyuan"] forState:UIControlStateNormal];
            button.frame = CGRectMake(self.imageView.bounds.size.width * pinPoint.x, self.imageView.bounds.size.height * pinPoint.y, 50, 50);
            [self.imageView addSubview:button];
            
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
