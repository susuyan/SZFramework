//
//  UIViewController+HUD.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIViewController+HUD.h"

@implementation UIViewController (HUD)

- (MBProgressHUD *) showSuccessHUDWithText:(NSString *)text {
    return [self showSuccessHUDWithText:text duration:100000 toView:self.view];
}

-(MBProgressHUD *) showSuccessHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view {
    [self hideAllHUD];
    
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"hud-succeed"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud hide:YES afterDelay:duration];
    return hud;
}

-(MBProgressHUD *) showSuccessHUDWithText:(NSString *)text duration:(NSTimeInterval)duration {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"hud-succeed"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud hide:YES afterDelay: duration];
    return hud;
}

- (MBProgressHUD *) showFailureHUDWithText:(NSString *)text {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"hud-failed"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    return hud;
}

- (MBProgressHUD *) showFailureHUDWithText:(NSString *)text duration:(NSTimeInterval)duration {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"hud-failed"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud hide:YES afterDelay:duration];
    return hud;
}

-(MBProgressHUD *) showFailureHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view {
    [self hideAllHUD: view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"hud-failed"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud hide:YES afterDelay:duration];
    return hud;
}

-(MBProgressHUD *) showProgressHUDWithText:(NSString *)text {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    
    hud.labelText = text;
    return hud;
}

-(MBProgressHUD *) showProgressHUDWithText:(NSString *)text duration:(NSTimeInterval)duration{
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    [hud hide:YES afterDelay:duration];
    return hud;
}

-(MBProgressHUD *) showProgressHUDWithText:(NSString *)text duration:(NSTimeInterval)duration toView:(UIView *)view {
    [self hideAllHUD: view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    [hud hide:YES afterDelay:duration];
    return hud;
}

-(MBProgressHUD *) showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.progress = progress;
    hud.labelText = text;
    return hud;
}
-(MBProgressHUD *) showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress duration:(NSTimeInterval)duration {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.progress = progress;
    hud.labelText = text;
    
    [hud hide:YES afterDelay:duration];
    
    return hud;
}
-(MBProgressHUD *) showDeterminateProgressHUDWithText:(NSString *)text progress:(float)progress duration:(NSTimeInterval)duration toView:(UIView *)view {
    [self hideAllHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.progress = progress;
    hud.labelText = text;
    
    [hud hide:YES afterDelay:duration];
    return hud;
}

- (void) hideAllHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void) hideAllHUD:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
