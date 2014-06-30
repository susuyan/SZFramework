//
//  SZPhotoBrowser.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZPhotoBrowser;

@protocol SZPhotoBrowserDelegate <NSObject>
@optional
- (void)photoBrowser:(SZPhotoBrowser *)photoBrowser didChangeToPageAtIndex:(NSUInteger)index;
@end

@interface SZPhotoBrowser : UIViewController <UIScrollViewDelegate>
@property (assign, nonatomic) id<SZPhotoBrowserDelegate> delegate;
@property (strong, nonatomic) NSArray *photos;
@property (assign, nonatomic) NSUInteger currentPhotoIndex;
- (void)show;
@end


