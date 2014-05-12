//
//  UIView+Helper.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

- (CGFloat)right {
    return self.width + self.x;
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (UILabel *)labelViewWithTag:(NSInteger)tag {
    return (UILabel *)[self viewWithTag: tag];
}

- (UIImageView *)imageViewWithTag:(NSInteger)tag {
    return (UIImageView *)[self viewWithTag: tag];
}

- (UITextField *)textFieldViewWithTag:(NSInteger)tag {
    return (UITextField *)[self viewWithTag: tag];
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
    return (UIButton *)[self viewWithTag: tag];
}

- (UIActivityIndicatorView *)activityIndicatorViewWithTag:(NSInteger)tag {
    return (UIActivityIndicatorView *)[self viewWithTag: tag];
}

@end
