//
//  GRXMineTableViewCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "GRXMineTableViewCell.h"
#import "mineViewItem.h"
#import "UIView+Frame.h"
#import "UIImage+Radius.h"
#import <UIImageView+WebCache.h>
@interface GRXMineTableViewCell ()
{
    UIImageView *_arrow;
    UIImageView *_icon;

}
@end
@implementation GRXMineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //修改文字颜色
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
 }

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.imageView.width = 80;
//    self.imageView.height = 80;
    
}

- (void)setItem:(mineViewItem *)item{
    
    _item = item;
    
    UIImage *image = [UIImage imageNamed:item.pictureName];
    image = [UIImage grx_radiusWithImage:image];
    self.imageView.image = image;

    self.textLabel.text = item.title;

    self.detailTextLabel.text = item.subTitle;
//    self.accessoryType = nil;
    //设置cell的选中样式
    self.selectionStyle = UITableViewCellStyleSubtitle;
    if (item.type == mineViewCellTypeArrow) {
        [self addArrow];
    }else{
        
        return;
    }
}
///添加箭头）
-(void)addArrow{
    
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    }
    self.accessoryView = _arrow;
}

@end
