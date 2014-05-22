//
//  SZSegmentedControl.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSZSegmentedControlWidth 320
#define kSZSegmentedControlHeight 40

@protocol SZSegmentedControlDelegate <NSObject>
- (void)onSelectedIndex:(NSInteger)index;
@end

@interface SZSegmentedControl : UIView
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) id<SZSegmentedControlDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)items;
- (void)bindBackgroundImage:(UIImage *)image;
- (void)bindSelectedIndex:(NSInteger)index;
- (void)triggerSegmentedControlEnabled:(BOOL)enabled;
@end
