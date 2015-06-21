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
    self.imageView.userInteractionEnabled = YES;
    
    [_pointArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint pinPoint = [obj CGPointValue];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"diyuan"] forState:UIControlStateNormal];
#define BUTTON_HEIGHT 50
            button.frame = CGRectMake(self.imageView.bounds.size.width * pinPoint.x - BUTTON_HEIGHT/2, self.imageView.bounds.size.height * pinPoint.y - BUTTON_HEIGHT/2, BUTTON_HEIGHT, BUTTON_HEIGHT);
            [self.imageView addSubview:button];
            [button setTag:idx];
            [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
        });
    }];
}

#pragma mark segue
static CGPoint pinPoint;
static UIImage *image;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DeepCreationViewController *deepVC = segue.destinationViewController;
    deepVC.pinPoint = pinPoint;
    deepVC.clothImg = image;
}

-(void)clickBtn:(UIButton*) sender{
    
    NSLog(@"Button %ld clicked", sender.tag);
    [self performSegueWithIdentifier:@"toDetail" sender:self];
    pinPoint = [(NSValue*)_pointArray[sender.tag] CGPointValue];
    image = self.imageView.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
