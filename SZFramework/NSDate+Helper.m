//
//  NSDate+Helper.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
#define TT_MINUTE 60
#define TT_DAY 86400
#define TT_2_DAY 86400
#define TT_5_DAYS 432000
#define TT_HOUR 3600
#define TT_WEEK 604800
//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSDate*)dateWithToday {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-d-M";
    
    NSString* formattedTime = [formatter stringFromDate:[NSDate date]];
    NSDate* date = [formatter dateFromString:formattedTime];
    //TT_RELEASE_SAFELY(formatter);
    
    return date;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDate*)dateAtMidnight {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-d-M";
    
    NSString* formattedTime = [formatter stringFromDate:self];
    NSDate* date = [formatter dateFromString:formattedTime];
    //TT_RELEASE_SAFELY(formatter);
    
    return date;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatTime {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = NSLocalizedString(@"h:mm a", @"Date format: 1:05 pm");
        //formatter.locale = NSCurrentLocale();
    }
    return [formatter stringFromDate:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDate {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = NSLocalizedString(@"EEEE, LLLL d, YYYY", @"Date format: Monday, July 27, 2009");
        //formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatShortTime {
    NSTimeInterval diff = abs([self timeIntervalSinceNow]);
    
    if (diff < TT_DAY) {
        return [self formatTime];
        
    } else if (diff < TT_5_DAYS) {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"EEEE", @"Date format: Monday");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
        
    } else {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"M/d/yy", @"Date format: 7/27/09");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDateTime {
    NSTimeInterval diff = abs([self timeIntervalSinceNow]);
    if (diff < TT_DAY) {
        return [self formatTime];
        
    } else if (diff < TT_5_DAYS) {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"EEE h:mm a", @"Date format: Mon 1:05 pm");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
        
    } else {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"MMM d h:mm a", @"Date format: Jul 27 1:05 pm");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
    }
}
- (NSString*)formatDateTimeWithNoWeek {
    NSTimeInterval diff = abs([self timeIntervalSinceNow]);
    if (diff < TT_DAY) {
        return [self formatTime];
        
    } else if (diff < TT_5_DAYS) {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"MMM d h:mm a", @"Date format: Jul 27 1:05 pm");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
        
    } else {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"MMM d h:mm a", @"Date format: Jul 27 1:05 pm");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatRelativeTime {
    NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
    if (elapsed <= 1) {
        return NSLocalizedString(@"just a moment ago", @"");
        
    } else if (elapsed < TT_MINUTE) {
        int seconds = (int)(elapsed);
        return [NSString stringWithFormat:NSLocalizedString(@"%d seconds ago", @""), seconds];
        
    } else if (elapsed < 2*TT_MINUTE) {
        return NSLocalizedString(@"about a minute ago", @"");
        
    } else if (elapsed < TT_HOUR) {
        int mins = (int)(elapsed/TT_MINUTE);
        return [NSString stringWithFormat:NSLocalizedString(@"%d minutes ago", @""), mins];
        
    } else if (elapsed < TT_HOUR*1.5) {
        return NSLocalizedString(@"about an hour ago", @"");
        
    } else if (elapsed < TT_DAY) {
        int hours = (int)((elapsed+TT_HOUR/2)/TT_HOUR);
        return [NSString stringWithFormat:NSLocalizedString(@"%d hours ago", @""), hours];
        
    } else if (elapsed < TT_2_DAY) {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"Yesterday h:mm", @"Date format: Yesterday 11:00");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
    } else {
        return [self formatDateTime];
    }
}

- (NSString*)formatRelativeTimeWithNoWeek {
    NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
    if (elapsed <= 1) {
        return NSLocalizedString(@"just a moment ago", @"");
        
    } else if (elapsed < TT_MINUTE) {
        int seconds = (int)(elapsed);
        return [NSString stringWithFormat:NSLocalizedString(@"%d seconds ago", @""), seconds];
        
    } else if (elapsed < 2*TT_MINUTE) {
        return NSLocalizedString(@"about a minute ago", @"");
        
    } else if (elapsed < TT_HOUR) {
        int mins = (int)(elapsed/TT_MINUTE);
        return [NSString stringWithFormat:NSLocalizedString(@"%d minutes ago", @""), mins];
        
    } else if (elapsed < TT_HOUR*1.5) {
        return NSLocalizedString(@"about an hour ago", @"");
        
    } else if (elapsed < TT_DAY) {
        int hours = (int)((elapsed+TT_HOUR/2)/TT_HOUR);
        return [NSString stringWithFormat:NSLocalizedString(@"%d hours ago", @""), hours];
        
    } else if (elapsed < TT_2_DAY) {
        static NSDateFormatter* formatter = nil;
        if (!formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = NSLocalizedString(@"Yesterday h:mm", @"Date format: Yesterday 11:00");
            //formatter.locale = TTCurrentLocale();
        }
        return [formatter stringFromDate:self];
    } else {
        return [self formatDateTimeWithNoWeek];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatShortRelativeTime {
    NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
    
    if (elapsed < TT_MINUTE) {
        return NSLocalizedString(@"<1m", @"Date format: less than one minute ago");
        
    } else if (elapsed < TT_HOUR) {
        int mins = (int)(elapsed / TT_MINUTE);
        return [NSString stringWithFormat:NSLocalizedString(@"%dm", @"Date format: 50m"), mins];
        
    } else if (elapsed < TT_DAY) {
        int hours = (int)((elapsed + TT_HOUR / 2) / TT_HOUR);
        return [NSString stringWithFormat:NSLocalizedString(@"%dh", @"Date format: 3h"), hours];
        
    } else if (elapsed < TT_WEEK) {
        int day = (int)((elapsed + TT_DAY / 2) / TT_DAY);
        return [NSString stringWithFormat:NSLocalizedString(@"%dd", @"Date format: 3d"), day];
        
    } else {
        return [self formatShortTime];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDay:(NSDateComponents*)today yesterday:(NSDateComponents*)yesterday {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = NSLocalizedString(@"MMMM d", @"Date format: July 27");
        //formatter.locale = TTCurrentLocale();
    }
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* day = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                   fromDate:self];
    
    if (day.day == today.day && day.month == today.month && day.year == today.year) {
        return NSLocalizedString(@"Today", @"");
    } else if (day.day == yesterday.day && day.month == yesterday.month
               && day.year == yesterday.year) {
        return NSLocalizedString(@"Yesterday", @"");
    } else {
        return [formatter stringFromDate:self];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatMonth {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = NSLocalizedString(@"MMMM", @"Date format: July");
        //formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatYear {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = NSLocalizedString(@"yyyy", @"Date format: 2009");
        //formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
}


- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    
    return components.year;
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    
    return components.month;
}

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    
    return components.day;
}

- (BOOL) isToday {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    if (components.year == components2.year && components2.month == components.month && components.day == components2.day) {
        return YES;
    }
    
    return NO;
}

- (BOOL) isThisYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    if (components.year == components2.year) {
        return YES;
    }
    
    return NO;
}

@end
