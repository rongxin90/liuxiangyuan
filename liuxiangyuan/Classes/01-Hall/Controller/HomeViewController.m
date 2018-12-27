//
//  HomeViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HomeViewController.h"
#import "GRXSeeHomeViewController.h"
#import "GRXRecordViewController.h"
#import "GRXCarouselImageView.h"
#import "GRXNavigationController.h"

#import "UIBarButtonItem+item.h"
#import "GRXButton.h"
#import "GRXSeparatorCell.h"
#import "GRXRecordCell.h"

#import "GRXNavigationItem.h"
#import "GRXNetWorkTool.h"
#import "GRXFocusModel.h"
#import <MJExtension/MJExtension.h>
#import "UIView+Frame.h"
#import "GRXImageCollectionView.h"
#import "GRXImageCollectionCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "GRXHTMLController.h"

//#import "GRXCardViewController.h"
#import "QRCodeViewController.h"

@interface HomeViewController ()<GRXCarouselImageViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
//    NSArray *_focusArray;
    GRXRecordCell *_recordCell;
    UICollectionViewFlowLayout *_flowLayout;
    GRXImageCollectionView *_collectionView;
    SDCycleScrollView *_scrollView;
    NSMutableArray *_imageArray;
//    UITableView *_tableView;
    NSMutableArray *_urlArray;
    
    
}

@property (weak, nonatomic) UITableView *tableView;

@property(weak,nonatomic)UIButton *signBtn;
@property(weak,nonatomic)UIAlertView  *alertView;
@property (strong, nonatomic) NSMutableArray *focusArray;

@property (strong, nonatomic) NSMutableArray *dataArray;

//@property (nonatomic ,weak) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *imageNames;

@property (strong, nonatomic) GRXCarouselImageView *headerView;


@end

@implementation HomeViewController

//轮播图图片数组懒加载
- (NSArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = @[@"home_subscribe~iphone",
                        @"home_consult~iphone",
                        @"home_life~iphone",
                        @"home_health~iphone",
                        @"home_club~iphone",
                        @"home_littleshop~iphone",
                        @"home_team~iphone",
                        ];
    }
    return _imageNames;
}




static NSString *separatorCell = @"separatorCell";
static NSString *recordeCell = @"recordeCell";
static NSString *imageCell = @"imageCell";
static NSString *idfinerID = @"idfinerID";

- (void)viewDidLoad {
    [super viewDidLoad];

    //数据加载
    [self lodNetData];
     [self setInitTableView];
    
    [self setUpHeaderView];
    //设置navigation
    [self setUpNavigation];
    
   
    
    //注册分割线的cell
    [_tableView registerClass:[GRXSeparatorCell class] forCellReuseIdentifier:separatorCell];
    
    //注册成长记cell
    [_tableView registerClass:[GRXRecordCell class] forCellReuseIdentifier:recordeCell];
    
    
    //接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordClick:) name:@"GRXRecordNotification" object:nil];
    
    
    [self setUpFooterView];
    
    _focusArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    _urlArray   = [NSMutableArray array];
    
    //添加签到按钮
    [self addSignButton];
    
}
- (void)addSignButton{
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signBtn setBackgroundColor:[UIColor lightGrayColor]];
    [signBtn setTitle:@"签到" forState:UIControlStateNormal];
    signBtn.layer.cornerRadius = 25.0;
    [signBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [signBtn sizeToFit];
    
    [signBtn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    
    self.signBtn =signBtn;
    [self.view addSubview:signBtn];
    
}
    
    //展示弹框，持续2秒后消失
- (void)showAlert{
    
    UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"已连续签到1天，获得5个积分" message:@"每日留香，积分累加，持续签到，更有机会换区神秘大奖~" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    self.alertView = alertView;
    [self performSelector:@selector(dissmissAlert:) withObject:self.alertView afterDelay:2];
    [alertView show];
//    NSLog(@"点击弹框");
}
    //弹框消失
- (void)dissmissAlert:(UIAlertView *)alertView{
        if (alertView.visible) {
            [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
            self.signBtn.hidden = YES;
        }
}
    
    
- (void)setInitTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49) style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableHeaderView=_scrollView;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.signBtn.frame =CGRectMake(self.view.bounds.size.width - 70, self.view.bounds.size.height - 64, 50, 50);
}

//tableView头部视图轮播图设置
- (void)setUpHeaderView{
    
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    CGRect rect = CGRectMake(0, 0, self.view.width, 100);

    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 200) imageNamesGroup:_imageArray];
//    _scrollView.imageURLStringsGroup = _imageArray;
    _scrollView.placeholderImage = [UIImage imageNamed:@"Headline_View_Placehold~iphone"];
