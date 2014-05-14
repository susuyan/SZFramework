//
//  SZCommon.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZCommon.h"

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
@end
