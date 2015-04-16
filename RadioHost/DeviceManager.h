//
//  DeviceManager.h
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceManager : NSObject

//获取屏幕大小
+(CGSize)currentScreenSize;
//操作系统
+(CGFloat)currentVersion;


@end
