//
//  define.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#ifndef SZFramework_define_h
#define SZFramework_define_h

// device
#define ScreenSize ([UIScreen mainScreen].bounds.size)
#define is_4inch (ScreenSize.height > 480)
#define is_iOS7_and_upper ()

// color
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB_HEX(hexColor) [UIColor colorWithRed:(((hexColor >> 16) & 0xFF))/255.0f         \
                                          green:(((hexColor >> 8) & 0xFF))/255.0f          \
                                           blue:((hexColor & 0xFF))/255.0f                 \
                                          alpha:1]
#define group_tableview_bg_color RGB_HEX(0xefeff4)
#define tableview_separator_color RGB_HEX(0xc8c8c8)

// shortcut
#define App                     [UIApplication sharedApplication]
#define AppWindow               [UIApplication sharedApplication].delegate.window
#define NotificationCenter      [NSNotificationCenter defaultCenter]
#define UserDefaults            [NSUserDefaults standardUserDefaults]

#define StoryBoard(_name_) [UIStoryboard storyboardWithName:_name_ bundle:nil]

#define WeakSelf __weak typeof(self) weakSelf = self;

#define AFHTTPRequestOperationManeger(__url_string__) [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:__url_string__]]

#endif
