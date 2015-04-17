//
//  NetManager.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "NetManager.h"

#import "NSFileManager+pathMethod.h"
#import "AFNetworking.h"
#import "NSString+Hashing.h" //MD5

@implementation NetManager


+(void)requestWithString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock{
    
    NSString *path =[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",[urlString MD5Hash]];
    //如果指定路径下的文件存在，并且没有超时，则使用缓存的数据
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] && [NSFileManager isTimeOutWithPath:path time:60*60]== NO) {
        NSData *data =[NSData dataWithContentsOfFile:path];
          // block 传出data
        finishedBlock(data);
    }else{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.accepableContentTypes =[NSSet setWithObjects:@"text/html",nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSData *responseData = (NSData *)responseObject;
            
            [responseData writeToFile:path atomically:YES];
            finishedBlock(responseData);
        }else{
            NSLog(@"数据的格式不对哦");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error.localizedDescription);
    }];
    
    }
}



@end
