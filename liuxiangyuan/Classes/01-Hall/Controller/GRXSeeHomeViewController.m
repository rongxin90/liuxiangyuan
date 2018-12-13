//
//  GRXSeeHomeViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXSeeHomeViewController.h"
#import "UIImage+Radius.h"
@interface GRXSeeHomeViewController ()

@end

@implementation GRXSeeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.titleLabel = [[UILabel alloc] init];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.backgroundColor = [UIColor blueColor];
    
    self.titleLabel.textColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    
    
    
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, 100, 50);
    self.titleLabel.center = self.view.center;
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
