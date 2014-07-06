//
//  SZClearPopWindow.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZClearPopWindow : UIWindow
+ (SZClearPopWindow *)sharedWindow;
- (void)show;
- (void)hide;
@end
