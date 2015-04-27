//
//  AppDelegate.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabbarController.h"
#import "DeviceManager.h"
@interface AppDelegate ()<UIScrollViewDelegate>
{
    BOOL isOut;
    UIPageControl *pageControl;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [[UINavigationBar appearance ] setBarTintColor:[UIColor colorWithRed:180/255.0 green:10/255.0 blue:10/255.0 alpha:1]];
//    
//    MyTabbarController *tab =[[MyTabbarController alloc] init];
//    self.window.rootViewController = tab;
//    
//    NSLog(@"width:%lf",wid);
//    
//  
//    
//    NSLog(@"name:%lf",CURRENT_SYS_VERSION);
//    NSLog(@"kurl:%@",kUrl);
    
    self.window.backgroundColor = [UIColor whiteColor];
    
   
    isOut = NO;
    //在沙河做一个文件，判断沙盒有没有这个文件
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isHasFile = [manager fileExistsAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"]];
    if (isHasFile) {
        [self gotoMain];  //为真 表示已有文件，曾经进去过主页
    }else{
        [self makeLaunchView];  //为假， 表示没有文件，没有进入过主页
    }
    
    
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
//
-(void)makeLaunchView{
    NSArray *arr =@[@"_0.jpg",@"_0000.jpg",@"_000.jpg"];
    //scrollView 将这些图片添加到上面，从而达到滚动这些图片
    UIScrollView *scr =[[UIScrollView alloc] initWithFrame:self.window.bounds];
    scr.contentSize = CGSizeMake(wid*arr.count, 0);
    scr.pagingEnabled =YES;
    scr.tag = 1000000000;
    scr.delegate =self;
    scr.showsHorizontalScrollIndicator = NO;
    [self.window addSubview:scr];
    
    for (NSInteger i=0; i<arr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*wid, 0, wid, self.window.frame.size.height)];
        imgView.image = [UIImage imageNamed:arr[i]];
        [scr addSubview:imgView];
        
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(i*wid+130, heigh-80, 100, 20)];
        //pageControl.backgroundColor =RGBCOLOR(100, 100, 100);
        pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.numberOfPages = 3;
        pageControl.currentPage =i;
   
        [scr addSubview:pageControl];
        

    }
    
}
#pragma mark - scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = (scrollView.contentOffset.x+wid)/wid;
    

    if (scrollView.contentOffset.x>2*wid+30) {
        isOut = YES;
    }
//    
//    NSInteger page = floor((scrollView.contentOffset.x)/wid)+1;
    
}
//停止华东
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断isOut为真   就要进入主界面了
    if (isOut) {
        [UIView animateWithDuration:1.5 animations:^{   scrollView.alpha=0;   //让scrollView渐变消失
        }completion:^(BOOL finished) {
                             [scrollView removeFromSuperview]; //将scrollView移除
                             [self gotoMain];  //进入主界面
                         }];
    }
}
//进主页
-(void)gotoMain{
    //如果第一次进入没有文件，我们就创建这个文件
    NSFileManager *manager = [NSFileManager defaultManager];
    //判断  我是否创建了文件，如果没创建  就创建这个文件 （这种情况就运行一次，也就是第一次启动程序的时候）
    if (![manager fileExistsAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"]]) {
        [manager createFileAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"] contents:nil attributes:nil];
        
        
      
    }
    [[UINavigationBar appearance ] setBarTintColor:[UIColor colorWithRed:180/255.0 green:10/255.0 blue:10/255.0 alpha:1]];
    
    MyTabbarController *tab =[[MyTabbarController alloc] init];
    [self.window setRootViewController:tab];
    
    NSLog(@"width:%lf",wid);
    
    
    
    NSLog(@"name:%lf",CURRENT_SYS_VERSION);
    NSLog(@"kurl:%@",kUrl);

   
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
