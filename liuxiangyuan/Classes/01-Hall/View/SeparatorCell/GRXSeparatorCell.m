//
//  GRXSeparatorCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/13.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXSeparatorCell.h"
// 定义全局背景色
#define GlobeColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]

@implementation GRXSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置cell没有选中背景色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = GlobeColor;
        
        // 调整分割线的距离
        //        NSLog(@"%@ %@", NSStringFromUIEdgeInsets(self.separatorInset),NSStringFromUIEdgeInsets(self.layoutMargins));
        
        self.separatorInset = UIEdgeInsetsZero;
        if ([self respondsToSelector:@selector(layoutMargins)]) {
            self.layoutMargins = UIEdgeInsetsZero;
        }
    }
    return self;
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
