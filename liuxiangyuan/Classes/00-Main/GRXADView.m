//
//  GRXADView.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXADView.h"
@interface GRXADView()

{
    UIImageView *_imageView;
}

@end
@implementation GRXADView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.image = [UIImage imageNamed:@"adImage"];
    _imageView = imageView;
//    imageView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self addSubview:imageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

@end
