//
//  NSDate+Helper.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

+ (NSDate*)dateWithToday ;

- (NSDate*)dateAtMidnight ;

- (NSString*)formatTime ;

- (NSString*)formatDate ;

- (NSString*)formatShortTime;

- (NSString*)formatDateTime ;
- (NSString*)formatDateTimeWithNoWeek;

- (NSString*)formatRelativeTime ;
- (NSString*)formatRelativeTimeWithNoWeek;

- (NSString*)formatShortRelativeTime ;

- (NSString*)formatDay:(NSDateComponents*)today yesterday:(NSDateComponents*)yesterday ;

- (NSString*)formatMonth;

- (NSString*)formatYear;

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

- (BOOL) isToday;

- (BOOL) isThisYear;

@end
