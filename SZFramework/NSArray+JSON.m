//
//  NSArray+JSON.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "NSArray+JSON.h"
#import "SZLog.h"

@implementation NSArray (JSON)
- (NSString *)jsonStringWithPrettyPrint:(BOOL)isPrettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)(isPrettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"NSArray+JSON error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)];
    }
}
@end
