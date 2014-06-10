//
//  SZURLCache.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-6-10.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZURLCache.h"
#import "NSString+MD5.h"

@implementation SZURLCache
#define CachePath ([NSString stringWithFormat:@"%@/Documents/cache.db", NSHomeDirectory()])
+ (void)cacheData:(NSData *)data forRequest:(NSURLRequest *)request {
    NSString *key = [[request.URL absoluteString] md5];
    NSMutableDictionary *cachedDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:CachePath];
    if (cachedDictionary) {
        [cachedDictionary setObject:data forKey:key];
        if ([cachedDictionary writeToFile:CachePath atomically:YES]) {
            NSLog(@"cache succeed");
        } else {
            NSLog(@"cache failed");
        }
    } else {
        [@{key: data} writeToFile:CachePath atomically:YES];
    }
}

+ (NSData *)getCachedDataForRequest:(NSURLRequest *)request {
    NSData *data = nil;
    if ([[NSURLCache sharedURLCache] cachedResponseForRequest:request]) {
        id responseObject = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        NSError *error = nil;
        data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
        if (!error) {
            return data;
        } else {
            return nil;
        }
    } else {
        NSString *key = [[request.URL absoluteString] md5];
        NSDictionary *cachedDictionary = [NSDictionary dictionaryWithContentsOfFile:CachePath];
        data = [cachedDictionary objectForKey:key];
        if (data) {
            return data;
        } else {
            return nil;
        }
    }
    return nil;
}
@end
