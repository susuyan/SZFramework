//
//  UIViewController+HUD.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIViewController (HUD)

-(MBProgressHUD *)showSuccessHUDWithText:(NSString *)text;
-(MBProgressHUD *)showSuccessHUDWithText:(NSString *)text duration:(NSTimeInterval)duration;
-(MBProgressHUD *)showSuccessHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view;

-(MBProgressHUD *)showFailureHUDWithText:(NSString *)text;
-(MBProgressHUD *)showFailureHUDWithText:(NSString *)text duration:(NSTimeInterval)duration;
-(MBProgressHUD *)showFailureHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view;

-(MBProgressHUD *)showProgressHUDWithText:(NSString *)text;
-(MBProgressHUD *)showProgressHUDWithText:(NSString *)text duration:(NSTimeInterval)duration;
-(MBProgressHUD *)showProgressHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view;

-(MBProgressHUD *)showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress;
-(MBProgressHUD *)showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress duration:(NSTimeInterval)duration;
-(MBProgressHUD *)showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress duration:(NSTimeInterval)duration toView:(UIView *)view;

-(void) hideAllHUD;

@end
