//
//  GRXTabbar.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXTabbar.h"
#import "GRXTabbarItem.h"

#define GRXColor(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
@interface GRXTabbar()

{
    // 记录组用户当前点击的是哪一个按钮
    GRXTabbarItem *_selectItem;
}


@end


@implementation GRXTabbar

- (void)addtabbarItemWithNormalImage:(NSString *)norImage andSelectedImage:(NSString *)selImage WithTitle:(NSString *)title{
    // 1.创建tabbarItem
    GRXTabbarItem *item = [[GRXTabbarItem alloc]init];
    item.backgroundColor = [UIColor blackColor];
    
    // 2.设置tabbaritem的图片
    [item setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    
    [item setTitle:title forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [item setTitleColor:GRXColor(245, 218, 164, 1) forState:UIControlStateSelected];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 添加按钮的点击事件
    [item addTarget:self action:@selector(handleItemClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:item];
    
    // 3.调整按钮的frame
    [self adjustItemFrame];
}

- (void)adjustItemFrame
{
    // 获取tabbar的宽度
    CGFloat width = self.frame.size.width;
    
    // 获取子视图的个数
    NSInteger sum = self.subviews.count;
    
    CGFloat widthBtn = width/sum;
    
    for (NSInteger i = 0; i < sum; i++) {
        GRXTabbarItem *item = self.subviews[i];
        item.frame = CGRectMake(i * widthBtn, 0, widthBtn, self.frame.size.height);
        
        item.tag = i;
        if (i == 0) {
            item.selected = YES;
            _selectItem = item;
        }
    }
}
// 按钮的点击事件
- (void)handleItemClick:(GRXTabbarItem *)item
{
//    NSLog(@"按钮被点击了");
    
    [self.delegate grx_bar:self ClickAtIndexFrom:_selectItem.tag To:item.tag];
    /*
     1.将上次选择的按钮设置为非选择状态
     2.将用户当前选择的按钮设置为选择状态
     */
    _selectItem.selected = NO;
    item.selected = YES;
    _selectItem = item;
}



@end
