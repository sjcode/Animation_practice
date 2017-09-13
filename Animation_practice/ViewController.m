//
//  ViewController.m
//  Animation_practice
//
//  Created by sujian on 15/9/6.
//  Copyright (c) 2015年 sujian. All rights reserved.
//

#import "ViewController.h"
@import QuartzCore;
//#import <QuartzCore/QuartzCore.h>

#define WIDTH 50
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PP(p)\
    NSLog(@"point = %@",NSStringFromCGPoint(p));

#define PR(r)\
    NSLog(@"rect = %@",NSStringFromCGRect(r));

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong)  CALayer *colorLayer;
@property (nonatomic, strong)  CALayer *subLayer;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIView *passView;


@property (nonatomic, strong) CALayer *motionLayer;
@property (nonatomic, strong) UIImage *motionImage;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (nonatomic, strong) CALayer *subColorLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.passTextField.layer.borderWidth = 2;
    
    
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CALayer *subLayer = [CALayer layer];
    subLayer.backgroundColor = [UIColor yellowColor].CGColor;
    subLayer.bounds = CGRectMake(0, 0, 30, 30);
    subLayer.contents = (id)[UIImage imageNamed:@"snowman"].CGImage;
    subLayer.position = CGPointMake(CGRectGetMidX(self.redView.bounds), CGRectGetMidY(self.redView.bounds));
    [self.redView.layer addSublayer:subLayer];
    
    PR(subLayer.bounds);
    PP(subLayer.position);
    PP(subLayer.anchorPoint);
    
    
    
    
    self.motionImage = [UIImage imageNamed:@"snowman"];
    self.motionLayer = [CALayer layer];
    
    self.motionLayer.contents = (__bridge id)(self.motionImage.CGImage);
    self.motionLayer.frame = CGRectMake(0, 300, self.motionImage.size.width, self.motionImage.size.height);
    
    [self.view.layer addSublayer:self.motionLayer];
    
    
    
    self.subColorLayer = [CALayer layer];
    self.subColorLayer.backgroundColor = [UIColor yellowColor].CGColor;
    self.subColorLayer.frame = CGRectMake(50, 50, 100, 100);
    [self.colorView.layer addSublayer:self.subColorLayer];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    self.subColorLayer.actions = @{@"backgroundColor" : transition};
}

- (IBAction)motion:(id)sender {
    CGFloat newY = self.motionLayer.position.y;
    CGFloat newX = SCREEN_WIDTH-self.motionImage.size.width/2;
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"position.x";
    animation.fromValue = @(self.motionImage.size.width/2);
    animation.toValue = @(newX);
    animation.duration = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [self.motionLayer addAnimation:animation forKey:@"slide"];
    
    self.motionLayer.position = CGPointMake(newX, newY);
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
   
}
- (IBAction)sharek:(id)sender {
    /*
    CALayer *layer = self.redView.layer.sublayers[0];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    //CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, self.redView.frame.size.width, self.redView.frame.size.height), NULL);
    CGRect frame = self.redView.bounds;
    frame = CGRectInset(frame, -60,-60);
    //CGPathRef path = CGPathCreateWithRoundedRect(frame, 5, 5, NULL);
    CGPathRef path = CGPathCreateWithEllipseInRect(frame, NULL);
    animation.path = path;
    animation.duration = 4;
    animation.additive = YES;
    animation.repeatCount = HUGE_VALF;
    animation.calculationMode = kCAAnimationPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    [layer addAnimation:animation forKey:@"around"];
    CFAutorelease(path);
     */
     
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[@0, @10 ,@-10, @10, @0];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = .3;
    animation.additive = YES;

    [self.passView.layer addAnimation:animation forKey:nil];
    
    /*
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @77;
    animation.toValue = @455;
    animation.duration = 1;
    animation.additive = YES;
    [self.passTextField.layer addAnimation:animation forKey:@"basic"];
     */
    

}
- (IBAction)changecolor:(id)sender {
    /*
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 1;
    animation.fromValue = (__bridge id)self.subColorLayer.backgroundColor;
    self.subColorLayer.backgroundColor = color.CGColor;
    animation.toValue = (__bridge id)(color.CGColor);

    [self.subColorLayer addAnimation:animation forKey:nil];
     */
    /*
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.subColorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.subColorLayer.affineTransform = transform;
    }];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.subColorLayer.backgroundColor = color.CGColor;
    [CATransaction commit];
     */
    
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    self.subColorLayer.backgroundColor = color.CGColor;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [self.subColorLayer addAnimation:animation forKey:nil];
}

@end
