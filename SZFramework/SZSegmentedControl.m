//
//  SZSegmentedControl.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-22.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZSegmentedControl.h"

#define kSZSegmentedControlNormalColor [UIColor blackColor]
#define kSZSegmentedControlHighlightedColor [UIColor whiteColor]

@interface SZSegmentedButton : UIButton
@property (assign, nonatomic) NSInteger index;
@end

@implementation SZSegmentedButton
//- (void)setHighlighted:(BOOL)highlighted {
//    [super setHighlighted:highlighted];
//    
//    self.backgroundColor = highlighted ? kSZSegmentedControlHighlightedColor: kSZSegmentedControlNormalColor;
//}
//
//- (void)setSelected:(BOOL)selected {
//    [super setSelected:selected];
//    
//    self.backgroundColor = selected ? kSZSegmentedControlHighlightedColor: kSZSegmentedControlNormalColor;
//}
@end

@interface SZSegmentedControl ()
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@end

@implementation SZSegmentedControl

- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.selectedIndex = 0;
        self.items = items;
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.backgroundImageView];
        
        NSUInteger itemCount = items.count;
        CGFloat itemWidth = kSZSegmentedControlWidth / itemCount;
        
        self.buttons = [NSMutableArray array];
        for (int i = 0; i < itemCount; i++) {
            CGRect frame = CGRectMake(itemWidth * i, 0, itemWidth, kSZSegmentedControlHeight);
            SZSegmentedButton *button = [self getButtonWithTitle:self.items[i] frame:frame index:i];
            [self.buttons addObject:button];
            [self addSubview:button];
        }
        [self.buttons[self.selectedIndex] setSelected:YES];
    }
    return self;
}

- (SZSegmentedButton *)getButtonWithTitle:(NSString *)title frame:(CGRect)frame index:(NSUInteger)index {
    SZSegmentedButton *button = [SZSegmentedButton buttonWithType:(UIButtonTypeSystem)];
    
    [button setTitle:title forState:(UIControlStateNormal)];
    
    button.frame = frame;
    
    button.index = index;
    
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    
    [button addTarget:self action:@selector(onSegmentedButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

- (void)bindBackgroundImage:(UIImage *)image {
    self.backgroundImageView.image = image;
}

- (void)onSegmentedButtonPressed:(SZSegmentedButton *)button {
    
    NSInteger selectedIndex = button.index;
    
    SZSegmentedButton *previousButton = self.buttons[self.selectedIndex];
    SZSegmentedButton *currentButton = self.buttons[selectedIndex];
    
    self.selectedIndex = selectedIndex;
    previousButton.selected = NO;
    currentButton.selected = YES;
    if ([self.delegate respondsToSelector:@selector(onSelectedIndex:)]) {
        [self.delegate onSelectedIndex:selectedIndex];
    }
}

- (void)triggerSegmentedControlEnabled:(BOOL)enabled {
    for (SZSegmentedButton *button in self.buttons) {
        button.userInteractionEnabled = enabled;
    }
}

- (void)bindSelectedIndex:(NSInteger)index {
    SZSegmentedButton *button = self.buttons[index];
    [self onSegmentedButtonPressed:button];
}

@end
