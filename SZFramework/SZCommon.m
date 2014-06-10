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

@end
