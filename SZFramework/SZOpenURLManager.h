//
//  SZOpenURLManager.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-13.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^OpenURLHandler)(NSURL *url);

@interface SZOpenURLManager : NSObject
+ (SZOpenURLManager *)defaultManager;
- (void)addHandler:(OpenURLHandler)handler withKey:(NSString *)key;
- (BOOL)openURL:(NSURL *)url;
@end
