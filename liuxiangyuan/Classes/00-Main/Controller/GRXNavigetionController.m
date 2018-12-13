//
//  GRXNavigetionController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXNavigetionController.h"

@interface GRXNavigetionController ()

@end

@implementation GRXNavigetionController


//一个类只会调用一次，在一个类被引用的时候调用
+(void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置背景色
//    [bar setBackgroundImage:[UIImage imageNamed:@"navbar64"] forBarMetrics:UIBarMetricsDefault];
    
    
    // 设置导航栏文字颜色以及大小
    NSDictionary *dict1 = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:20],
                            NSForegroundColorAttributeName : [UIColor blackColor]
                            };
    [bar setTitleTextAttributes:dict1];
    
    bar.tintColor = [UIColor blackColor];
    // 获取导航栏按钮全局实例
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *dict2 = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:14],
                            NSForegroundColorAttributeName : [UIColor blackColor]
                            };
    // 设置文字颜色的优先级高于tintColor
    [item setTitleTextAttributes:dict2 forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict2 forState:UIControlStateHighlighted];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        // 判断是否传过来的是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
