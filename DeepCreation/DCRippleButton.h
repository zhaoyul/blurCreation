//
//  DCRippleButton.h
//  DeepCreation
//
//  Created by Zhaoyu Li on 6/21/15.
//  Copyright (c) 2015 Zhaoyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

typedef void (^completion)(BOOL success);

@interface DCRippleButton : UIView{
@private
    UIImageView *imageView;
    UILabel *title;
    UITapGestureRecognizer *gesture;
    SEL methodName;
    id superSender;
    UIColor *rippleColor;
    NSArray *rippleColors;
    BOOL isRippleOn;
}

@property (nonatomic, copy) completion block;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame andTarget:(SEL)action andID:(id)sender;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completion)completionBlock;

-(void)setRippleEffectWithColor:(UIColor *)color;
-(void)setRippeEffectEnabled:(BOOL)setRippeEffectEnabled;

@end
