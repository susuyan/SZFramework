//
//  UIDevice+DeviceType.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-11.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "UIDevice+DeviceType.h"
#import <sys/sysctl.h>

@implementation UIDevice (DeviceType)

- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *) platform
{
    return [self getSysInfoByName:"hw.machine"];
}

- (NSUInteger) platformType
{
    NSString *platform = [self platform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDeviceiPhone1G;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDeviceiPhone3G;
    if ([platform hasPrefix:@"iPhone2"])            return UIDeviceiPhone3GS;
    if ([platform hasPrefix:@"iPhone3"])            return UIDeviceiPhone4;
    if ([platform hasPrefix:@"iPhone4"])            return UIDeviceiPhone4S;
    if ([platform hasPrefix:@"iPhone5"])            return UIDeviceiPhone5;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDeviceiPod1G;
    if ([platform hasPrefix:@"iPod2"])              return UIDeviceiPod2G;
    if ([platform hasPrefix:@"iPod3"])              return UIDeviceiPod3G;
    if ([platform hasPrefix:@"iPod4"])              return UIDeviceiPod4G;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDeviceiPad1G;
    if ([platform hasPrefix:@"iPad2"])              return UIDeviceiPad2G;
    if ([platform hasPrefix:@"iPad3"])              return UIDeviceiPad3G;
    if ([platform hasPrefix:@"iPad4"])              return UIDeviceiPad4G;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}


- (NSString *) platformString
{
    switch ([self platformType])
    {
        case UIDeviceiPhone1G: return IPHONE_1G_NAMESTRING;
        case UIDeviceiPhone3G: return IPHONE_3G_NAMESTRING;
        case UIDeviceiPhone3GS: return IPHONE_3GS_NAMESTRING;
        case UIDeviceiPhone4: return IPHONE_4_NAMESTRING;
        case UIDeviceiPhone4S: return IPHONE_4S_NAMESTRING;
        case UIDeviceiPhone5: return IPHONE_5_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDeviceiPod1G: return IPOD_1G_NAMESTRING;
        case UIDeviceiPod2G: return IPOD_2G_NAMESTRING;
        case UIDeviceiPod3G: return IPOD_3G_NAMESTRING;
        case UIDeviceiPod4G: return IPOD_4G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDeviceiPad1G : return IPAD_1G_NAMESTRING;
        case UIDeviceiPad2G : return IPAD_2G_NAMESTRING;
        case UIDeviceiPad3G : return IPAD_3G_NAMESTRING;
        case UIDeviceiPad4G : return IPAD_4G_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

- (UIDeviceFamily) deviceFamily
{
    NSString *platform = [self platform];
    if ([platform hasPrefix:@"iPhone"]) return UIDeviceFamilyiPhone;
    if ([platform hasPrefix:@"iPod"]) return UIDeviceFamilyiPod;
    if ([platform hasPrefix:@"iPad"]) return UIDeviceFamilyiPad;
    if ([platform hasPrefix:@"AppleTV"]) return UIDeviceFamilyAppleTV;
    
    return UIDeviceFamilyUnknown;
}

@end
