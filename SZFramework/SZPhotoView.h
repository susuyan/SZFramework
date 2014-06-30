//
//  SZPhotoView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZPhotoBrowser, SZPhoto, SZPhotoView;

@protocol SZPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(SZPhotoView *)photoView;
- (void)photoViewSingleTap:(SZPhotoView *)photoView;
- (void)photoViewDidEndZoom:(SZPhotoView *)photoView;
@end

@interface SZPhotoView : UIScrollView <UIScrollViewDelegate>
@property (strong, nonatomic) SZPhoto *photo;
@property (assign, nonatomic) id<SZPhotoViewDelegate> photoViewDelegate;
@end
