//
//  NSData+MD5.m
//  Pods
//
//  Created by Sid_Zheng on 14/12/4.
//
//

#import "NSData+MD5.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSData (MD5)
- (NSString *)md5 {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
}
@end
