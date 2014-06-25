//
//  UIColor+CustomColors.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-29.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (UIColor *)customGrayColor
{
    return [self colorWithRed:84 green:84 blue:84];
}

+ (UIColor *)customRedColor
{
    return [self colorWithRed:231 green:76 blue:60];
}

+ (UIColor *)customYellowColor
{
    return [self colorWithRed:241 green:196 blue:15];
}

+ (UIColor *)customGreenColor
{
    return [self colorWithRed:46 green:204 blue:113];
}

+ (UIColor *)customBlueColor
{
    return [self colorWithRed:52 green:152 blue:219];
}

+ (UIColor *)randomCustomColor {
    static NSInteger seed = -1;
    if (seed >= 0) {
        NSInteger newSeed = 0;
        do {
            newSeed = arc4random() % 5;
        } while (seed == newSeed);
        seed = newSeed;
    } else {
        seed = arc4random() % 5;
    }
    switch (seed) {
        case 0:
            return [self customRedColor];
            break;
        case 1:
            return [self customBlueColor];
            break;
        case 2:
            return [self customGrayColor];
            break;
        case 3:
            return [self customGreenColor];
            break;
        case 4:
            return [self customYellowColor];
            break;
        default:
            break;
    }
    return [UIColor blackColor];
}

#pragma mark - Private class methods

+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}

@end