//
//  UIImage+MD5.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIImage+MD5.h"
#import "NSData+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation UIImage (MD5)
- (NSString*)md5
{
    return [UIImagePNGRepresentation(self) md5];
}
@end
