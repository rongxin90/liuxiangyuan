//
//  QRCodeViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/12/20.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import "UIView+Frame.h"

@interface QRCodeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,AVCaptureMetadataOutputObjectsDelegate,CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *boderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *waringLabel;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UIButton *gerenQRCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;
/**记录预览图层*/
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

/**保存图层layer*/
@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpAnimate];
    
    self.bottomConst.constant = 200;
    [self.view layoutIfNeeded];
    //设置相册按钮
    [self setAlumButtonItem];
    
    [self scanTheQRCode];
}

#pragma mark ---设置相册按钮
- (void)setAlumButtonItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(alum)];
}

- (void)alum{
    //判断照片源是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    //创建选择照片的控制器
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    //设置照片源
    pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置代理
    pickVC.delegate = self;
    
    [self presentViewController:pickVC animated:YES completion:nil];
}

#pragma mark ---UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //1.拿到二维码图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image == nil) {
        NSLog(@"没有获得图片");
        return ;
    }
    
    //2.识别图片中的二维码
    [self getQRCodeInfo:image];
    
    //3.退出控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---识别照片中的二维码
- (void)getQRCodeInfo:(UIImage *)image{
    //1.创建扫描器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    if (detector == nil) {
        NSLog(@"创建失败");
        return;
    }
    
    //2.扫描结果
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    if (ciImage == nil) {
        NSLog(@"转换失败");
        return;
    }
    
    
    //3.保存扫描结果
    NSArray *features = [detector featuresInImage:ciImage];
    
    //4.遍历扫描结果
    for (CIQRCodeFeature *feature in features) {
        
        if (feature == nil) {
            continue;
        }
        
//        self.promptLabel.alpha = 0;
        
        self.resultTextView.text = feature.messageString;
    }
    
}

#pragma mark ---识别扫描的二维码
- (void)scanTheQRCode{
    
    //1.创建捕捉会话
    
    AVCaptureSession *capSession = [[AVCaptureSession alloc] init];
    //高质量采集率
    
    //2.添加输入(摄像头)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    if (input == nil) {
        [SVProgressHUD showErrorWithStatus:@"找不到可用的输入设备"];
        return;
    }
    
    
    [capSession addInput:input];
    
    //3.添加输出(metadata方式输出)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //3、设置这次扫描的数据类型
    output.metadataObjectTypes = output.availableMetadataObjectTypes;
    
    
    if (output) {
        [capSession addOutput:output];
    
    }
    
    output.metadataObjectTypes = output.availableMetadataObjectTypes;
    CGFloat x = self.contentView.y / self.view.height;
    CGFloat y = self.contentView.x / self.view.width;
    CGFloat width = self.boderImageView.height / self.view.height;
    CGFloat height = self.boderImageView.width / self.view.width;



    output.rectOfInterest = self.view.bounds;
    
    //4.添加预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:capSession];
    previewLayer.videoGravity =AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    //创建周围的遮罩层
    CALayer *maskLayer = [[CALayer alloc]init];
    
    maskLayer.frame = self.view.bounds;
    
    //此时设置的颜色就是中间扫描区域最终的颜色
    maskLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    
    maskLayer.delegate = self;
    
    [self.view.layer insertSublayer:maskLayer above:previewLayer];

    [maskLayer setNeedsDisplay];
    
    //5.开始扫描
    [capSession startRunning];
}

#pragma mark ---AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    //1.获取扫描结果
    AVMetadataMachineReadableCodeObject *object = metadataObjects.lastObject;
    if (object == nil) {
        [SVProgressHUD showErrorWithStatus:@"扫描无结果"];
        return;
    }
    
    
    
    NSLog(@"%@",object);
    
    //2.获取扫描结果并显示出来
    self.resultTextView.text = object.stringValue;
    
    //3.使用预览图层,将二维码图片的corners的坐标转换成坐标系中的点
    AVMetadataMachineReadableCodeObject *newObject = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:object];
    if (newObject == nil) {
        NSLog(@"转换失败");
        return;
    }
    //4.画边框
    [self drawBorder:newObject];
    
//    if (self.resultTextView.text.length != 0) {
//        //移除前一个画出的边框
//        [self.shapeLayer removeFromSuperlayer];
//    }
    
//    //4.画边框
//    [self drawBorder:newObject];
}

- (void)drawBorder:(AVMetadataMachineReadableCodeObject *)object{
    //移除前一个画出的边框
    [self.shapeLayer removeFromSuperlayer];
    
    //1.创建CAShapLayer(形状类型:专门用于画图)
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    
    //2.设置layer属性
    shapLayer.strokeColor = [UIColor redColor].CGColor;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.lineWidth = 2.0;
    
    //3.创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //4.给贝塞尔曲线添加对应的点
    for (int i = 0; i < object.corners.count; i++) {
        
        //4.1 获取每一个点对应的字典
        NSDictionary *dict = object.corners[i] ;
        
        CFDictionaryRef ref = (__bridge   CFDictionaryRef)dict;
        
        CGPoint point = CGPointZero;
        CGPointMakeWithDictionaryRepresentation(ref, &point);
        
        //4.2 如果是第一个点,移动到第一个点
        if (i == 0) {
            [path moveToPoint:point];
        }
        
        //4.3 如果是其他点,则添加该点
        [path addLineToPoint:point];
    }
    
    //5.关闭路径
    [path closePath];
    
    //6.给shareLayper设置路径
    shapLayer.path = path.CGPath;
    
    //7.将layer添加到其他图层中
    [self.previewLayer addSublayer:shapLayer];
    
    //8.保存layer
    self.shapeLayer = shapLayer;
    
}

//页面显示之后添加动画,在viewDidLoad中添加动画,只能看到结果,看不到动画过程
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.backImageView.layer removeAllAnimations];
    
    //设置扫描动画
    [self setAnimationForQRCode];
}


- (void)setAnimationForQRCode{
    
    [UIView animateWithDuration:2.5 animations:^{
        
        [UIView setAnimationRepeatCount:MAXFLOAT];
        
        self.bottomConst.constant = -200;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)gerenQRCodeBtnClick:(id)sender {
}



@end
