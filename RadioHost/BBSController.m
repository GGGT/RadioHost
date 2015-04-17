//
//  BBSController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "BBSController.h"
#import "DeviceManager.h"
#import "ZhuBoDongTaiCell.h"
#import "ZhuBoDongTaiModel.h"
#import "UIImageView+AFNetworking.h"
#import "NetManager.h"
#import "DetailController.h"

#define kUrl   @"http://QQQQ.com/app/iOS.json?page=%d"

@interface BBSController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
}
@end

@implementation BBSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [[NSMutableArray alloc] init];
    
    
    
//    UIScrollView *scr2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, [DeviceManager currentScreenSize].width, 196)];
//    scr2.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:scr2];
//    
//    scr2.contentSize = CGSizeMake(800, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addTiTle:@"主播动态"];
    [self addimage:[UIImage imageNamed:@"ic_search@2x.png"] selector:@selector(search) location:YES];
    
    [self createUI];
    [self requestData:kUrl page:1];
    
    
}
-(void)search{
    
}
-(void)createUI{
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"ZhuBoDongTaiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
-(void)requestData:(NSString *)url page:(NSInteger)page{
    
    [NetManager requestWithString:[NSString stringWithFormat:url,page] finished:^(id responseObj) {
        
        NSArray *array =responseObj[@""];
        for (NSDictionary *subDic  in array) {
            ZhuBoDongTaiModel *model =[[ZhuBoDongTaiModel alloc] init];
            model.Img = subDic[@""];
            model.Title = subDic[@""];
            model.des = subDic[@""];
            model.Time = subDic[@""];
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
        
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
    
}


#pragma mark tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   // return _dataArray.count;
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId =@"cell";
    ZhuBoDongTaiCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (_dataArray.count) {
        
    ZhuBoDongTaiModel *model =_dataArray[indexPath.row];
    //[cell.Img setImageWithURL:[NSURL URLWithString:model.Img]];
    cell.Title.text = model.Title;
    cell.des.text = model.des;
    cell.TimeLabel.text =model.Time;
    }
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
//点击触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailController *det =[[DetailController alloc] init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:det];
    [self presentViewController:nav animated:YES completion:^{
    
    }];
    //[self.navigationController pushViewController:det animated:YES];
    
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
