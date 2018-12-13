//
//  GRXChangeName.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/13.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "GRXChangeName.h"
#import "UIView+Frame.h"
#import "MeTableController.h"
@interface GRXChangeName ()
@property (weak, nonatomic) UITextField *textField;
@end

@implementation GRXChangeName

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpChildView];
}
- (void)setUpChildView{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.frame = CGRectMake(80, 75, self.view.width-80, 30);
    self.textField = textField;
    [self.view addSubview:textField];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"昵称：";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.frame = CGRectMake(0, 75, 80, 30);
    [self.view insertSubview:label aboveSubview:textField];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认提交" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 150, self.view.width, 30);
//    [btn sizeToFit];
    [self.view addSubview:btn];
    
}

- (void)click{
    NSLog(@"点击提交昵称修改");
    

    if ([self.textField.text isEqualToString:@" "] || self.textField.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请填写需要修改的昵称，否则请返回，谢谢" delegate:self cancelButtonTitle:@"取消 " otherButtonTitles:nil];
        [alert show];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        NSDictionary *dict = @{@"object":self.textField.text};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:dict];
//        //此页面已经存在于self.navigationController.viewControllers中,并且是当前页面的前一页面
//        MeTableController *setPrizeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//        //传递参数过去
//        setPrizeVC.name = self.textField.text;;
//        //使用popToViewController返回并传值到上一页面
//        [self.navigationController popToViewController:setPrizeVC animated:true];
    }
    
   
    
}
- (void)dealloc{
    
    NSLog(@"已销毁");
}

@end
