//
//  GRXCarouselImageView.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GRXFocusModel;
@protocol GRXCarouselImageViewDelegate <NSObject>

@required
-(void)grx_carouselImageClickTag:(NSInteger)tag;

@end

@interface GRXCarouselImageView : UIView

//图片数组
@property (strong, nonatomic) NSArray *imagesArray;

//@property (strong, nonatomic) GRXFocusModel *model;

@property (weak, nonatomic) id<GRXCarouselImageViewDelegate> delegate;


@end
