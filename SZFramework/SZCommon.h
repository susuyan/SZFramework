//
//  SZCommon.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGlobalHUDTag 99999

typedef NS_ENUM (NSInteger, GlobalHUDStyle){
    GlobalHUDStyleFinished = 0,
    GlobalHUDStyleProcessing,
    GlobalHUDStyleFailed
};

@interface SZCommon : NSObject
+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName;

+ (UIImageView *)getImageViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

+ (UIAlertView *)showAlertMessage:(NSString*)content;

+ (void)showNotFoundMessage:(NSString *)message inView:(UIView *)tableView top:(NSInteger)marginTop;
+ (void)removeNotFoundMessageInView:(UIView *)tableView;

+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style;
+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style duration:(int)duration inView:(UIView *)view;
+ (void)showGlobalHUDWithText:(NSString*)text style:(GlobalHUDStyle)style duration:(int)duration;
+ (void)hideGlobalHUD;
+ (void)hideGlobalHUDInView:(UIView *)view;

@end
