//
//  DetailController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/17.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
}
-(void)createNav{
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:180/255.0 green:10/255.0 blue:10/255.0 alpha:1]];
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.text = @"小强来了";
    label.font = [UIFont systemFontOfSize:21];
    label.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = label;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = item;
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
