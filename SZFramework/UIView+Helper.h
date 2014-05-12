//
//  UIView+Helper.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)

@property (nonatomic)CGFloat width;
@property (nonatomic)CGFloat height;
@property (nonatomic)CGFloat x;
@property (nonatomic)CGFloat y;
@property (nonatomic, readonly)CGFloat right;
@property (nonatomic, readonly)CGFloat bottom;

- (UILabel *)labelViewWithTag:(NSInteger)tag;
- (UIImageView *)imageViewWithTag:(NSInteger)tag;
- (UITextField *)textFieldViewWithTag:(NSInteger)tag;
- (UIButton *)buttonWithTag:(NSInteger)tag;
- (UIActivityIndicatorView *)activityIndicatorViewWithTag:(NSInteger)tag;

@end
