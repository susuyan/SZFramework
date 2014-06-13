//
//  SZClearPopWindow.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZClearPopWindow.h"

@implementation SZClearPopWindow

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.0] set];
    CGContextFillRect(context, self.bounds);
}

@end
