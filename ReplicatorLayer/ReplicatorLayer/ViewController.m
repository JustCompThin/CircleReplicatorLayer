//
//  ViewController.m
//  ReplicatorLayer
//
//  Created by coolead on 2017/12/29.
//  Copyright © 2017年 JustCompareThin. All rights reserved.
//

#import "ViewController.h"
#pragma mark - 数学计算

#define AngleWithDegrees(deg) (M_PI * (deg) / 180.0)

#pragma mark - 动画

#define QMUIViewAnimationOptionsCurveOut (7<<16)
#define QMUIViewAnimationOptionsCurveIn (8<<16)

static const CGFloat kAnimationDuration = 0.9;

static const CGFloat kCircleContainerSize = 80;
static const NSInteger kCircleCount = 12;
static const CGFloat kCircleSize = 12;

@interface ViewController ()

@end

@implementation ViewController {
    CAReplicatorLayer *_containerLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews{
    _containerLayer = [CAReplicatorLayer layer];
    _containerLayer.masksToBounds = YES;
    _containerLayer.instanceCount = kCircleCount;
    _containerLayer.instanceDelay = kAnimationDuration / _containerLayer.instanceCount;
    _containerLayer.instanceTransform = CATransform3DMakeRotation(AngleWithDegrees(360 / _containerLayer.instanceCount), 0, 0, 1);
    [self.view.layer addSublayer:_containerLayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self beginAnimation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _containerLayer.frame = CGRectMake((CGRectGetWidth(self.view.frame) - kCircleContainerSize)*0.5 , (CGRectGetHeight(self.view.frame) - kCircleContainerSize)*0.5, kCircleContainerSize, kCircleContainerSize);
}

- (void)beginAnimation {
    CALayer *subLayer2 = [CALayer layer];
    subLayer2.backgroundColor = [UIColor blueColor].CGColor;
    subLayer2.frame = CGRectMake((kCircleContainerSize - kCircleSize) / 2, 0, kCircleSize, kCircleSize);
    subLayer2.cornerRadius = kCircleSize / 2;
    subLayer2.transform = CATransform3DMakeScale(0, 0, 0);
    [_containerLayer addSublayer:subLayer2];
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = @(1);
    animation2.toValue = @(0.1);
    animation2.repeatCount = HUGE;
    animation2.duration = kAnimationDuration;
    [subLayer2 addAnimation:animation2 forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
