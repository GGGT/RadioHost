//
//  HomeViewController.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/14.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "DeviceManager.h"
#import "NetManager.h"
#import "RadioModel.h"
#import "MusicModel.h"
#import "TeModel.h"
#import "tableView1Cell.h"
#import "tableView2Cell.h"
#import "TesCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD.h"

#define kUrl @"http://GGGGG.com/app/iOS.json?page=%d"

@interface HomeViewController ()
{
    UILabel *label;
    BOOL isScroll;
    UIScrollView *_scrollView;
    NSMutableArray *RadioArray;
    NSMutableArray *MusicArray;
    NSMutableArray *TeArray;
    UITableView *tableView2;
    UITableView *tableView1;
    UICollectionView *_TesCollectionView;
    
    NSTimer *timer;
    UIView *bottomView;
    UIScrollView *Rascroll;
    UIScrollView *Muscroll;
   // UISegmentedControl *segment;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RadioArray = [[NSMutableArray alloc] init];
    MusicArray =[[NSMutableArray alloc] init];
    TeArray = [[NSMutableArray alloc] init];
    
    [self addTiTle:@"首页"];
    [self addimage:[UIImage imageNamed:@"night_top_navigation_searchbutton@2x"] selector:@selector(searchClick) location:NO];
    
    
    
    [self createUI];
   // [self createPoint];
    [self creatNSTimer];
    
    [self RadiorequestData:kUrl page:1];
    [self MusicrequestData:kUrl page:1];
    [self TerequestData:kUrl page:1];
    
    
    
    
}
-(void)searchClick{
    
}
//数据请求
  //电台的数据
