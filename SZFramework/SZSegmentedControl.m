//
//  SZSegmentedControl.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZSegmentedControl.h"
#import "define.h"
#import "UIView+Helper.h"

@interface SZSegmentedControl ()
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIColor *tintColor;
#define SZSegmentedControlSelectedIndecatorWidthAdjustment 2
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
        
#define SZSegmentedControlPadding 14
        CGFloat contentWidth = 0.0;
        NSMutableArray *segmentWidthArray = [NSMutableArray array];
        for (int i = 0; i < itemCount; i++) {
            NSString *segmentTitle = [items objectAtIndex:i];
            CGRect rect = [segmentTitle boundingRectWithSize:CGSizeMake(10000, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
            contentWidth += rect.size.width + SZSegmentedControlPadding * 2;
            [segmentWidthArray addObject:@(rect.size.width + SZSegmentedControlPadding * 2)];
        }
        
        CGFloat segmentWidthAdjustment = 0.0;
        if (contentWidth > self.width) {
            self.contentSize = CGSizeMake(contentWidth, self.height);
        } else {
            self.contentSize = self.frame.size;
            segmentWidthAdjustment = (self.width - contentWidth) / itemCount;
        }
        
        self.showsVerticalScrollIndicator = self.showsHorizontalScrollIndicator = NO;
        
        self.buttonArray = [NSMutableArray array];
        
        CGFloat xOffset = 0.0;
        for (int i = 0; i < itemCount; i++) {
            CGRect frame = CGRectMake(xOffset, 0, [segmentWidthArray[i] doubleValue] + segmentWidthAdjustment, self.height);
            UIButton *button = [self getButtonWithTitle:self.items[i] frame:frame index:i];
            [self.buttonArray addObject:button];
            [self addSubview:button];
            xOffset += frame.size.width;
        }
        
        self.selectedIndex = 0;
        [[self.buttonArray firstObject] setSelected:YES];

        CGRect frame = [[[self.buttonArray firstObject] titleLabel] frame];
        frame.origin.y = kSZSegmentedControlHeight - 4;
        frame.size.height = 3;
        frame.size.width += SZSegmentedControlSelectedIndecatorWidthAdjustment;
        self.selectedIndicator = [[UIView alloc] initWithFrame:frame];
        self.selectedIndicator.backgroundColor = self.tintColor;
        [self addSubview:self.selectedIndicator];
    }
    return self;
}

- (UIButton *)getButtonWithTitle:(NSString *)title frame:(CGRect)frame index:(NSUInteger)index {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:RGB_HEX(0x1f1f1f) forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(onSegmentedButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    [button.titleLabel sizeToFit];
    button.titleLabel.center = CGPointMake(button.width/2, button.height/2);
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
    
    UIButton *needShowButton = button;
    if (button.x < (self.contentOffset.x+button.width)) {
        needShowButton = [self.buttonArray objectAtIndex:MAX(0, _selectedIndex-2)];
    } else if (button.x >= (self.contentOffset.x+kSZSegmentedControlWidth-button.width)) {
        needShowButton = [self.buttonArray objectAtIndex:MIN(self.buttonArray.count-1, _selectedIndex+2)];
    }
    
    [self scrollRectToVisible:needShowButton.frame animated:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        UIButton *button = [self.buttonArray objectAtIndex:buttonIndex];
        UILabel *label = [[self.buttonArray objectAtIndex:buttonIndex] titleLabel];
        CGRect frame = CGRectMake(button.frame.origin.x + label.frame.origin.x,
                                  kSZSegmentedControlHeight - 4,
                                  label.frame.size.width + SZSegmentedControlSelectedIndecatorWidthAdjustment,
                                  3);
        
        self.selectedIndicator.frame = frame;
    } completion:^(BOOL finished) {
        if ([self.segmentedControlDelegate respondsToSelector:@selector(onSelectedIndex:segmentedControl:)]) {
            [self.segmentedControlDelegate onSelectedIndex:buttonIndex segmentedControl:self];
        }
    }];
}

- (void)setSelectedIndex:(NSInteger)index {
    [self onSegmentedButtonPressed:self.buttonArray[index]];
}

@end
