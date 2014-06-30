//
//  SZPhotoLoadingView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMinProgress 0.0001

@interface SZPhotoLoadingView : UIView
@property (assign, nonatomic) CGFloat progress;
- (void)showLoading;
- (void)showFailure;
@end
