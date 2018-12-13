//
//  meMessageCell.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class meMessageItem;



@interface meMessageCell : UITableViewCell
//模型属性
@property(nonatomic,strong)meMessageItem *item;

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *label;


@end

