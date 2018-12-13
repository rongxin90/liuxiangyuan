//
//  GRXHomeFocusCollectionCell.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/13.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRXFocusModel;
@interface GRXHomeFocusCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) GRXFocusModel *model;

@end
