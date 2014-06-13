//
//  SZCommon.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZCommon.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation SZCommon
+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName {
    if (![paramName hasSuffix:@"="]) {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound) {
        // confirm that the parameter is not a partial name match
        unichar c = '?';
        if (start.location != 0) {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#') {
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}

+ (UIImageView *)getImageViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    return ({
        UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
        v.backgroundColor = color;
        v;
    });
}

+ (UIAlertView *) showAlertMessage:(NSString*)content {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
	alert.tag = 'e';
    
	[alert show];
    return alert;
}

+ (void)showNotFoundMessage:(NSString *)message inView:(UIView *)tableView top:(NSInteger)marginTop {
    if ([tableView viewWithTag:'n']) {
        return;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, 320, 50)];
    view.tag = 'n';
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [view addSubview: lab];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = message;
    lab.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1];
    lab.backgroundColor = [UIColor clearColor];
    [tableView addSubview:view];
}

+ (void)removeNotFoundMessageInView:(UIView *)tableView {
    [[tableView viewWithTag: 'n'] removeFromSuperview];
}

+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style {
    [self showGlobalHUDWithText:text style: style duration: 30];
}

+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style duration:(int)duration inView:(UIView *)view{
    id  del = [UIApplication sharedApplication].delegate;
    
    MBProgressHUD *global;
    UIView *container;
    view = nil;
    if (!view) {
        
        UIWindow *win = [del performSelector:@selector(window)];
        
        container = win;
        global = [[MBProgressHUD alloc] initWithWindow: win];
    } else {
        global = [[MBProgressHUD alloc] initWithView: view];
        container = view;
    }
    if ([container viewWithTag: kGlobalHUDTag]) {
        [[container viewWithTag: kGlobalHUDTag] removeFromSuperview];
    }
    
    if (style == GlobalHUDStyleProcessing) {
        global.mode = MBProgressHUDModeIndeterminate;
    } else if (style == GlobalHUDStyleFinished) {
        global.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"SZFramework.bundle/hud-succeed"]];
        global.mode = MBProgressHUDModeCustomView;
    } else {
        global.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"SZFramework.bundle/hud-failed"]];
        global.mode = MBProgressHUDModeCustomView;
    }
    global.tag = kGlobalHUDTag;
    global.labelText = text;
    [container addSubview: global];
    [global show: YES];
    
    if (duration > 0.0f) {
        [global hide: YES afterDelay: duration];
    }
}

+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style duration:(int)duration {
    [self showGlobalHUDWithText:text style: style duration: duration inView: nil];
}

+ (void)hideGlobalHUD {
    
    [SZCommon hideGlobalHUDInView: nil];
}

+ (void)hideGlobalHUDInView:(UIView *)view {
    view = nil;
    if (!view) {
        id  del = [UIApplication sharedApplication].delegate;
        //AppDelegate *myDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *win = [del performSelector:@selector(window)];
        view = win;
    }
    MBProgressHUD *global = (MBProgressHUD*)[view viewWithTag: kGlobalHUDTag];
    [global hide: YES afterDelay: 0];
}

+(CABasicAnimation *)opacityForever_Animation:(float)time

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    return  animation;
    
}



+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes

{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes

{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}



+(CABasicAnimation *)movepoint:(CGPoint )point

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
    animation.delegate= self;
    
    
    
    return animation;
    
}
@end
