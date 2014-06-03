//
//  SZSegmentedControl.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSZSegmentedControlWidth 320
#define kSZSegmentedControlHeight 34

@class SZSegmentedControl;

@protocol SZSegmentedControlDelegate <NSObject>
- (void)onSelectedIndex:(NSInteger)index segmentedControl:(SZSegmentedControl *)segmentedControl;
@end

@interface SZSegmentedControl : UIView
@property (assign, nonatomic) id<SZSegmentedControlDelegate> delegate;
@property (assign, nonatomic) NSInteger selectedIndex;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items tintColor:(UIColor *)color;
- (void)setSelectedIndex:(NSInteger)index;
@end
