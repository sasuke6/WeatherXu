//
//  SecondViewController.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/14.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "SecondViewController.h"
#import "piantView.h"
#import "MBProgressHUD+MJ.h"
#import "path.h"
#import "HandleView.h"


@interface SecondViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic ,strong) piantView *piantView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setToolbarHidden:NO animated:YES];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction:)];
        btn1.tag = 0;
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"撤销" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction:)];
    btn2.tag = 1;
     UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithTitle:@"橡皮擦" style:UIBarButtonItemStyleDone target:self action:@selector(eraserAction:)];
    btn3.tag = 2;
     UIBarButtonItem *btn4 = [[UIBarButtonItem alloc] initWithTitle:@"照片" style:UIBarButtonItemStyleDone target:self action:@selector(photoAction:)];
    btn4.tag = 3;
     UIBarButtonItem *btn5 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
    btn5.tag = 4;
    UIButton *space = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.5, 0)];
    UIBarButtonItem *spaceTime = [[UIBarButtonItem alloc] initWithCustomView:space];
    NSArray *arrayItem = [NSArray arrayWithObjects:btn1,spaceTime,btn2,spaceTime,btn3,spaceTime,btn4,spaceTime,btn5,nil];
    self.toolbarItems = arrayItem;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height * 0.15)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)];
    slider.minimumValue = 0;
    slider.maximumValue = 12;
    slider.value = 1;
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:slider];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.1,45, self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.05)];
    button1.backgroundColor = [UIColor blueColor];
    [button1 addTarget:self action:@selector(colorAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button1];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.4,45, self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.05)];
    button2.backgroundColor = [UIColor orangeColor];
    [button2 addTarget:self action:@selector(colorAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button2];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.7,45, self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.05)];
    button3.backgroundColor = [UIColor greenColor];
    [button3 addTarget:self action:@selector(colorAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button3];
    //custom view 对应于storyboard的修改
    self.piantView = [[piantView alloc] initWithFrame:CGRectMake(0, 64 + self.view.bounds.size.height * 0.15, self.view.bounds.size.width, self.view.bounds.size.height - 44 - 64)];
    self.piantView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.piantView];
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"涂鸦板";
    }
    return  self;
}


-(void)clearAction:(id)sender
{
    [self.piantView clearAction];
}

-(void)cancelAction:(id)sender
{
    [self.piantView cancelAction];
}

-(void)eraserAction:(UIBarButtonItem*)sender
{
    self.piantView.color = [UIColor whiteColor];
}

-(void)photoAction:(UIBarButtonItem*)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate =self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 创建处理图片的view
    HandleView *handleView = [[HandleView alloc] initWithFrame:self.piantView.frame];
    
    // 定义block:相当于自己的小弟，到时候直接吩咐做事
    handleView.block = ^(UIImage *image){
        
        self.piantView.image = image;
    };
    
    handleView.image = image;
    
    [self.view addSubview:handleView];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveAction:(UIBarButtonItem*)sender
{
    UIGraphicsBeginImageContextWithOptions(self.piantView.bounds.size, NO, 0); //开启上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.piantView.layer renderInContext:ctx];
    UIImage *imageTu = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imageTu, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}


-(void)sliderAction:(UISlider*)sender
{

    self.piantView.width = sender.value;
    
    
}

-(void)colorAction:(UIButton*)sender
{
    self.piantView.color = sender.backgroundColor;
}






@end
