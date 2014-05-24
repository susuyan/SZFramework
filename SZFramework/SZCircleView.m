//
//  SZCircleView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-23.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZCircleView.h"

static const NSInteger kFullPercent = 100;
static const CGFloat kAnimationTime = 0.5;
static const CGFloat kRoundTopHeight = 0.0;
//static const CGFloat kColorViewHeight = 230;

@interface SZCircleView () {
    UIImageView *_bg;
    
    UIView* _leftView;
    UIView* _rightView;
    
    UIView* _maskView1;
    UIView* _maskView2;
    
    CALayer* _maskLayer1;
    CALayer* _maskLayer2;
    CALayer* _roundLayer;
    
    CGFloat kColorViewHeight;
    
    BOOL _isAnimation;
    
    CGFloat _animationPercentage;       // 为了实现动画，需要使用delegate分布执行，保存动画值。
}

@end


@implementation SZCircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _bg = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_bg];
        
        CGSize size = frame.size;
        CGFloat ww = size.width;
        
        kColorViewHeight = ww;
        
        // 左边的圆
        _leftView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ww/2, ww)];
        

        _leftView.clipsToBounds = YES;
        
        [self addSubview: _leftView];
        
        // 右边的圆
        _rightView = [[UIView alloc] initWithFrame: CGRectMake(ww/2, 0, ww/2, ww)];
        _rightView.clipsToBounds = YES;
        
        [self addSubview: _rightView];
        
        // 运动的遮罩,左边
        _maskView1 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, kColorViewHeight, kColorViewHeight)];
        _maskView1.backgroundColor = [UIColor clearColor];
        
        _maskLayer1 = [[CALayer alloc] init];
        _maskLayer1.masksToBounds = NO;
        _maskLayer1.backgroundColor = [UIColor blackColor].CGColor;
        _maskLayer1.anchorPoint = CGPointMake(0, 0.5);
        _maskLayer1.frame = CGRectMake(CGRectGetWidth(_maskView1.frame)/2, 0 , CGRectGetWidth(_maskView1.frame), CGRectGetHeight(_maskView1.frame));
        [_maskView1.layer addSublayer: _maskLayer1];
        
        CALayer* roundLayer1l = [[CALayer alloc] init];
        roundLayer1l.masksToBounds = YES;
        CGRect frame = _maskView1.frame;
        roundLayer1l.frame = CGRectMake(frame.size.width/2 - kRoundTopHeight/2, 0, kRoundTopHeight, kRoundTopHeight);
        roundLayer1l.cornerRadius = CGRectGetHeight(roundLayer1l.frame)/2;
        roundLayer1l.backgroundColor = [UIColor blackColor].CGColor;
        [_maskView1.layer addSublayer: roundLayer1l];
        
        
        // 步数显示圆角的遮罩
        _roundLayer = [[CALayer alloc] init];
        _roundLayer.masksToBounds = YES;
        _roundLayer.frame = CGRectMake(-kRoundTopHeight/2, frame.size.height-kRoundTopHeight, kRoundTopHeight, kRoundTopHeight);
        _roundLayer.cornerRadius = CGRectGetHeight(_roundLayer.frame)/2;
        _roundLayer.backgroundColor = [UIColor blackColor].CGColor;
        [_maskLayer1 addSublayer: _roundLayer];
        
        
        _leftView.layer.mask = _maskView1.layer;
        
        // 运动的遮罩
        _maskView2 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, kColorViewHeight, kColorViewHeight)];
        _maskView2.backgroundColor = [UIColor clearColor];
        _maskView2.clipsToBounds = YES;
        
        _maskLayer2 = [[CALayer alloc] init];
        _maskLayer2.masksToBounds = NO;
        _maskLayer2.backgroundColor = [UIColor blackColor].CGColor;
        _maskLayer2.anchorPoint = CGPointMake(1, 0.5);
        _maskLayer2.frame = CGRectMake( -CGRectGetWidth(_maskView2.frame), 0, CGRectGetWidth(_maskView2.frame), CGRectGetHeight(_maskView2.frame));
        [_maskView2.layer addSublayer: _maskLayer2];
        
        
        frame = _maskView2.frame;
        
        CALayer* roundLayer2 = [[CALayer alloc] init];
        roundLayer2.masksToBounds = YES;
        roundLayer2.frame = CGRectMake(frame.size.width-kRoundTopHeight/2, 0, kRoundTopHeight, kRoundTopHeight);
        roundLayer2.cornerRadius = CGRectGetHeight(roundLayer2.frame)/2;
        roundLayer2.backgroundColor = [UIColor blackColor].CGColor;
        [_maskLayer2 addSublayer: roundLayer2];
        
        //        _maskView2.right = 0;
        _rightView.layer.mask = _maskView2.layer;
        
    }
    return self;
}

