//
//  SZPopWindow.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZPopWindow : UIWindow
+ (SZPopWindow *)sharedWindow;
- (void)show;
- (void)hide;
@end
