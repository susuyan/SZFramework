//
//  SZPhotoView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPhotoView.h"
#import "SZPhoto.h"
#import "SZPhotoLoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SZPhotoView ()
@property (assign, nonatomic) BOOL doubleTap;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) SZPhotoLoadingView *photoLoadingView;
@end

@implementation SZPhotoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.frame = frame;
        [self addSubview:self.imageView];
        
        self.photoLoadingView = [[SZPhotoLoadingView alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}
#pragma mark - setter
- (void)setPhoto:(SZPhoto *)photo {
    _photo = photo;
    [self showImage];
}
- (void)showImage {
    if (self.photo.firstShow) {
        self.imageView.image = self.photo.placeHolder;
        self.photo.srcImageView.image = nil;
        
        if (![self.photo.url.absoluteString hasSuffix:@"gif"]) {
            __block SZPhotoView *photoView = self;
            __block SZPhoto *photo = self.photo;
            [self.imageView setImageWithURL:self.photo.url
                           placeholderImage:self.photo.placeHolder
                                    options:SDWebImageRetryFailed | SDWebImageLowPriority
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                               photo.image = image;
                               [photoView adjustFrame];
                           }];
        }
    } else {
        [self photoStartLoad];
    }
    [self adjustFrame];
}
#pragma mark - load image
- (void)photoStartLoad {
    if (self.photo.image) {
        self.scrollEnabled = YES;
        self.imageView.image = self.photo.image;
    } else {
        self.scrollEnabled = NO;
        
        [self.photoLoadingView showLoading];
        [self addSubview:self.photoLoadingView];
        
        __block SZPhotoView *photoView = self;
        __block SZPhotoLoadingView *photoLoadingView = self.photoLoadingView;
        [self.imageView setImageWithURL:self.photo.url
                       placeholderImage:self.photo.srcImageView.image
                                options:SDWebImageRetryFailed | SDWebImageLowPriority
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  if (receivedSize > kMinProgress) {
                                      photoLoadingView.progress = (float)receivedSize/expectedSize;
                                  }
                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                  [photoView photoDidFinishLoadWithImage:image];
                              }];
    }
}
#pragma mark - image finish load
- (void)photoDidFinishLoadWithImage:(UIImage *)image {
    if (image) {
        self.scrollEnabled = YES;
        self.photo.image = image;
        [self.photoLoadingView removeFromSuperview];
        
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
            [self.photoViewDelegate photoViewImageFinishLoad:self];
        }
    } else {
        [self addSubview:self.photoLoadingView];
        [self.photoLoadingView showFailure];
    }
    [self adjustFrame];
}
#pragma mark - adjust frame
- (void)adjustFrame {
    if (self.imageView.image == nil) {
        return;
    }
    
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGFloat minScale = boundsWidth / imageWidth;
    if (minScale > 1) {
        minScale = 1.0;
    }
    CGFloat maxScale = 2.0;
//    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
//        maxScale = maxScale / [[UIScreen mainScreen] scale];
//    }
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight*boundsWidth/imageWidth);
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height)/2.0);
    } else {
        imageFrame.origin.y = 0;
    }
    
    if (self.photo.firstShow) {
        self.photo.firstShow = NO;
        self.imageView.frame = imageFrame;//[self.photo.srcImageView  convertRect:self.photo.srcImageView.bounds toView:nil];
        self.photo.srcImageView.image = self.photo.placeHolder;
        [self photoStartLoad];
//        [UIView animateWithDuration:0.3
//                         animations:^{
//                             self.imageView.frame = imageFrame;
//                         } completion:^(BOOL finished) {
//                             self.photo.srcImageView.image = self.photo.placeHolder;
//                             [self photoStartLoad];
//                         }];
    } else {
        self.imageView.frame = imageFrame;
    }
}
#pragma mark - UIScrollView
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
#pragma mark - gesture method
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    self.doubleTap = NO;
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.2];
}
- (void)hide {
    if (self.doubleTap) {
        return;
    }
    [self.photoLoadingView removeFromSuperview];
//    self.contentOffset = CGPointZero;
//    
//    self.photo.srcImageView.image = nil;
//    
//    CGFloat duration = 0.15;
//    if (self.photo.srcImageView.clipsToBounds) {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
//    }
//    
//    [UIView animateWithDuration:duration+0.1 animations:^{
//        self.imageView.frame = [self.photo.srcImageView convertRect:self.photo.srcImageView.bounds toView:nil];
//        if (self.imageView.image.images) {
//            self.imageView.image = self.imageView.image.images[0];
//        }
//        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
//            [self.photoViewDelegate photoViewSingleTap:self];
//        }
//    } completion:^(BOOL finished) {
//        self.photo.srcImageView.image = self.photo.placeHolder;
//        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
//            [self.photoViewDelegate photoViewDidEndZoom:self];
//        }
//    }];
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
            [self.photoViewDelegate photoViewSingleTap:self];
        }
}
- (void)reset {
    self.imageView.image = self.photo.capture;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    self.doubleTap = YES;
    
    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}
- (void)dealloc {
    [self.imageView setImageWithURL:[NSURL URLWithString:@"file://www"]];
}
@end