- (void)bindLeftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage backgroundImage:(UIImage *)backgroundImage {
    CGFloat ww = self.frame.size.width;
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ww, ww)];
    leftImageView.image = leftImage;
    [_leftView addSubview: leftImageView];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-ww/2, 0, ww, ww)];
    rightImageView.image = rightImage;
    [_rightView addSubview: rightImageView];
    
    _bg.image = backgroundImage;
}
// 直接设置步数
- (void) setPercent:(NSInteger)percent {
    
    _percent = percent;
    
    // 如果正在动画中，则不破坏动画的动作
    if (_isAnimation && percent!=kFullPercent) {
        return;
    }
    if (percent >= kFullPercent) {
        percent = kFullPercent;
    }
    
    [_maskLayer1 removeAllAnimations];
    [_maskLayer2 removeAllAnimations];
    [_roundLayer removeAllAnimations];
    
    CGFloat rad = 2 * M_PI * percent/kFullPercent;
    
    
    if (rad <= M_PI) {
        
        // 只有右半球
        _maskLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(0));
        _maskLayer2.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(rad));
        
        // 需要设置左边最下面的圆角
        CGFloat rad1 = M_PI - rad;
        _roundLayer.frame = CGRectMake(-kRoundTopHeight/2 + (kColorViewHeight/2-kRoundTopHeight/2) * sin(rad1),
                                       kColorViewHeight - kRoundTopHeight + (kColorViewHeight/2-kRoundTopHeight/2)*(1-cos(rad1)),
                                       kRoundTopHeight, kRoundTopHeight);
        
    } else {
        
        // 左
        _maskLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(rad - M_PI));
        _maskLayer2.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI));
        
        _roundLayer.frame = CGRectMake(-kRoundTopHeight/2, kColorViewHeight - kRoundTopHeight, kRoundTopHeight, kRoundTopHeight);
        //        _roundLayer.frame = CGRectMake(-kRoundTopHeight/2, _maskView1.height-kRoundTopHeight, kRoundTopHeight, kRoundTopHeight);
    }
}

