//
//  SZButtonWithBadge.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-18.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZButtonWithBadge.h"
#import "define.h"
#import "SZCommon.h"

@interface SZButtonWithBadge ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) SZCustomBadge *badge;
@end

@implementation SZButtonWithBadge

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.button.showsTouchWhenHighlighted = YES;
        [self.button addTarget:self action:@selector(onButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
        self.button.frame = frame;
        self.button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [self addSubview:self.button];
        
        self.badge = [SZCustomBadge customBadgeWithString:@"0"];
        self.badge.frame = CGRectMake(frame.size.width - 20, 2, 18, 18);
        if (is_iOS7) {
            self.badge.badgeFrame = NO;
            self.badge.badgeShining = NO;
        }
        [self.badge autoBadgeSizeWithString:@"0"];
        [self addSubview:self.badge];
    }
    return self;
}

- (void)setButtonImage:(UIImage *)image {
    [self.button setImage:image forState:(UIControlStateNormal)];
    [self.button setImage:image forState:(UIControlStateHighlighted)];
}

- (void)setBadgeValue:(NSInteger)badgeValue {
    if (badgeValue > 0) {
        self.badge.badgeText = [NSString stringWithFormat:@"%d", badgeValue];
        [self.badge autoBadgeSizeWithString:self.badge.badgeText];
        [self.badge show];
    } else {
        [self.badge hide];
    }
}

- (void)onButtonPressed:(UIButton *)button {
    if (self.buttonPressedHandler) {
        self.buttonPressedHandler(self);
    } else {
        [SZCommon showAlertMessage:@"have not bind handler"];
    }
}

@end
