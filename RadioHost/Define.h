//
//  Define.h
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#ifndef RadioHost_Define_h
#define RadioHost_Define_h


//宏
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define wid [UIScreen mainScreen].bounds.size.width
#define heigh [UIScreen mainScreen].bounds.size.height

#define kUrl @":8080/uniaccount/queryMainInfo?uid=10&type=2"
#define kUrl2 @"http://123.57.206.120:8080/uniaccount/queryMainInfo?uid=10&type=2"
#endif
