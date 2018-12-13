//
//  GRXTableViewCell.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/19.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^backBlock)();

@interface GRXTableViewCell : UITableViewCell
@property (strong, nonatomic) UIViewController *controller;



@property (strong, nonatomic) backBlock block;

@end
