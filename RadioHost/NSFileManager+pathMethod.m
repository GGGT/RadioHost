//
//  NSFileManager+pathMethod.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/16.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "NSFileManager+pathMethod.h"

@implementation NSFileManager (pathMethod)

+(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time{
      //获取指定路径下文件的属性列表
    NSDictionary *infoDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSLog(@"info:%@",infoDic);
      //拿到文件的修改时间
    NSDate *fileDate = [infoDic objectForKey:NSFileModificationDate];
  
    //系统当前时间
    NSDate *date = [NSDate date];
    NSLog(@"date:%@",date);
    //date与fileDate的时间差
  
    NSTimeInterval currentTime =[date timeIntervalSinceDate:fileDate];
    if (currentTime >time) {
          //超时
        return YES;
    }else{
          //没有超时
        return  NO;
    }

    
}

@end
