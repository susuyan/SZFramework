//
//  SZNotificationView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kSZNotificationViewHeight = 30.0f;
static CGFloat const kSZNotificationViewSymbolViewSidelength = 44.0f;
static NSTimeInterval const kSZNotificationViewDefaultShowDuration = 2.0;

typedef enum {
    SZNotificationViewStyleSuccess,
    SZNotificationViewStyleError,
} SZNotificationViewStyle;

typedef void(^SZVoidBlock)();

@interface SZNotificationView : UIView

#pragma mark + quick presentation

+ (void)showInViewController:(UIViewController*)viewController
                       style:(SZNotificationViewStyle)style
                     message:(NSString*)message;

+ (void)showInViewController:(UIViewController*)viewController
                   tintColor:(UIColor*)tintColor
                       image:(UIImage*)image
                     message:(NSString*)message
                    duration:(NSTimeInterval)duration;

+ (void)showInViewController:(UIViewController*)viewController
                   tintColor:(UIColor*)tintColor
                        font:(UIFont*)font
               textAlignment:(NSTextAlignment)textAlignment
                       image:(UIImage*)image
                     message:(NSString*)message
                    duration:(NSTimeInterval)duration;

#pragma mark + creators

+ (SZNotificationView*)notificationViewWithParentViewController:(UIViewController*)viewController
                                                      tintColor:(UIColor*)tintColor
                                                          image:(UIImage*)image
                                                        message:(NSString*)message;

#pragma mark - initialization

- (instancetype)initWithParentViewController:(UIViewController*)viewController;

#pragma mark - presentation

- (void)setVisible:(BOOL)showing animated:(BOOL)animated completion:(void (^)())completion;
- (void)dismissWithStyle:(SZNotificationViewStyle)style message:(NSString*)message duration:(NSTimeInterval)duration animated:(BOOL)animated;
@property (readonly, nonatomic, getter = isShowing) BOOL visible;

#pragma mark - visible properties

/**
 The image property should be used for setting the image displayed in imageView
 Only the alpha value will be used and then be tinted to a 'legible' color
 */
@property (nonatomic, strong) UIImage* image;

@property (nonatomic, strong) UIColor* tintColor;

@property (nonatomic, getter = isShowingActivity) BOOL showingActivity;

@property (nonatomic, copy) SZVoidBlock tapHandler;

@end