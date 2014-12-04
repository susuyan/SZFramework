//
//  NSString+MD5.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)
- (NSString *)md5 {
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_LONG strLen = (CC_LONG)[self lengthOfBytesUsingEncoding:(NSUTF8StringEncoding)];
    CC_MD5(concat_str, strLen, result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash;
}
- (NSString *)urlEncoding {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    return encodedString;
}
- (NSInteger)chineseTextLength {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return (strlength + 1) / 2;
}
@end
