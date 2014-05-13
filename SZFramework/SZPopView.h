//
//  SZPopView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZPopView : UIView
+ (SZPopView *)sharedView;
- (void)show;
- (void)hide;
@end
