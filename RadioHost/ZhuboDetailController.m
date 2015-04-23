//
//  ZhuboDetailController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/21.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "ZhuboDetailController.h"
#import "ZhuboDetailCell.h"


@interface ZhuboDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabView;
}

@end

@implementation ZhuboDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithWhite:200/255.0 alpha:0.3];
    
    [self createUI];
    
//    self.view.backgroundColor =[UIColor colorWithWhite:255/255.0 alpha:1];
    [self addTiTle:@"小强来了"];
    [self addimage:[UIImage imageNamed:@"222.png"] selector:@selector(backClick) location:YES];
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)createUI{
    
    UIView *vie =[[UIView alloc] initWithFrame:CGRectMake(0, 0, wid,heigh/3)];
    vie.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vie];
    
    UIImageView *imgview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"333"]];
    imgview.frame = CGRectMake(16, 74, 50, 50);
    [self.view addSubview:imgview];
    
    UILabel *lab1 =[[UILabel alloc] initWithFrame:CGRectMake(70, 74, 100, 26)];
    lab1.text = @"小强来了";
    lab1.textColor = [UIColor blueColor];
    lab1.font =[UIFont systemFontOfSize:19];
    [self.view addSubview:lab1];
    
    
    UILabel *lab2 =[[UILabel alloc] initWithFrame:CGRectMake(70, 100, 100, 26)];
    lab2.text = @"金牌达人";
    lab2.textColor = [UIColor darkGrayColor];
    lab2.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:lab2];
    
    NSArray *arr =@[@"亲密度",@"粉丝",@"赞"];
    NSArray *arr1 =@[@"44",@"4444",@"444"];
   // NSMutableArray *marr =[[NSMutableArray alloc] init];
    NSArray *marr =@[@"99",@"1470",@"2107"];
    for (NSInteger i=0; i<3; i++) {
        
        UIImageView *imgview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:arr1[i]]];
        imgview.frame = CGRectMake(20+i*wid/3, 140, 28, 28);
        [self.view addSubview:imgview];
        
        UILabel *lab3 =[[UILabel alloc] initWithFrame:CGRectMake(49+i*wid/3, 139, 100, 30)];
        lab3.text = arr[i];
        lab3.textColor = [UIColor darkGrayColor];
        lab3.font =[UIFont systemFontOfSize:15];
        [self.view addSubview:lab3];
        
        UILabel *lab4 =[[UILabel alloc] initWithFrame:CGRectMake(40+i*wid/3, 165, 100, 30)];
        lab4.text = marr[i];
        lab4.textColor = [UIColor orangeColor];
        lab4.font =[UIFont systemFontOfSize:15];
        [self.view addSubview:lab4];

    }
    
    _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, heigh/3+60, wid, 4*40) style:UITableViewStylePlain];
    _tabView.delegate =self;
    _tabView.dataSource =self;
    [self.view addSubview:_tabView];
    
    [_tabView registerNib:[UINib nibWithNibName:@"ZhuboDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"主播互动" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"444"] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(10, heigh-40, (wid-20)/2-1, 40)];
    [btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
[btn2 setTitle:@"成为粉丝" forState:UIControlStateNormal];
     [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"4444"] forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(wid/2, heigh-40, (wid-20)/2, 40)];
    [btn2 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
}
#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID =@"cell";
    ZhuboDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
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
