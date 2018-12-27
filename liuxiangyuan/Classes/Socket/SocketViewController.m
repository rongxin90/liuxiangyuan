//
//  SocketViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/12/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "SocketViewController.h"
#import "severNavController.h"
#import "clientNavController.h"
#import "severController.h"
#import "clientController.h"
@interface SocketViewController ()

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    severController *root1 = [[severController alloc] init];
    root1.title = @"服务器";
    severNavController *nav1 = [[severNavController alloc] initWithRootViewController:root1];
    //    nav1.title = @"服务器";
    
    clientController *root2 = [[clientController alloc] init];
    root2.title = @"客户端";
    clientNavController *nav2 = [[clientNavController alloc] initWithRootViewController:root2];
    
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    
    NSLog(@"%@",self.childViewControllers);
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
