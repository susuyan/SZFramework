//
//  SZCommon.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZCommon : NSObject
+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName;

+ (UIImageView *)getImageViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

+ (UIAlertView *) showAlertMessage:(NSString*)content;
@end
