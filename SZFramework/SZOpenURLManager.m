//
//  SZOpenURLManager.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZOpenURLManager.h"

@interface SZOpenURLManager ()
@property (nonatomic, strong) NSMutableDictionary *handlers;
@end

@implementation SZOpenURLManager
- (id)init {
    self = [super init];
    if (self) {
        self.handlers = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (SZOpenURLManager *)defaultManager {
    static SZOpenURLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SZOpenURLManager alloc] init];
    });
    return manager;
}

- (void)addHandler:(OpenURLHandler)handler withKey:(NSString *)key {
    self.handlers[key] = handler;
}

//TODO: 遍历所有handler, 修改用key搜索
- (BOOL)openURL:(NSURL *)url {
    for (NSString *key in self.handlers.allKeys) {
        OpenURLHandler handler = self.handlers[key];
        if (handler(url)) {
            return YES;
        }
    }
    return NO;
}
@end
