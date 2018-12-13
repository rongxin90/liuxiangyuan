//
//  MineViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MineViewController.h"
#import "GRXMineTableViewCell.h"
#import "MeTableController.h"
#import "UIView+Frame.h"
#import "mineCell.h"
#import "mineViewItem.h"
#import "iconCell.h"
#import "UIImage+Radius.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
    {
        UITableView *_tableView;
    }
@property (strong, nonatomic)mineViewItem  *subtitle;
@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
    //查看缓存中是否有图片
    //    //将选择的图片显示出来
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
    if (filePath) {
        self.subtitle.iconName = filePath;
    }else{
        self.subtitle.iconName = nil;
    }
//        self.subtitle.iconName = filePath;

    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.userInteractionEnabled = YES;//设置tableView可滑动
    
//    _tableView.sectionFooterHeight = 10;
    //调整组与组之间的距离
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight =10;
    
    
    //    设置ttableView的滚动区域
    _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    _tableView.bounces = NO;
//    _tableView.style = UITableViewStyleGrouped;
    
    [self.view addSubview:_tableView];
   
    [self setUpCellContent];
}

- (void)setUpCellContent{
    mineViewItem *subTitle = [mineViewItem modelWithTitle:@"起昵称什么的好麻烦" andPictureName:@"icon" subTitle:@"积分：90分" withType:mineViewCellTypeArrow];
    self.subtitle = subTitle;
    subTitle.iconName = @"https://img5.duitang.com/uploads/item/201412/12/20141212014311_jwiC8.jpeg";
    subTitle.action = ^(){
        NSLog(@"656445");
        MeTableController *meVC = [[MeTableController alloc] init];
        [self.navigationController pushViewController:meVC animated:YES];
    };
    
    mineViewItem *servie = [mineViewItem modelWithTitle:@"我的订单服务" andPictureName:@"picture" subTitle:nil withType:mineViewCellTypeArrow];
    
    mineViewItem *renchou = [mineViewItem modelWithTitle:@"我的认筹及抢房" andPictureName:@"picture" subTitle:nil withType:mineViewCellTypeArrow];
    mineViewItem *xiangqin = [mineViewItem modelWithTitle:@"我的香亲汇" andPictureName:@"picture" subTitle:nil withType:mineViewCellTypeArrow];
    mineViewItem *jifen = [mineViewItem modelWithTitle:@"我的积分" andPictureName:@"picture" subTitle:nil withType:mineViewCellTypeArrow];
    
    mineViewItem *setting  = [mineViewItem modelWithTitle:@"设置" andPictureName:@"picture" subTitle:nil withType:mineViewCellTypeArrow];
    _dataArray = @[
                   @[subTitle],
                   @[servie,renchou,xiangqin,jifen],
                   @[setting]
                   
                   
                   ];
    
}

    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        NSArray *array = _dataArray[section];
        return array.count;
       
    }
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
       
        return _dataArray.count;
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%d",indexPath.row);
    if (indexPath.section == 0) {
        static NSString *cellid =@"icon";
        iconCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[iconCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        }
        mineViewItem *item = _dataArray[indexPath.section][indexPath.row];
        cell.item = item;
        return cell;
    }else{
        static NSString *cellid =@"cell";
        GRXMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GRXMineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        }
        mineViewItem *item = _dataArray[indexPath.section][indexPath.row];
        cell.item = item;
        return cell;
    }
   
}
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            return 100;
        }else{
            
            return 50;
        }
    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        mineViewItem *item = _dataArray[indexPath.section][indexPath.row];
        if (item.action) {
            item.action();
        }
       
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
