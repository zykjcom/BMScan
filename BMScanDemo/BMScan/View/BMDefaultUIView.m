//
//  BMDefaultUIView.m
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMDefaultUIView.h"
#import "UIImage+BMScan.h"

@implementation BMDefaultUIView

- (UIImageView *)scanImageView1 {
    if (!_scanImageView1) {
        _scanImageView1 = [UIImageView new];
    }
    return _scanImageView1;
}

+ (instancetype)defaultUIView {
    BMDefaultUIView *view = [[[NSBundle bundleForClass:self.class] loadNibNamed:@"BMDefaultUIView" owner:nil options:nil] firstObject];
    [view.areaView addSubview:view.scanImageView1];
    view.scanImageView1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view.scanImageView1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.areaView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view.scanImageView1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.areaView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottonConstraint = [NSLayoutConstraint constraintWithItem:view.scanImageView1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.areaView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view.scanImageView1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.areaView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [view.areaView addConstraints:@[topConstraint, leftConstraint, bottonConstraint, rightConstraint]];
    view.scanImageView1.hidden  = YES;
    view.scanfLinView.hidden    = YES;
    view.areaView.clipsToBounds = YES;
    return view;
}

- (CABasicAnimation *)getAnimation {
    
    // 说明这个动画对象要对CALayer的position属性执行动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    // 动画持续1.5s
    [self layoutIfNeeded];
    
    animation.duration = 1.3333f * (CGRectGetHeight(self.scanfAreaView.frame) / 170.0) + 0.3;

    CGRectGetMidY(self.scanfAreaView.frame);
    CGRectGetMaxY(self.scanfAreaView.frame);
    
    animation.fromValue = @(0);
    animation.toValue   = @(CGRectGetHeight(self.scanfAreaView.frame));
    animation.repeatCount = INT_MAX;

    // 保持动画执行后的状态
    animation.removedOnCompletion = NO;
    animation.autoreverses = YES;

    switch (self.scanLinViewAnimation) {
        case BMScanLinViewAnimationTypeCAFillModeForwards:
            animation.fillMode = kCAFillModeForwards;
            break;
        case BMScanLinViewAnimationTypeCAFillModeBackwards:
            animation.fillMode = kCAFillModeBackwards;
            break;
        case BMScanLinViewAnimationTypeCAFillModeBoth:
            animation.fillMode = kCAFillModeBoth;
            break;
        case BMScanLinViewAnimationTypeCAFillModeRemoved:
            animation.fillMode = kCAFillModeRemoved;
            break;
        default:
            animation.fillMode = kCAFillModeForwards;
            break;
    }
    return animation;
}

- (CABasicAnimation *)getAnimation1 {
    
    // 说明这个动画对象要对CALayer的position属性执行动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    // 动画持续1.5s
    [self.scanfAreaView layoutIfNeeded];
    
    animation.duration = 1.3333f * (CGRectGetHeight(self.scanfAreaView.frame) / 170.0) + 0.8;
    
    CGRectGetMidY(self.scanfAreaView.frame);
    CGRectGetMaxY(self.scanfAreaView.frame);
    
    animation.fromValue = @(- CGRectGetHeight(self.scanfAreaView.frame)/2.0 - 30);
    
    animation.toValue   = @(CGRectGetHeight(self.scanfAreaView.frame)/2.0 + 30);
    
    animation.repeatCount = INT_MAX;

    // 保持动画执行后的状态
    animation.removedOnCompletion = NO;
    
    switch (self.scanLinViewAnimation) {
        case BMScanLinViewAnimationTypeCAFillModeForwards:
            animation.fillMode = kCAFillModeForwards;
            break;
        case BMScanLinViewAnimationTypeCAFillModeBackwards:
            animation.fillMode = kCAFillModeBackwards;
            break;
        case BMScanLinViewAnimationTypeCAFillModeBoth:
            animation.fillMode = kCAFillModeBoth;
            break;
        case BMScanLinViewAnimationTypeCAFillModeRemoved:
            animation.fillMode = kCAFillModeRemoved;
            break;
        default:
            animation.fillMode = kCAFillModeForwards;
            break;
    }
    return animation;
}

- (void)startAnimation {
    [self stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.scanLin == BMScanLinTypeLin) {
            self.scanfLinView.hidden = NO;
            [self.scanfLinView.layer addAnimation:[self getAnimation] forKey:nil];
        } else {
            self.scanImageView1.hidden = NO;
            [self.scanImageView1.layer addAnimation:[self getAnimation1] forKey:nil];
        }
    });
}

- (void)stopAnimation {
    if (self.scanLin == BMScanLinTypeLin) {
        self.scanfLinView.hidden = YES;
        [self.scanfLinView.layer removeAllAnimations];
    } else {
        self.scanImageView1.hidden = YES;
        [self.scanImageView1.layer removeAllAnimations];
    }
}

@end
