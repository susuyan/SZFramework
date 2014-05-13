//
//  SZWindow.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZWindow.h"

@implementation SZWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.opaque = NO;
        self.windowLevel = BackgroundWindowLevel;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.9] set];
    CGContextFillRect(context, self.bounds);
}

- (void)show {
    if (!szWindow) {
        szWindow = [[SZWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tapGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerHandler:)];
        [szWindow addGestureRecognizer:tapGecognizer];
        [szWindow makeKeyAndVisible];
        szWindow.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            szWindow.alpha = 1;
        }];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        szWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [szWindow removeFromSuperview];
        szWindow = nil;
    }];
}

#pragma mark - gesture recognizer
- (void)tapRecognizerHandler:(UITapGestureRecognizer *)tapGestureRecoginzer {
    [self hide];
}

@end
