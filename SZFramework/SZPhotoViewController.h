//
//  SZPhotoViewController.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-29.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZPhotoViewController;

@protocol SZPhotoViewControllerDelegate <NSObject>
@optional
- (void)SZPhotoViewController:(SZPhotoViewController *)photoViewController didChangeToPageAtIndex:(NSUInteger)index;
@end

@interface SZPhotoViewController : UIViewController <UIScrollViewDelegate>
@property (assign, nonatomic) id<SZPhotoViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *photos;
@property (assign, nonatomic) NSUInteger currentPhotoIndex;
@end
