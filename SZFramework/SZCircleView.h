//
//  SZCircleView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-23.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCircleView : UIView
@property (assign, nonatomic) NSInteger percent;
- (void)bindLeftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage backgroundImage:(UIImage *)backgroundImage;
- (void)animationWithPercent:(NSInteger)percent;
@end
