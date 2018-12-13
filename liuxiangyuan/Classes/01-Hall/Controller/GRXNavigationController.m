//
//  GRXNavigationController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/3.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "GRXNavigationController.h"
#import "CoreLocation/CoreLocation.h"
#import "UIImage+Radius.h"
#import <UIImageView+WebCache.h>
#import <MapKit/MapKit.h>
#import "UIView+Frame.h"
#import "GRXAnnotation.h"
@interface GRXNavigationController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *_locationManager; /**< 定位服务 */
}

@property (weak, nonatomic) MKMapView *mapView;

@property (assign, nonatomic) CLLocationCoordinate2D coordinateStart;
@property (assign, nonatomic) CLLocationCoordinate2D coordinateEnd;
@end

@implementation GRXNavigationController


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"点击了");
    //获取沙盒路径
    //   NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    
    //判断设备是否开启定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备暂未开启定位服务!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        return;

    }
    //初始化定位服务
    _locationManager = [[CLLocationManager alloc] init];
    //请求定位授权
    [_locationManager requestWhenInUseAuthorization];
    //请求在后台定位授权
    [_locationManager requestAlwaysAuthorization];
    //设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设定定位频率
    _locationManager.distanceFilter = 10.0;
    
    //设置代理
    _locationManager.delegate = self;
    
    //开始定位
    [_locationManager startUpdatingLocation];
    
    [self setUpLocation];
    
}

- (void)setUpLocation{
    
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.backgroundColor = [UIColor redColor];
    mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    mapView.delegate = self;
    self.mapView = mapView;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:mapView];
    
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(30.2728464052,120.2308666706);
    self.coordinateEnd = location1;
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(location1, 2000, 2000) animated:YES];
    GRXAnnotation *annotation = [[GRXAnnotation alloc] init];
    annotation.title = @"绿城-留香园";
    annotation.subtitle = @"一键导航至绿城留香园";
    annotation.coordinate = location1;
    [mapView addAnnotation:annotation];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败");
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //获取最新定位
    CLLocation *location = locations.lastObject;
    
//    CLLocationCoordinate2D coordinateStart = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    self.coordinateStart = location.coordinate;
    //打印定位
//    NSLog(@"纬度：%.2f，经度：%.2f",location.coordinate.latitude, location.coordinate.longitude);
    
    //停止定位
    [_locationManager stopUpdatingLocation];
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    
    
}

#pragma mark - MKMapViewDelegate
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[GRXAnnotation class]]) {
        static NSString *key1 = @"Annotation";
        MKAnnotationView *annotationView =(MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key1];
        }
        annotationView.selected = NO;
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"car"];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [rightButton addTarget:self action:@selector(clickToNav) forControlEvents:UIControlEventTouchUpInside];
        rightButton.backgroundColor = [UIColor blueColor];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightButton setTitle:@"导航" forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        
        return annotationView;
    }else{
        
        return nil;
    }
}

//气泡按钮点击事件处理
- (void)clickToNav{
    
    //获取当前位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    NSLog(@"%@",currentLocation.name);
    //目的地位置
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinateEnd addressDictionary:nil];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    toLocation.name = @"留香园销售中心";
//    NSString *myName = []
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation,toLocation, nil];
    NSDictionary *options = @{
                          MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES
                              };
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
    NSLog(@"点击导航");
}

//设置大头针的气泡默认展示
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
    if ([views[0] isKindOfClass:[MKAnnotationView class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *)views[0];
        [self.mapView selectAnnotation:annotationView.annotation animated:YES];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
