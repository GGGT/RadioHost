//
//  NetManager.h
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^DownloadFinishedBlock)(id responseObj);
typedef void(^DownloadFailedBlock)(NSString *errorMsg);

@interface NetManager : NSObject


+(void)requestWithString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;


@end
