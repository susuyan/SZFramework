//
//  SZURLCache.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-10.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZURLCache : NSObject
+ (void)cacheDate:(NSDate *)date forRequest:(NSURLRequest *)request;
+ (NSDate *)getCachedDateForRequest:(NSURLRequest *)request;
@end
