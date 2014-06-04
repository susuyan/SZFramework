//
//  SZBannerView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SZBannerViewDelegate <NSObject>
- (void)presseImageAtIndex:(NSInteger)index;
@end

@interface SZBannerView : UIView
@property (assign, nonatomic) id<SZBannerViewDelegate> delegate;
@property (assign, nonatomic) CGFloat autoScrollTimeInterval;
- (void)bindImageNameArray:(NSArray *)imageNameArray autoSCrollEnable:(BOOL)enable titles:(NSArray *)titles;
@end
