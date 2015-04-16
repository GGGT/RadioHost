//
//  BBSController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "BBSController.h"
#import "DeviceManager.h"

@interface BBSController ()

@end

@implementation BBSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    UIScrollView *scr2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, [DeviceManager currentScreenSize].width, 196)];
    scr2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:scr2];
    
    scr2.contentSize = CGSizeMake(800, 0);
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
