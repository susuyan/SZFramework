//
//  SZPresentingAnimator.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-29.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPresentingAnimator.h"
#import <POP/POP.h>

@implementation SZPresentingAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    fromView.userInteractionEnabled = NO;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = [UIColor lightGrayColor];
    dimmingView.layer.opacity = 1.0;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.fromValue = @(transitionContext.containerView.layer.position.y - transitionContext.containerView.frame.size.height);
    positionAnimation.toValue = @(transitionContext.containerView.layer.position.y);
    [positionAnimation setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.2);
    
    [toView.layer pop_addAnimation:positionAnimation forKey:@"inscreenAnimation"];
    //[toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    //[dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}
@end
