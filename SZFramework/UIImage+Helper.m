//
//  UIImage+Helper.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)
- (UIImage*)imageWithImage:(UIImage*)image size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    //        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (UIImage *)scaleImage:(UIImage *)image proportion:(float)scale {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/scale, image.size.height/scale));
    CGRect imageRect = CGRectMake(0.0, 0.0, image.size.width/scale, image.size.height/scale);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
