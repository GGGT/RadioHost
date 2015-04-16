//
//  MyTabbarController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "MyTabbarController.h"

#import "RootViewController.h"
#import "DeviceManager.h"

@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createViewController];
    [self createTabbar];
    
    
    
    
    
    
}


-(void)createViewController{
    
    NSArray *array =@[@"HomeViewController",@"BBSController",@"FansController",@"MineViewController"];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSInteger i=0; i<array.count; i++) {
        Class class = NSClassFromString(array[i]);
        RootViewController *root =[[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
        [controllers addObject:nav];
        
           }
    
    
     self.viewControllers = controllers;

    
    
}
-(void)createTabbar{
    
    NSArray *arr1 =@[@"ic_home_n@2x.png",@"ic_download_n@2x.png",@"ic_history_n@2x.png",@"ic_setup_n@2x.png"];
    NSArray *arr2 = @[@"ic_home_p@2x.png",@"ic_download_p@2x.png",@"ic_history_p@2x.png",@"ic_setup_p@2x.png"];
    NSArray *arr3 =@[@"Home",@"BBS",@"Fans",@"Mine"];
    //    CGFloat btnHeight = self.frame.size.height;
//    CGFloat btnWidth = self.frame.size.width/imageArray.count;
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager currentScreenSize].width, 49)];
    view.backgroundColor =[UIColor colorWithWhite:200/255.0 alpha:0.5];
    
    for (NSInteger i=0; i<4; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*[DeviceManager currentScreenSize].width/arr1.count, 0, [DeviceManager currentScreenSize].width/arr1.count, 49)];
        btn.tag = 200+i;
        
        [btn setImage:[UIImage imageNamed:arr1[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arr2[i]] forState:UIControlStateSelected];
        [btn addTarget:self  action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
           btn.selected =YES;
        }
        
//        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(i*[DeviceManager currentScreenSize].width/arr1.count, 30, [DeviceManager currentScreenSize].width/arr1.count , 19)];
//        label.text =arr3[i];
//        
//        
        [view addSubview:btn];
      //  [view addSubview:label];
        
      
    }
    [self.tabBar addSubview:view];

    
    
    
}
-(void)btnclick:(UIButton *)btn{
    
    for (NSInteger i=0; i<4; i++) {
        UIButton *button =(UIButton *)[self.view viewWithTag:200+i];
        button.selected = NO;
    }
    btn.selected = YES;
    self.selectedIndex = btn.tag - 200;
    
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
