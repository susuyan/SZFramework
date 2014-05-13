//
//  SZWindow.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#define BackgroundWindowLevel 2013
#define ForeheadWindowLevel 2014

#import <UIKit/UIKit.h>

@class SZWindow;

static SZWindow *szWindow;

@interface SZWindow : UIWindow
- (void)show;
- (void)hide;
@end
