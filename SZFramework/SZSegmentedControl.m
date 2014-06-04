//
//  SZSegmentedControl.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZSegmentedControl.h"

@interface SZSegmentedControl ()
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIView *selectedIndicator;
@end

@implementation SZSegmentedControl

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items tintColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.items = items;
        self.tintColor = color;
        
        NSUInteger itemCount = items.count;
        CGFloat itemWidth = kSZSegmentedControlWidth / itemCount;
        
        self.buttonArray = [NSMutableArray array];
        for (int i = 0; i < itemCount; i++) {
            CGRect frame = CGRectMake(itemWidth * i, 0, itemWidth, kSZSegmentedControlHeight);
            UIButton *button = [self getButtonWithTitle:self.items[i] frame:frame index:i];
            [self.buttonArray addObject:button];
            [self addSubview:button];
        }
        
        self.selectedIndex = 0;
        [[self.buttonArray firstObject] setSelected:YES];
        self.selectedIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, kSZSegmentedControlHeight - 4, itemWidth, 4)];
        self.selectedIndicator.backgroundColor = self.tintColor;
        [self addSubview:self.selectedIndicator];
    }
    return self;
}

- (UIButton *)getButtonWithTitle:(NSString *)title frame:(CGRect)frame index:(NSUInteger)index {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    button.frame = frame;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitleColor:self.tintColor forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(onSegmentedButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}

- (void)onSegmentedButtonPressed:(UIButton *)button {
    NSInteger buttonIndex = [self.buttonArray indexOfObject:button];
    if (buttonIndex == self.selectedIndex) {
        return;
    }
    
    [[self.buttonArray objectAtIndex:self.selectedIndex] setSelected:NO];
    _selectedIndex = buttonIndex;
    [button setSelected:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.selectedIndicator.frame;
        frame.origin.x = button.frame.origin.x;
        self.selectedIndicator.frame = frame;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:segmentedControl:)]) {
            [self.delegate onSelectedIndex:buttonIndex segmentedControl:self];
        }
    }];
}

- (void)setSelectedIndex:(NSInteger)index {
    [self onSegmentedButtonPressed:self.buttonArray[index]];
}

@end
