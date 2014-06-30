//
//  SZPhotoLoadingView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPhotoLoadingView.h"
#import "SZPhotoBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "SZPhotoProgressView.h"

@interface SZPhotoLoadingView ()
@property (strong, nonatomic) UILabel *failureLabel;
@property (strong, nonatomic) SZPhotoProgressView *progressView;
@end

@implementation SZPhotoLoadingView
- (void)setFrame:(CGRect)frame {
    [super setFrame:[UIScreen mainScreen].bounds];
}
- (void)showFailure {
    [self.progressView removeFromSuperview];
    if (self.failureLabel == nil) {
        self.failureLabel = ({
            UILabel *l = [[UILabel alloc] init];
            l.bounds = CGRectMake(0, 0, self.bounds.size.width, 44);
            l.textAlignment = NSTextAlignmentCenter;
            l.center = self.center;
            l.text = @"网络不给力，图片下载失败";
            l.font = [UIFont boldSystemFontOfSize:20];
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = [UIColor clearColor];
            l.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            l;});
        [self addSubview:self.failureLabel];
    }
}
- (void)showLoading {
    [self.failureLabel removeFromSuperview];
    if (self.progressView) {
        self.progressView = [[SZPhotoProgressView alloc] init];
        self.progressView.bounds = CGRectMake(0, 0, 60, 60);
        self.progressView.center = self.center;
    }
    self.progressView.progress = kMinProgress;
    [self addSubview:self.progressView];
}
#pragma mark - customlize method
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressView.progress = progress;
    if (progress >= 1.0) {
        [self.progressView removeFromSuperview];
    }
}
@end
