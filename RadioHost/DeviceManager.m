//
//  DeviceManager.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager


+(CGSize)currentScreenSize{
    return [UIScreen mainScreen].bounds.size;
}

+(CGFloat)currentVersion{
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    return [version floatValue];
    
}
@end