// 通过动画设置步数
- (void) animationWithPercent:(NSInteger)percent {
    
    _percent = percent;
    
    _isAnimation = YES;
    
    // 到当前步数
    CGFloat percentage = (CGFloat)_percent/kFullPercent;
    if (percentage >1) {
        return;
    }
    
    // 需要分布执行，则需要先保存动画的值
    _animationPercentage = percentage;
    
    
    if (percentage >= 0.5) {
        
        // 只有左边的动画
        //        [UIView animateWithDuration: (1-percentage) * kAnimationTime+0.2
        //                         animations: ^{
        ////                             _maskView1.transform = CGAffineTransformMakeRotation(2*(percentage-0.5) * M_PI);
        //                             _maskLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(2*(percentage-0.5) * M_PI));
        //                         }
        //                         completion: ^(BOOL finished) {
        //                             _isAnimation = NO;
        //                         }];
        
        
        CABasicAnimation* leftAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
        leftAnimation.delegate = self;
        [leftAnimation setValue: @"left_only" forKey: @"mode"];
        leftAnimation.removedOnCompletion = NO;
        leftAnimation.fillMode = kCAFillModeForwards;
        leftAnimation.duration = (1-percentage) * kAnimationTime+0.2;
        
        // 动画终了后不返回初始状态
        leftAnimation.fromValue = @(M_PI);
        leftAnimation.toValue = @(2*(percentage-0.5) * M_PI);
        
        [_maskLayer1 addAnimation: leftAnimation
                           forKey: @"leftAnimation"];
        
    } else {
        
        // 先做左边的动画。在做右边的动画
        //        [UIView animateWithDuration: kAnimationTime/2
        //                              delay: 0.1
        //                            options: UIViewAnimationOptionCurveLinear
        //                         animations: ^{
        ////                             _maskView1.transform = CGAffineTransformMakeRotation(0);
        //                             _maskLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(0));
        //                         }
        //                         completion:^(BOOL finished) {
        //
        //                             [UIView animateWithDuration: (0.5 - percentage)*kAnimationTime
        //                                                   delay: 0
        //                                                 options: UIViewAnimationOptionCurveLinear
        //                                              animations: ^{
        ////                                                  _maskView2.transform = CGAffineTransformMakeRotation(2*percentage * M_PI+0.0001);
        //                                                  _maskLayer2.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(2*percentage * M_PI+0.0001));
        //                                              }
        //                                              completion: ^(BOOL finished) {
        //                                                  _isAnimation = NO;
        //                                              }];
        //                         }];
        
        
        
        // 先进行左边的动画
        CABasicAnimation* leftAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
        [leftAnimation setValue: @"left_and_right" forKey: @"mode"];
        leftAnimation.removedOnCompletion = NO;
        leftAnimation.fillMode = kCAFillModeForwards;
        leftAnimation.delegate = self;
        leftAnimation.duration = kAnimationTime/2;
        leftAnimation.fromValue = @(M_PI);
        leftAnimation.toValue = @(0);
        
        [_maskLayer1 addAnimation: leftAnimation
                           forKey: @"leftAnimation"];
        
        
    }
}

#pragma - mark CABasicAnimationDelegate
// 这个代理为了实现右边的动画，是左边的动画完成后顺序执行的
- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        
        NSString* name = [anim valueForKey: @"mode"];
        if ([name isEqualToString: @"left_only"]) {
            
            // 设置左边的位置
            _isAnimation = NO;
            return;
        }else if ([name isEqualToString: @"right_only"]) {
            
            // 设置右边的位置
            _isAnimation = NO;
            return;
        } else {
            
            
            // 左边的圆角小圆也需要改变位置
            
            
            CGFloat rad1 = M_PI * (0.5 - _animationPercentage);
            if (rad1 > 0.1) {
                rad1 = 0.1;
            }
            _roundLayer.frame = CGRectMake(-kRoundTopHeight/2 + (kColorViewHeight/2-kRoundTopHeight/2) * sin(rad1*2),
                                           kColorViewHeight - kRoundTopHeight + (kColorViewHeight/2-kRoundTopHeight/2)*(1-cos(rad1)),
                                           kRoundTopHeight, kRoundTopHeight);
            
            CABasicAnimation* roundAnimation = [CABasicAnimation animationWithKeyPath: @"position"];
            roundAnimation.duration = 0.02;
            roundAnimation.toValue = [NSValue valueWithCGPoint: CGPointMake((kColorViewHeight/2-kRoundTopHeight/2) * sin(rad1*2),
                                                                            kColorViewHeight - kRoundTopHeight/2 + (kColorViewHeight/2-kRoundTopHeight/2)*(1-cos(rad1)))];
            roundAnimation.removedOnCompletion = NO;
            roundAnimation.fillMode = kCAFillModeForwards;
            [_roundLayer addAnimation: roundAnimation forKey: @"round"];
            
            
            
            
            // 右边的动画
            
            CABasicAnimation* rightAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
            [rightAnimation setValue: @"right_only" forKey: @"mode"];
            rightAnimation.delegate = self;
            rightAnimation.removedOnCompletion = NO;
            rightAnimation.fillMode = kCAFillModeForwards;
            rightAnimation.duration = (0.5 - _animationPercentage)*kAnimationTime;
            rightAnimation.fromValue = @(M_PI);
            
            rightAnimation.toValue = @(2*_animationPercentage * M_PI);
            [_maskLayer2 addAnimation: rightAnimation
                               forKey: @"rightAnimation"];
        }
    }
}

@end
