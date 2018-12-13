//
//  MeTableController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "MeTableController.h"
#import "meMessageItem.h"
#import "meMessageCell.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Radius.h"
#import "GRXChangeName.h"
#define kGRXColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

/*问题1：用户通过拍照和相册中选择图片之后，如何及时修改cell中的头像？
 *思考路径：1.由于采用了MVC设计模式，model和View已经数据隔离，想要在用户选择要修改的图片完成后，让cell中的图片及时更新，只能通过更新model数据来进而达到更新cell显示的目的。
 *问题2：如何及时更新Model数据？
 思考路径：1.由于头像会随着用户的修改而更新，所以用户头像需要在用户打开该界面的时候由控制器中的willApper方法中向服务器发送网络请求，并返回头像的url，进而设置头像（注意缓存，先查找内存，再设置网络请求）
 解决方法：通过以上思考路径，用户在选择完要修改的图片之后，需要将该图片发送至服务器保存。其他需要更新头像的地方，需在该界面即将显示的时候重新向服务器发送网络请求（使用viewWillApper方法），获取头像的url，然后将url赋值给model，在cell类中，使用SDWebImage库完成对cell中UIImageView图片的设置。
 问题3：图片更新缓慢，界面返回时还能看到原图片
 解决办法：图片选择完成之后，需要在界面显示出来之前就把头像更新掉，所以需要在meTableView和MineViewController的viewWillApper方法中重新获取缓存图片的位置，并传递给需要修改头像的cell的item，并在此方法内调用[tableView ReloadData]方法，从而在用户选择图片返回界面的时候，能够调用cell中的layoutSubViews方法，在这个方法中，通过item可以拿到缓存中头像的路径（filePath），然后通过路径（filePath）获取到用户已经选择的头像，并完成对icon.image的头像更新设置
 *
 */
@interface MeTableController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property(nonatomic,strong) UIImagePickerController *imagePicker; //声明全局的UIImagePickerController
@property (weak, nonatomic) UIImage *image;
@property (weak, nonatomic) meMessageCell *cell;

@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic)meMessageItem  *icon;
@property (strong, nonatomic)meMessageItem  *nameItem;
@end

static NSString *cellID = @"cell";
@implementation MeTableController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //查看缓存中是否有图片
    //    //将选择的图片显示出来
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
    if (filePath) {
        self.icon.iconName = filePath;
    }else{
        self.icon.iconName = nil;
    }
    

    
    [self.tableView reloadData];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableView
    [self setUpTableView];
    
    [self.tableView registerClass:[meMessageCell class] forCellReuseIdentifier:cellID];

    //设置cell内容
    [self setUpCellContent];
    
    //设置底部视图
    [self setUpFooterView];
//    self.view.backgroundColor = [UIColor blueColor];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //接受next控制器传过来的昵称并修改
        [self changeName];
    [self changeName];
}

