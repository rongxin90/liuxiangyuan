//
//  ServiceSetViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "ServiceSetViewController.h"
#import "GRXTableView.h"
#import "GRXTableViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "GRXNetWorkTool.h"
#import "GRXFocusModel.h"
#import <MJExtension/MJExtension.h>
#import "UIView+Frame.h"
@interface ServiceSetViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>


{
    NSMutableArray *_focusArray;
    NSMutableArray *_imageUrlArray;
    SDCycleScrollView *_headView;
    GRXTableView *_tableView;
}

@property (strong, nonatomic) GRXTableViewCell *cell;
@end

@implementation ServiceSetViewController

static NSString *cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadTopData];
    
//    [self initHeadView];
    
//    [self initTableView];
    
    _focusArray = [NSMutableArray array];
    _imageUrlArray = [NSMutableArray array];
    
//    GRXTableView *view = [[GRXTableView alloc] init];
//    
//    view.frame = CGRectMake(0, 0, 300, 400);
//    view.dataSource = self;
//    view.delegate = self;
//    view.rowHeight = 100;
//    
//    view.backgroundColor = [UIColor blueColor];
//    [view registerClass:[GRXTableViewCell class] forCellReuseIdentifier:cellID];
//    
//    [self.view addSubview:view];
//    [self performSelector:@selector(initTableView) withObject:nil afterDelay:3];
    
}




-(void)initTableView
{
    
//    NSLog(@"-----------%@",_imageUrlArray[0]);
    _tableView=[[GRXTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

-(void)initHeadView
{
    
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 200) imageNamesGroup:_imageUrlArray];
    
//    [dispatch_after(3, dispatch_get_main_queue(), ^{
//        _headView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 200) imageURLStringsGroup:_imageUrlArray];
        //    _headView.titlesGroup=_titleArray;
        _headView.placeholderImage=[UIImage imageNamed:@"Headline_View_Placehold~iphone"];
        _headView.delegate=self;
        _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
        _headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    
        
//    })];
    
    
}

- (void)loadTopData{
    NSString *urlString = @"http://www.mocky.io/v2/58caac840f00002f10e548b0";
    
    [GRXNetWorkTool grx_loadDataWithUrlString:urlString andParameter:nil reloadData:^(NSDictionary *reloadData) {
        _focusArray = [GRXFocusModel mj_objectArrayWithKeyValuesArray:reloadData[@"data"][@"focusList"]];
        
        
        for (GRXFocusModel *model in _focusArray) {
            NSString *str = @"http://newimg.4001113900.com/";
            
            NSString *urlString = [str stringByAppendingPathComponent:model.newsUrl];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            [_imageUrlArray addObject:url];
        }
//        NSLog(@"%@",_focusArray);
        _headView.imageURLStringsGroup = _imageUrlArray;
        
        
        
//        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[GRXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID]
        ;
    }
//    cell.controller = self;
//    self.cell = cell;
    __block typeof(self) weakSelf = self;//block防止循环引用
    cell.block = ^{
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor greenColor];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"------------%ld",indexPath.row);
    
    
    
    
    
   
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