//    NSLog(@"---------%@",_focusArray[0]);
    _scrollView.delegate = self;
    _scrollView.autoScrollTimeInterval = 3;// 自动滚动时间间隔
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页 右下角
    _scrollView.titleLabelBackgroundColor = [UIColor clearColor];// 图片对应的标题的 背景色。（因为没有设标题）
    self.tableView.tableHeaderView = _scrollView;
}
-(void)clickBtn{
    
    NSString *str = @"http://www.mocky.io/v2/58d23fc91000004c00b16371";
    GRXHTMLController *htmlVC = [[GRXHTMLController alloc] initWithUrl:str];;
    htmlVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark - 轮播图图片点击事件处理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    GRXHTMLController *htmlVC = [[GRXHTMLController alloc] initWithUrl:_urlArray[index]];;
    htmlVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:htmlVC animated:YES];

}






#pragma mark - tableView尾部视图的设置
- (void)setUpFooterView{
    //创建一个流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 6.0, (450 - 30) / 4.0);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _flowLayout = flowLayout;
    
    //创建一个UICollectionView
    GRXImageCollectionView *collectionView = [[GRXImageCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.frame = CGRectMake(0, 0, self.view.width, 450);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = self.view.backgroundColor;
    collectionView.bounces = NO;
    _tableView.tableFooterView = collectionView;
    
    
    //注册cell
    [collectionView registerClass:[GRXImageCollectionCell class] forCellWithReuseIdentifier:idfinerID];
    _collectionView = collectionView;
}

#pragma mark -CollectionView的代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 6) {
        return CGSizeMake(self.view.bounds.size.width - 20, (450 - 20 - 30) / 4.0);
    }else{
        return   CGSizeMake((self.view.bounds.size.width - 30) / 2.0, (450 - 20 - 30) / 4.0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRXImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idfinerID forIndexPath:indexPath];
    cell.iamgeView.image = [UIImage imageNamed:self.imageNames[indexPath.item]];
    return cell;
}




//监听大事记的按钮点击
- (void)recordClick:(NSNotification *)notification{
    
    
    GRXRecordViewController *vc = [[GRXRecordViewController alloc] init];
    NSInteger index = [notification.object integerValue];
    
    
    [vc.view addSubview:vc.titleLabel];
    vc.titleLabel.text = _recordCell.title[index];
    
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)dealloc{
    //移除所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --网络数据加载
- (void)lodNetData{
    
    
    NSString *urlString = @"http://www.mocky.io/v2/58d241531000005f00b1637b";
    
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [GRXNetWorkTool grx_loadDataWithUrlString:urlString andParameter:nil reloadData:^(NSDictionary *reloadData) {
        self->_focusArray = [GRXFocusModel mj_objectArrayWithKeyValuesArray:reloadData[@"data"][@"focusList"]];
        for (GRXFocusModel *model in self->_focusArray) {
            [self->_imageArray addObject:model.small_pic];
            [self->_urlArray addObject:model.newsUrl];
        }
        
//        NSLog(@"%@",_imageArray);
        self->_scrollView.imageURLStringsGroup = _imageArray;
    }];
}

#pragma mark-设置navigation
- (void)setUpNavigation{
    
    self.navigationItem.title = @"绿城留香园";//只对navigationItem有效
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:0 target:self action:@selector(navigationItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
   
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    rightBtn.frame = CGRectMake(0, 0, 50, 50);
    UIImage *image = [UIImage imageNamed:@"scan-normal"];
    UIImage *imageTouch = [UIImage imageNamed:@"scan-highlight"];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:image forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:imageTouch forState:UIControlStateHighlighted];
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = rightBtn.bounds;

    
    [view addSubview:rightBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItems =@[rightItem];
}

-(void)rightBtnClick{
    
    QRCodeViewController *QRCodeVC =[[QRCodeViewController alloc] init];
    
    
    //通过StoryBoardID来获取StoryBoard创建的控制器0
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"QRCodeController" bundle:[NSBundle mainBundle]];
//
//
//    QRCodeController *qrcode = [story instantiateViewControllerWithIdentifier:@"QRCodeVC"];
    [self.navigationController pushViewController:QRCodeVC animated:YES];
}

- (void)navigationItemClick{
    GRXNavigationController *vc = [[GRXNavigationController alloc] init];
//    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0 || indexPath.row == 2){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:separatorCell];
        return cell;
        
    }else{
            GRXRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordeCell];
            _recordCell = cell;
            return cell;
    }
}

#pragma mark - TableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 2 == 0){
        return 10;
    }else if(indexPath.row == 3){
        return 450;
        
    }else{
        return 110;
    }
}



@end
