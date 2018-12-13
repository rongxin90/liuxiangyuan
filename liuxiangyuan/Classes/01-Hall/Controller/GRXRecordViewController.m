//
//  GRXRecordViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXRecordViewController.h"

@interface GRXRecordViewController ()

@end

@implementation GRXRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.titleLabel = [[UILabel alloc] init];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.backgroundColor = [UIColor greenColor];
    
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, 100, 50);
    self.titleLabel.center = self.view.center;
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
