//
//  SZPopWindow.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPopWindow.h"

@implementation SZPopWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.opaque = NO;
        self.windowLevel = 2014;
    }
    return self;
}

+ (SZPopWindow *)sharedWindow {
    static SZPopWindow *window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[SZPopWindow alloc] init];
    });
    return window;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.3] set];
    CGContextFillRect(context, self.bounds);
}

- (void)show {

    UITapGestureRecognizer *tapGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerHandler:)];
    [self addGestureRecognizer:tapGecognizer];

    [self makeKeyAndVisible];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - gesture recognizer
- (void)tapRecognizerHandler:(UITapGestureRecognizer *)tapGestureRecoginzer {
    [self hide];
}

@end
