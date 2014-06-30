//
//  SZPhotoBrowser.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPhotoBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "SZPhoto.h"
#import "SZPhotoView.h"
#import <SDWebimage/SDWebImageManager.h>
#import "UIView+Helper.h"
#define kPadding 10
#define kPhotoViewTagOffset 777
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface SZPhotoBrowser () <SZPhotoViewDelegate>
@property (strong, nonatomic) UIScrollView *photoScrollView;
@property (strong, nonatomic) NSMutableSet *visiblePhotoViews;
@property (strong, nonatomic) NSMutableSet *reusablePhotoViews;
@property (assign, nonatomic) BOOL statusBarHiddenInited;
@end

@implementation SZPhotoBrowser
#pragma mark - LifeCycle
- (void)loadView {
    self.statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    self.view = [[UIView alloc] init];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
}
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
}
- (void)setupScrollView {
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    self.photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.delegate = self;
    self.photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.backgroundColor = [UIColor clearColor];
    self.photoScrollView.contentSize = CGSizeMake(frame.size.width * self.photos.count, 0);
    [self.view addSubview:self.photoScrollView];
    self.photoScrollView.contentOffset = CGPointMake(self.currentPhotoIndex * frame.size.width, 0);
}
#pragma mark - setter
- (void)setPhotos:(NSArray *)photos {
    self.photos = photos;
    if (self.photos.count > 1) {
        self.visiblePhotoViews = [NSMutableSet set];
        self.reusablePhotoViews = [NSMutableSet set];
    }
    for (int i = 0; i < self.photos.count; i++) {
        SZPhoto *photo = self.photos[i];
        photo.index = i;
        photo.firstShow = (i == self.currentPhotoIndex);
    }
}
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex {
    _currentPhotoIndex = currentPhotoIndex;
    for (int i = 0; i < self.photos.count; i++) {
        SZPhoto *photo = self.photos[i];
        photo.firstShow = (i == currentPhotoIndex);
    }
    if ([self isViewLoaded]) {
        self.photoScrollView.contentOffset = CGPointMake(self.currentPhotoIndex*self.photoScrollView.width, 0);
        [self showPhotos];
    }
}
#pragma mark - SZPhotoViewDelegate
- (void)photoViewImageFinishLoad:(SZPhotoView *)photoView {
    
}
- (void)photoViewSingleTap:(SZPhotoView *)photoView {
    [UIApplication sharedApplication].statusBarHidden = self.statusBarHiddenInited;
    self.view.backgroundColor = [UIColor clearColor];}
- (void)photoViewDidEndZoom:(SZPhotoView *)photoView {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
#pragma mark - show photos
- (void)showPhotos {
    if (self.photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = self.photoScrollView.bounds;
    int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= self.photos.count) firstIndex = self.photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= self.photos.count) lastIndex = self.photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (SZPhotoView *photoView in self.visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:index];
		}
	}
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    SZPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[SZPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = self.photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    SZPhoto *photo = self.photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [self.visiblePhotoViews addObject:photoView];
    [self.photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(int)index
{
    if (index > 0) {
        SZPhoto *photo = self.photos[index - 1];
        [[SDWebImageManager sharedManager] downloadWithURL:photo.url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            
        }];
    }
    
    if (index < self.photos.count - 1) {
        SZPhoto *photo = self.photos[index + 1];
        [[SDWebImageManager sharedManager] downloadWithURL:photo.url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            
        }];
    }
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (SZPhotoView *photoView in self.visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
            return YES;
        }
    }
	return  NO;
}

#pragma mark 循环利用某个view
- (SZPhotoView *)dequeueReusablePhotoView
{
    SZPhotoView *photoView = [self.reusablePhotoViews anyObject];
	if (photoView) {
		[self.reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    self.currentPhotoIndex = self.photoScrollView.contentOffset.x / self.photoScrollView.frame.size.width;

}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateTollbarState];
}
@end
