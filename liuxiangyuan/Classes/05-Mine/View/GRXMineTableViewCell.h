//
//  GRXMineTableViewCell.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class mineViewItem;

@interface GRXMineTableViewCell : UITableViewCell
@property (weak, nonatomic)UIImageView *iconImageView;
@property (weak, nonatomic)UILabel *nameLabel;
@property (weak, nonatomic)UILabel *jifenLable;

@property (strong, nonatomic) mineViewItem *item;
@end


