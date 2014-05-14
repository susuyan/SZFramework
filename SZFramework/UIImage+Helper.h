//
//  UIImage+Helper.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)
- (UIImage*)imageWithImage:(UIImage*)image size:(CGSize)size;
- (UIImage *)scaleImage:(UIImage *)image proportion:(float)scale;
- (UIImage *)fixOrientation;
@end