-(void)RadiorequestData:(NSString *)url page:(NSInteger)page{
    
    NSString *urlString= [NSString stringWithFormat:url,page];
    [NetManager requestWithString:urlString finished:^(id responseObj) {
        // 比如是字典－数组－字典
        NSArray *array = responseObj[@""];
        for (NSDictionary *subdic in array) {
            RadioModel *model =[[RadioModel alloc] init];
            model.RadioImg =subdic[@""];
            model.bigTitle =subdic[@""];
            model.smallTitle =subdic[@""];
            
            [RadioArray addObject:model];
        }
        [tableView1 reloadData];
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
    
    
}
//音乐的数据
-(void)MusicrequestData:(NSString *)url page:(NSInteger)page{
    
    NSString *urlString= [NSString stringWithFormat:url,page];
    [NetManager requestWithString:urlString finished:^(id responseObj) {
        // 比如是数组－字典
//        NSArray *array = responseObj[@""];
        for (NSDictionary *subdic in responseObj) {
           MusicModel *model =[[MusicModel alloc] init];
            model.MusicImg =subdic[@""];
            model.Name =subdic[@""];
            model.des =subdic[@""];
            
            [MusicArray addObject:model];
        }
        [tableView2 reloadData];
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
    
    
}
//特色服务的数据
-(void)TerequestData:(NSString *)url page:(NSInteger)page{
    
    NSString *urlString= [NSString stringWithFormat:url,page];
    [NetManager requestWithString:urlString finished:^(id responseObj) {
        // 比如是字典－数组－字典
        NSArray *array = responseObj[@""];
        for (NSDictionary *subdic in array) {
            TeModel *model =[[TeModel alloc] init];
            model.TeImg =subdic[@""];
            model.Title =subdic[@""];
            model.smallTitle =subdic[@""];
            model.smaImage = subdic[@""];
            [TeArray addObject:model];
        }
        [_TesCollectionView reloadData];
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
    
    
}

-(void)createUI{
      //上半部分UI
    UIView *naview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [DeviceManager currentScreenSize].width, 40)];
    //naview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:naview];
    
    
    NSArray *arr = @[@"电台",@"音乐",@"特色服务"];
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [btn setTitleColor:[UIColor colorWithRed:101/255.0 green:190/255.0 blue:254/254.0 alpha:1] forState:UIControlStateSelected];
    //    [btn setFont:[UIFont systemFontOfSize:16]];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.tag=300+i;
        [btn setFrame:CGRectMake(i*[DeviceManager currentScreenSize].width/arr.count, 0, [DeviceManager currentScreenSize].width/arr.count, 38)];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
    if (i==0) {
            btn.selected=YES;
        }
        [naview addSubview:btn];
    }
    
//    segment =[[UISegmentedControl alloc] initWithItems:arr];
//    segment.frame = CGRectMake(0, 0, 320, 40);
//    segment.selectedSegmentIndex=0;
//    [segment addTarget:self action:@selector(segment:) forControlEvents:UIControlEventValueChanged];
//    [naview addSubview:segment];
    
      //滑动的label
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, [DeviceManager currentScreenSize].width/3, 3)];
    label.backgroundColor = [UIColor orangeColor];
    [naview addSubview:label];
    
 

    
    //    下半部分UI
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 104, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64-40)];
    //创建scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64)];
    _scrollView.contentSize = CGSizeMake([DeviceManager currentScreenSize].width*3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //电台tableView
    
     NSArray *Raimg = @[@"6.jpg",@"3.jpg",@"4.jpeg",@"5.jpg"];
    Rascroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    Rascroll.tag = 700;
    [_scrollView addSubview:Rascroll];
    Rascroll.contentSize = CGSizeMake(320*Raimg.count, 0);
    Rascroll.pagingEnabled = YES;
   
    for (NSInteger i=0; i<Raimg.count; i++) {
        UIImageView *imgview =[[UIImageView alloc] initWithFrame:CGRectMake(2+i*320, 2, 316, 180)];
        imgview.image = [UIImage imageNamed:Raimg[i]];
        //imgview.backgroundColor =[UIColor purpleColor];
        [Rascroll addSubview:imgview];
        
        UILabel *lab =[[UILabel alloc] initWithFrame:CGRectMake(270+i*320, 160, 100, 15)];
        lab.text = [NSString stringWithFormat:@"%ld / %ld",i+1,Raimg.count];
        lab.textColor = [UIColor colorWithWhite:250/255.0 alpha:0.9];
        [Rascroll addSubview:lab];
    }
    
    
    
    UIPageControl *pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 170, 60, 10)];
    pagecontrol.numberOfPages = Raimg.count;
    
    pagecontrol.pageIndicatorTintColor =[UIColor orangeColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor redColor];
    
    pagecontrol.tag = 600;
    [_scrollView addSubview:pagecontrol];

    
    
    tableView1  = [[UITableView alloc]initWithFrame:CGRectMake(0, 186, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64-40)];
    tableView1.delegate = self;
  tableView1.tag=400;
    //    tableView1.bounces = NO;
    //tableView1.separatorStyle = NO;
    tableView1.showsVerticalScrollIndicator = NO;
    tableView1.dataSource  =self;
    
    
    
       //音乐tableView
    
    NSArray *Muimg = @[@"2.jpg",@"4.jpeg",@"57.png"];

    Muscroll =[[UIScrollView alloc] initWithFrame:CGRectMake(320, 0, 320, 180)];
    Muscroll.tag = 800;
    [_scrollView addSubview:Muscroll];
    Muscroll.contentSize = CGSizeMake(320*Muimg.count, 0);
    Muscroll.pagingEnabled = YES;

    
       for (NSInteger i=0; i<Muimg.count; i++) {
        UIImageView *imgview =[[UIImageView alloc] initWithFrame:CGRectMake(5+i*320, 2, 310, 180)];
        imgview.image = [UIImage imageNamed:Muimg[i]];
        //imgview.backgroundColor =[UIColor purpleColor];
        [Muscroll addSubview:imgview];
        
        UILabel *lab =[[UILabel alloc] initWithFrame:CGRectMake(270+i*320, 160, 100, 20)];
        lab.text = [NSString stringWithFormat:@"%ld /  %ld",i+1,Muimg.count];
        lab.textColor = [UIColor greenColor];
        [Muscroll addSubview:lab];
    }
    
    tableView2 =[[UITableView alloc]initWithFrame:CGRectMake([DeviceManager currentScreenSize].width, 200, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64-40) style:UITableViewStylePlain];
    tableView2.delegate = self;
    tableView2.tag=401;
    
    tableView2.separatorStyle = NO;
    tableView2.showsVerticalScrollIndicator = NO;
    tableView2.dataSource  =self;
    
    //特色服务collectionView
    UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 2;
    flow.minimumInteritemSpacing = 2;
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    _TesCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([DeviceManager currentScreenSize].width*2, 0, [DeviceManager currentScreenSize].width, [DeviceManager currentScreenSize].height-64-40) collectionViewLayout:flow];
    _TesCollectionView.dataSource =self;
    _TesCollectionView.delegate = self;
    _TesCollectionView.backgroundColor = [UIColor whiteColor];
    _TesCollectionView.showsVerticalScrollIndicator = NO;
   
    
    [_scrollView addSubview:tableView1];
    [_scrollView addSubview:tableView2];
    [_scrollView addSubview:_TesCollectionView];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [bottomView addSubview:_scrollView];
    [self.view addSubview:bottomView];
    
    //注册cell
    [tableView1 registerNib:[UINib nibWithNibName:@"tableView1Cell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    [tableView2 registerNib:[UINib nibWithNibName:@"tableView2Cell" bundle:nil] forCellReuseIdentifier:@"cellName"];
    [_TesCollectionView registerNib:[UINib nibWithNibName:@"TesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
   // [SVProgressHUD showInView:naview status:@"玩命 加载中。。。"];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
//-(void)segment:(id)sender{
//    UISegmentedControl *control =(UISegmentedControl *)sender;
//    switch (control.selectedSegmentIndex) {
//        case 0:
//            if (_scrollView == NO) {
//                _scrollView.contentOffset = CGPointMake(0, 0);
//            }
//            break;
//        case 1:
////
////    [UIView animateWithDuration:0.3 animations:^{
////
//            if (_scrollView == NO) {
//                _scrollView.contentOffset = CGPointMake([DeviceManager currentScreenSize].width, 0);
//            }
////    NSLog(@"Segment:%ld",control.selectedSegmentIndex);
////    }];
//            break;
////            
//        default:
//            break;
//     }
//}

//点击btn切换界面
-(void)btnclick:(UIButton *)btn{
    NSLog(@"jinlaimei??/");
    
    for (NSInteger i=0; i<3; i++) {
        UIButton *btn =(UIButton *)[self.view viewWithTag:300+i];
        btn.selected = NO;
    }
    btn.selected = YES;
    
    NSLog(@"%ld",btn.tag);
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = btn.frame.origin;

        label.frame = CGRectMake(point.x, 37, [DeviceManager currentScreenSize].width/3, 3);
        
        if (isScroll == NO) {
            _scrollView.contentOffset =CGPointMake((btn.tag-300)*[DeviceManager currentScreenSize].width, 0);
            if (btn.tag==300) {
                //UIScrollView *scroll =(UIScrollView *)[self.view viewWithTag:700];
                UIPageControl *page =(UIPageControl *)[self.view viewWithTag:600];
                page.currentPage = Rascroll.contentOffset.x/320;
                NSLog(@"pppppppp");
            }
        }
        
    }];
    
    
}
#pragma scrollView
//滑动切换界面
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    UIScrollView *scroll =(UIScrollView *)[self.view viewWithTag:700];
//    UIPageControl *page =(UIPageControl *)[self.view viewWithTag:600];
//    page.currentPage = Rascroll.contentOffset.x/320;
//    NSLog(@"pppppppp");
//
    if (scrollView == Rascroll) {
       // UIScrollView *scroll =(UIScrollView *)[self.view viewWithTag:700];
        UIPageControl *page =(UIPageControl *)[self.view viewWithTag:600];
        page.currentPage = scrollView.contentOffset.x/320;
        NSLog(@"pppppppp");
    }
    
    
    if (scrollView == _scrollView) {
        
//       // UIScrollView *scroll =(UIScrollView *)[self.view viewWithTag:700];
//        UIPageControl *page =(UIPageControl *)[self.view viewWithTag:600];
//        page.currentPage = Rascroll.contentOffset.x/320;
//        NSLog(@"pppppppp");
        
        
        if (_scrollView.contentOffset.x <[DeviceManager currentScreenSize].width/2) {
            
            
            
            
            NSLog(@"~~~~~~~~~");
            UIButton *btn =(UIButton *)[self.view viewWithTag:300];
             isScroll =YES;
            [self btnclick:btn];
//            segment.selectedSegmentIndex = 0;
//            [self segment:segment];
            
           
        }
        if (_scrollView.contentOffset.x>[DeviceManager currentScreenSize].width/2 && _scrollView.contentOffset.x<[DeviceManager currentScreenSize].width) {
            UIButton *btn =(UIButton *)[self.view viewWithTag:301];
             isScroll =YES;
            [self btnclick:btn];
//            segment.selectedSegmentIndex = 1;
//            [self segment:segment];
           
        }
        if (_scrollView.contentOffset.x>[DeviceManager currentScreenSize].width*3/2 && _scrollView.contentOffset.x<[DeviceManager currentScreenSize].width*2) {
            UIButton *btn =(UIButton *)[self.view viewWithTag:302];
            isScroll =YES;
           // segment.selectedSegmentIndex =2;
            [self btnclick:btn];
            //[self segment:segment];
        }
        
        isScroll =NO;
        
        
        
       
    }
    
    //if (scrollView == Rascroll) {
      //  scrollView =[self.view viewWithTag:700];
   
    //}
}




#pragma tableView
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == tableView1) {
        //return RadioArray.count;
        return 8;
    }else{
        //return MusicArray.count;
        return 5;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableView1) {
       
        
        static NSString *cellID =@"CellID";
        tableView1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
         if (RadioArray.count) {
        RadioModel *model = RadioArray[indexPath.row];
        //[cell.RadioImg setImageWithURL:[NSURL URLWithString:model.RadioImg]];
        cell.bigTitle.text = model.bigTitle;
        cell.smallTitle.text = [NSString stringWithFormat:@"%@",model.smallTitle];
        
     //   [SVProgressHUD dismiss];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        return cell;
        
    }else{
        static NSString *cellName =@"cellName";
        tableView2Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
        if (MusicArray.count) {
            
        MusicModel *model =MusicArray[indexPath.row];
       // [cell.MusicImg setImageWithURL:[NSURL URLWithString:model.MusicImg]];
        cell.Name.text =model.Name;
        cell.des.text =[NSString stringWithFormat:@"%@",model.des];
        }
        return cell;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableView1) {
        return 80;
    }else{
        return 90;
    }
}
//点击触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableView1) {
        NSLog(@"HHHHHH");
    }
    if (tableView == tableView2) {
        NSLog(@"MMMMM");
    }
    
}

