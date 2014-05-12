//
//  SZPickerView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickerViewBlock) (NSInteger index, NSInteger component);

@interface SZPickerView : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

- (id  )initWithOptions:(NSArray *)options;
- (id  )initWithOptions:(NSArray *)options numberOfComponents:(NSInteger)numberOfComponents;
- (void)showFromBottom;

@end
