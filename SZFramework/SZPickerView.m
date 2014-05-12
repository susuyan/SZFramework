//
//  SZPickerView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZPickerView.h"

#define PickerViewFrame CGRectMake(0, 0, 320, 162)

@interface SZPickerView ()

@property (assign, nonatomic) NSInteger numberOfComponents;
@property (strong, nonatomic) NSArray *options;
@property (copy  , nonatomic) PickerViewBlock block;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIToolbar *toolbar;

@end

#pragma mark -
@implementation SZPickerView

#pragma mark - init method
- (id)initWithOptions:(NSArray *)options {
    self = [super initWithFrame:PickerViewFrame];
    if (self) {
        self.numberOfComponents = 1;
        self.options = options;
    }
    return self;
}

- (id)initWithOptions:(NSArray *)options numberOfComponents:(NSInteger)numberOfComponents {
    self = [super initWithFrame:PickerViewFrame];
    if (self) {
        self.numberOfComponents = numberOfComponents;
        self.options = options;
    }
    return self;
}

#pragma mark - setup UI
- (void)showFromBottom {
    self.showsSelectionIndicator = YES;
    
    {
        self.backgroundView = [[UIView alloc] initWithFrame:AppWindow.bounds];
        [AppWindow addSubview:self.backgroundView];
    }
    
    {
        //self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.backgroundView.bott, <#CGFloat width#>, <#CGFloat height#>)];
    }
}

- (void)hide {
    
}

@end
