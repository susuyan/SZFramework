//
//  SZClearPopWindow.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface SZClearPopWindow : UIWindow
@property (copy, nonatomic) VoidBlock hideHandler;
+ (SZClearPopWindow *)sharedWindow;
- (void)show;
- (void)hide;
@end
