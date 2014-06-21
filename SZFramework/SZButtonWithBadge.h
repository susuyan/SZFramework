//
//  SZButtonWithBadge.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-18.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCustomBadge.h"

@class SZButtonWithBadge;

typedef void (^ButtonPressedHandler)(SZButtonWithBadge *button);

@interface SZButtonWithBadge : UIView

@property (copy  , nonatomic) ButtonPressedHandler buttonPressedHandler;

- (void)setButtonImage:(UIImage *)image;
- (void)setBadgeValue:(NSInteger)badgeValue;

@end