#pragma collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //return TeArray.count;
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellid =@"cell";
    TesCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
      //判断 增强代码强壮型
    if (TeArray.count) {
        TeModel *model =TeArray[indexPath.item];
        [MBProgressHUD showHUDAddedTo:cell.TesImg animated:YES];
//        [cell.TesImg setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.TeImg]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            
//            [cell.TesImg setImage:image];
//            [MBProgressHUD hideAllHUDsForView:cell.TesImg animated:YES];
//            
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//            
//        }];
        
       
        cell.Title.text =model.Title;
        [cell.smaImage setImageWithURL:[NSURL URLWithString:model.smaImage]];
        cell.smallTitle.text = [NSString stringWithFormat:@"%@",model.smallTitle];
        
    }
    return cell;
}
#pragma flow layout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(150, 150);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 10, 5, 5);
}
//点击触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"KKKKKK");
}


#pragma Point
-(void)createPoint1{
    
    UIPageControl *pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 170, 60, 10)];
    pagecontrol.numberOfPages = RadioArray.count;
    
    pagecontrol.pageIndicatorTintColor =[UIColor orangeColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    pagecontrol.tag = 600;
    [bottomView addSubview:pagecontrol];
    
    
    
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    UIPageControl *page =(UIPageControl *)[self.view viewWithTag:600];
//    //计算pagecontrol当前小白点的个数
//    // page.currentPage = scrollView.contentOffset.x/320;
//    
//}

-(void)createPoint2{
    
    UIPageControl *pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 170, 60, 10)];
    pagecontrol.numberOfPages = RadioArray.count;
    
    pagecontrol.pageIndicatorTintColor =[UIColor orangeColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    pagecontrol.tag = 600;
    [bottomView addSubview:pagecontrol];
    
    
    
}  //定时器
-(void)creatNSTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
}
-(void)timerStar{
    static wid =320;
    
    UIScrollView *scrview = (UIScrollView *)[self.view viewWithTag:700];
    //当滚到最后一张时，滚到第一张
    if (scrview.contentOffset.x == [DeviceManager currentScreenSize].width*3) {
        wid =-[DeviceManager currentScreenSize].width*3;
        
         CGPoint point = CGPointMake(wid+scrview.contentOffset.x, 0);
    }
    if (scrview.contentOffset.x == 0) {
        wid = [DeviceManager currentScreenSize].width;
    }
    
    CGPoint point = CGPointMake(wid+scrview.contentOffset.x, 0);
    [scrview setContentOffset:point animated:YES];
    
    static widh =320;
    UIScrollView *scr = (UIScrollView *)[self.view viewWithTag:800];
    if (scr.contentOffset.x == [DeviceManager currentScreenSize].width*2) {
        widh = -[DeviceManager currentScreenSize].width;
    }
    if (scr.contentOffset.x ==0) {
        widh = [DeviceManager currentScreenSize].width;
    }
    CGPoint poin = CGPointMake(widh+scr.contentOffset.x, 0);
    [scr setContentOffset:poin animated:YES];
    
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
