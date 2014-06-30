//
//  SZPhoto.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-27.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZPhoto : NSObject
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *srcImageView;
@property (strong, nonatomic, readonly) UIImage *placeHolder;
@property (strong, nonatomic, readonly) UIImage *capture;
@property (assign, nonatomic) BOOL firstShow;
@property (assign, nonatomic) BOOL save;
@property (assign, nonatomic) int index;
@end
