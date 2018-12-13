//
//  GRXHTMLController.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HtmlModel;
@interface GRXHTMLController : UIViewController

@property (strong, nonatomic) HtmlModel *model;
//@property (strong, nonatomic) NSString *urlString;
- (instancetype)initWithUrl:(NSString *)urlString;
@end
