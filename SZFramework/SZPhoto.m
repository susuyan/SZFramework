//
//  SZPhoto.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPhoto.h"
#import <QuartzCore/QuartzCore.h>

@implementation SZPhoto
- (UIImage *)capture:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}
- (void)setSrcImageView:(UIImageView *)srcImageView {
    _srcImageView = srcImageView;
    _placeHolder = srcImageView.image;
    if (srcImageView.clipsToBounds) {
        _capture = [self capture:srcImageView];
    }
}
@end
