//
//  GRXContentCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXContentCell.h"
#import "GRXButton.h"

#define randomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface GRXContentCell()


@end

@implementation GRXContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = self.backgroundColor;
        
        //设置内容视图
        [self setUpContentView];
    }
    return self;
}

- (void)setUpContentView
{
    self.contentButton = [GRXButton buttonWithType:UIButtonTypeCustom];
    
    self.contentButton.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [self.contentButton sizeToFit];
    [self.contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:self.contentButton];
    
}

- (void)click:(UIButton *)btn{
    
    NSLog(@"%ld",(long)btn.tag);
    
    NSNotification *notification = [NSNotification notificationWithName:@"GRXRecordNotification" object:@(btn.tag)];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.contentButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
}

@end
