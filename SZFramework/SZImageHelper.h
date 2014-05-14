//
//  SZImageHelper.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-15.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZImageHelper : NSObject
// Create image
+ (UIImage *) imageFromView: (UIView *) theView;

// Base Image Fitting
+ (CGSize) fitSize: (CGSize)thisSize inSize: (CGSize) aSize;
+ (UIImage *) unrotateImage: (UIImage *) image;

+ (UIImage *) image: (UIImage *) image fitInSize: (CGSize) size; // retain proportions, fit in size
+ (UIImage *) image: (UIImage *) image fitInView: (UIView *) view;

+ (UIImage *) image: (UIImage *) image centerInSize: (CGSize) size; // center, no resize
+ (UIImage *) image: (UIImage *) image centerInView: (UIView *) view;

+ (UIImage *) image: (UIImage *) image fillSize: (CGSize) size; // fill all pixels
+ (UIImage *) image: (UIImage *) image fillView: (UIView *) view;

@end
