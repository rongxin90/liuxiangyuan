//
//  meMessageCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "meMessageCell.h"
#import "meMessageItem.h"
#import "UIImage+Radius.h"
#import <UIImageView+WebCache.h>
#define arc4random_uniform(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
@interface meMessageCell()
    
    {
        UIImageView *_arrow;
        UIImageView *_icon;
        UILabel *_lable;        
    }
@end
@implementation meMessageCell



- (void)layoutSubviews{
    [super layoutSubviews];
    //查看缓存中是否有图片
    //将选择的图片显示出来
//    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
    //从沙盒获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:_item.iconName];
    //设置圆角图片
    image = [UIImage grx_radiusWithImage:image];
    //        self.iconImageView.image = erd;
//    NSLog(@"+++erd==%@",erd);
    if (image) {
        _icon.image = image;
    }else{
        UIImage *image = [UIImage imageNamed:@"icon"];
        image = [UIImage grx_radiusWithImage:image];
        _icon.image = image;
    }
    
}



   //初始化cell
    - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            //修改cell的文字颜色
            self.textLabel.numberOfLines = 0;
            self.textLabel.textColor = [UIColor blackColor];
            self.textLabel.font = [UIFont systemFontOfSize:12];

             //设置背景色
             UIView *viewBG = [[UIView alloc] init];
            viewBG.backgroundColor = [UIColor whiteColor];
            self.backgroundView = viewBG;

            //设置被选中的背景色
            UIView *selBG = [[UIView alloc] init];
            selBG.backgroundColor = arc4random_uniform(238,234,223);
            self.selectedBackgroundView = selBG;
        }
        return self;
    }
    
    - (void)setItem:(meMessageItem *)item{
        _item = item;
        self.textLabel.text = item.title;
        self.imageView.image = [UIImage imageNamed:item.pictureName];
        //设置cell的选中样式
        self.selectionStyle = UITableViewCellStyleSubtitle;
        
        //判断是否有子标题
        if (item.subTitle) {
            self.detailTextLabel.text = item.subTitle;
            self.detailTextLabel.textColor = [UIColor redColor];
            self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        
        //判断模型类型
        if (item.type == meMessageCellTypeArrow) {
            [self setUpArrow];
        }else if(item.type == meMessageCellTypeLabel){
            [self setUpLabel];
            
        }else if(item.type == meMessageCellTypeIcon){
            [self setUpIcon];
            
        }else{
            
            self.accessoryView = nil;
        }
        
    }

    
    
    
    
    //设置cell的样式
    -(void)setUpArrow{
        
        //判断是否已经存在带箭头的控件
        if (_arrow == nil) {
            _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        }
        self.accessoryView = _arrow;
    }


    -(void)setUpIcon{
        
  
        //判断是否已经存在带图片的控件
            if (!_icon) {
                _icon = [[UIImageView alloc] init];
                CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
                _icon.frame = CGRectMake(screenW - 50, 10, 30, 30);
                _icon.center = CGPointMake(screenW - 50, self.contentView.center.y);
                [self.contentView addSubview:_icon];
            }
        
            [self setUpArrow];
    }
    
    
    //添加右边的label
    -(void)setUpLabel{
        
        if (!_label) {
            _label =[[UILabel alloc] init];
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            _label.numberOfLines = 0;
            _label.frame = CGRectMake(screenW - 180, 0, 150, self.bounds.size.height);
            [self.contentView addSubview:_label];
            
            _label.textAlignment = NSTextAlignmentRight;
            _label.textColor = [UIColor lightGrayColor];
            _label.font = [UIFont systemFontOfSize:12];
            
        }
        _label.text = _item.detail;
        
        [self setUpArrow];
    }

@end
