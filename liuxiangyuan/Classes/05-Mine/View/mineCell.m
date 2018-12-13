//
//  mineCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/7.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "mineCell.h"
#import "UIView+Frame.h"
@interface mineCell()
{
    
    UIImageView *_imageView;
}

@end
@implementation mineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end
