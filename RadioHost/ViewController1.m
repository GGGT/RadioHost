//
//  ViewController1.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/20.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "ViewController1.h"
//#import "ViewController22.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor =[UIColor colorWithWhite:255/255.0 alpha:1];
    [self addTiTle:@"小强来了"];
    [self addimage:[UIImage imageNamed:@"222.png"] selector:@selector(backClick) location:YES];
}
-(void)backClick{
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

- (IBAction)HudongClick:(id)sender {
//    
//    ViewController2 *vc2 = [[ViewController2 alloc] init];
//    [self.navigationController pushViewController:vc2 animated:YES];
    
    
}
@end
