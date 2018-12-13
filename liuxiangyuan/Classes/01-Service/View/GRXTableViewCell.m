//
//  GRXTableViewCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/19.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXTableViewCell.h"
#import "GRXTextButton.h"
@interface GRXTableViewCell()
@property (weak, nonatomic) GRXTextButton *btn;
@end
@implementation GRXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor redColor];
        
        
        
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    GRXTextButton *btn = [GRXTextButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    
//    NSLog(@"addSubviews%@",self.controller);
    [btn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchDown];
    self.btn = btn;
    [self.contentView addSubview:btn];
}

//- viewcontr

- (void)playClick{
    
    NSLog(@"点击了");
    
    self.block();
    
   /*
    //可实现控制器跳转
    for (UIView *next= [self superview]; next; next = next.superview) {
        
    
    UIResponder *nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        
        UIViewController *vc = (UIViewController *)nextResponder;
        
        
        UIViewController *vc1 = [[UIViewController alloc] init];
        
        //    vc.view.backgroundColor = [UIColor redColor];
        
        vc1.view.backgroundColor  = [UIColor greenColor];
//        UIView
        
        [vc.navigationController pushViewController:vc1 animated:YES];
      }
        
    }
     */
    
    
//    [[self.contentView viewController].navigationController pushViewController:vc animated:YES];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController pushViewController:vc animated:YES];
    
//        [self.btn.viewController.navigationController pushViewController:vc animated:YES];
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.btn.frame = CGRectMake(150, 0, 50, 50);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
