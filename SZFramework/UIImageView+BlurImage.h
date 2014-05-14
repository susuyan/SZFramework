//
//  UIImageView+BlurImage.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBBlurredImageCompletionBlock)(void);

extern CGFloat const kLBBlurredImageDefaultBlurRadius;

@interface UIImageView (LBBlurredImage)

/**
 Set the blurred version of the provided image to the UIImageView
 
 @param UIImage the image to blur and set as UIImageView's image
 @param CGFLoat the radius of the blur used by the Gaussian filter
 @param LBBlurredImageCompletionBlock a completion block called after the image
 was blurred and set to the UIImageView (the block is dispatched on main thread)
 */
- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock)completion;

/**
 Set the blurred version of the provided image to the UIImageView
 with the default blur radius
 
 @param UIImage the image to blur and set as UIImageView's image
 @param LBBlurredImageCompletionBlock a completion block called after the image
 was blurred and set to the UIImageView (the block is dispatched on main thread)
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion;
@end