- (void)changeName{
    if (self.nameItem.detail) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(huoqudata:) name:@"data" object:nil];
    }else{
        return;
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//获取传递过来的数据
- (void)huoqudata:(NSNotification *)notification{
    
//    NSLog(@"str===%@",notification.object[@"object"]);
    self.nameItem.detail = notification.object[@"object"];
}


-(void)setUpFooterView{

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0,self.view.width,50);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出当前账户" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, view.width, 50);
    btn.center = view.center;
    [btn setTitleColor:[UIColor colorWithRed:98 / 255.0 green:162 / 255.0  blue:226 / 255.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [view addSubview:btn];
    
    self.tableView.tableFooterView = view;

}
- (void)btnClick{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出当前账号？" delegate:self cancelButtonTitle:@"取消 " otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)setUpTableView{
    self.title = @"我的资料";
    self.tableView.backgroundColor = [UIColor lightGrayColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //调整组与组之间的距离
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 10;
//    self.tableView.select
    
//    设置ttableView的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    self.tableView.bounces = NO;
    
    
}

    - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

        return 8;
    }

    - (void)setUpCellContent{
        __weak __typeof(self) weakSelf = self;
        //更新头像
        meMessageItem *icon = [meMessageItem modelWithTitle:@"头像" pictureName:@"picture"  type:meMessageCellTypeIcon];
        self.icon = icon;
        icon.iconName = @"https://img5.duitang.com/uploads/item/201412/12/20141212014311_jwiC8.jpeg";
        icon.action = ^(){
            [weakSelf setUpImagePicker];
        };
        
        //更新昵称
        meMessageItem *nameItem = [meMessageItem modelWithTitle:@"昵称" pictureName:@"picture"  type:meMessageCellTypeLabel];
        nameItem.action = ^(){
            GRXChangeName *nameVC = [[GRXChangeName alloc] init];
            [weakSelf.navigationController pushViewController:nameVC animated:YES];
        };
//        NSLog(@"setUpCellContent=%@",self.name);
        nameItem.detail = @"王者荣耀";
        self.nameItem = nameItem;
//        nameItem.detail = self.name;
        
        //更新电话号码
        meMessageItem *tell = [meMessageItem modelWithTitle:@"联系电话" pictureName:@"picture"  type:meMessageCellTypeLabel];
        tell.action = ^(){
            
            NSLog(@"修改电话");
        };
        tell.detail = @"152****0629";
        meMessageItem *change = [meMessageItem modelWithTitle:@"修改登录密码"  pictureName:@"picture"  type:meMessageCellTypeArrow];
        change.action = ^(){
            
            NSLog(@"修改登录密码");
        };
        
        _dataArray = @[@[icon,nameItem,tell,change]];
    }
- (void)click{
    NSLog(@"发纷纷图片");
}

    
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //取出每一组的数据，保存在一个小数组中
    NSArray *arry = _dataArray[section];
    return arry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    meMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    meMessageItem *item = _dataArray[indexPath.section][indexPath.row];
    cell.item = item;
    
//    [tableView reloadData];
    return cell;
    
}

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
        meMessageItem *item = _dataArray[indexPath.section][indexPath.row];
        
        //判断block是否为空，如果不为空就执行block后面的代码
        if (item.action) {
            item.action();
        }
    }
    

    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        
        return 10;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForfooterInSection:(NSInteger)section{
        
        return 10;
    }


-(void)setUpImagePicker{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"拍照",@"从相册选择",nil];
    
    
    //显示消息框
    [sheet showInView:self.tableView];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //判断系统是否支持相机
        if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //设置类型
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
            pickVC.delegate = self;
            pickVC.allowsEditing = YES;
            pickVC.sourceType = sourceType;
            
            //设置是否显示相机控制按钮，n默认为yes
            pickVC.showsCameraControls = YES;
            
            
            //选择前置摄像头或者后置摄像头
            pickVC.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [self presentViewController:pickVC animated:YES completion:^{
                NSLog(@"请拍照");
            }];
        }else{
            NSLog(@"该设备w没有相机");
        }
    }else if(buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
            pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickImage.delegate = self;
            //设置允许编辑
            pickImage.allowsEditing = YES;
            
            [self presentViewController:pickImage animated:YES completion:^{
                NSLog(@"选择照片");
            }];
        }else{
            
            NSLog(@"该设备没有相册");
        }
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    //获取j裁剪后的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];

    //将照片存到媒体库
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

//        //将照片存储到沙盒
    [self saveImage:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        
      
        
    }];
    
}

#pragma mark - 照片存到本地后的回调
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
//        NSLog(@"存储成功");
        
    } else {
//        NSLog(@"存储失败：%@", error);
    }
}
#pragma mark - 保存图片
- (void) saveImage:(UIImage *)currentImage {
    //设置照片的品质
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
//    NSLog(@"%@",NSHomeDirectory());
    // 获取沙盒目录
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
    // 将图片写入文件
    [imageData writeToFile:filePath atomically:NO];
//    NSLog(@"filePath = %@",filePath);
}


#pragma mark - 取消操作时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"取消操作");
    }];
    
}


@end
