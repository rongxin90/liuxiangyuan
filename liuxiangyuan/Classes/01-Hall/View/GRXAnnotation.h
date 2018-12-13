//
//  GRXAnnotation.h
//  text
//
//  Created by 桂荣信 on 2018/11/21.
//  Copyright © 2018年 guirongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GRXAnnotation : NSObject<MKAnnotation>

@property(nonatomic)CLLocationCoordinate2D coordinate;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
