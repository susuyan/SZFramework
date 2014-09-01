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

        } else {

        }
    } else {
        [@{key: data} writeToFile:CachePath atomically:YES];
    }
}

+ (NSData *)getCachedDataForRequest:(NSURLRequest *)request {
    NSData *data = nil;
    NSString *key = [[request.URL absoluteString] md5];
    NSDictionary *cachedDictionary = [NSDictionary dictionaryWithContentsOfFile:CachePath];
    data = [cachedDictionary objectForKey:key];
    if (data) {
        return data;
    }
    return nil;
}

#define CacheDateUserInfoKey @"CacheDateUserInfoKey"
+ (void)cacheDate:(NSDate *)date forRequest:(NSURLRequest *)request {
    NSString *key = [[request.URL absoluteString] md5];
    NSMutableDictionary *cachedDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:CacheDateUserInfoKey];
    if (cachedDictionary) {
        [cachedDictionary setObject:date forKey:key];
        [[NSUserDefaults standardUserDefaults] setObject:cachedDictionary forKey:CacheDateUserInfoKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSMutableDictionary dictionaryWithObject:date forKey:key] forKey:CacheDateUserInfoKey];
    }
}
+ (NSDate *)getCachedDateForRequest:(NSURLRequest *)request {
    NSString *key = [[request.URL absoluteString] md5];
    NSDictionary *cachedDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:CacheDateUserInfoKey];
    if (cachedDictionary) {
        return [cachedDictionary objectForKey:key];
    }
    return nil;
}
@end
