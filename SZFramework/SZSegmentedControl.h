//
//  SZSegmentedControl.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSZSegmentedControlWidth 320
#define kSZSegmentedControlButtonWidth 64
#define kSZSegmentedControlHeight 36

@class SZSegmentedControl;

@protocol SZSegmentedControlDelegate <NSObject>
- (void)onSelectedIndex:(NSInteger)index segmentedControl:(SZSegmentedControl *)segmentedControl;
@end

@interface SZSegmentedControl : UIScrollView
@property (assign, nonatomic) id<SZSegmentedControlDelegate> delegate;
@property (assign, nonatomic) NSInteger selectedIndex;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items tintColor:(UIColor *)color;
- (void)setSelectedIndex:(NSInteger)index;
@end
