//
//  FirstViewController.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/14.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"



@interface FirstViewController ()<CLLocationManagerDelegate>
@property (nonatomic , strong) UIImageView *backgroundView;
@property (nonatomic , strong) UILabel *address;
@property (nonatomic , strong) UILabel *temperature;
@property (nonatomic , strong) UILabel *load;
@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) CLLocationManager *mgr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"bg"];
//    self.backgroundView = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.backgroundView.image = image;
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundView];
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.7, self.view.bounds.size.width, self.view.bounds.size.height * 0.1)];
    self.address.textAlignment = NSTextAlignmentCenter;
    self.address.textColor = [UIColor whiteColor];
    self.address.font = [UIFont systemFontOfSize:25];
    self.temperature = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.3, self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.4)];
    self.temperature.textAlignment = NSTextAlignmentCenter;
    self.temperature.textColor = [UIColor whiteColor];
    self.temperature.font = [UIFont systemFontOfSize:60];
    self.load = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2, 46, self.view.bounds.size.width * 0.6, self.view.bounds.size.height * 0.1)];
    self.load.backgroundColor = [UIColor clearColor];
    self.load.textAlignment = NSTextAlignmentCenter;
    self.load.textColor = [UIColor whiteColor];
    [self.view addSubview:self.address];
    [self.view addSubview:self.temperature];
    [self.view addSubview:self.load];
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.55, self.view.bounds.size.height * 0.4, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4)];
    self.icon.image = [UIImage imageNamed:@"dunno"];
    [self.view addSubview:self.icon];

    
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"天气";
    
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([CLLocationManager locationServicesEnabled]) {
//        CLLocationManager *mgr = [[CLLocationManager alloc] init];
        self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
        self.mgr.distanceFilter = 1000;
        self.mgr.delegate = self;
//        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
            [self.mgr requestAlwaysAuthorization];
            NSLog(@"aaaaa");
        }else{
      
            [self.mgr startUpdatingLocation];
        }
    }
    else
    {
        if (self.load.text == nil) {
            self.load.text = @"位置信息不可用";
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待授权");
        
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"授权成功");
        [self.mgr startUpdatingLocation];
        NSLog(@"继续运行");
        
    }else
    {
        self.load.text = @"授权失败";
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"hahaha");
    CLLocation *location = [locations lastObject];
    NSNumber *lat = @(location.coordinate.latitude);
    NSNumber *lon = @(location.coordinate.longitude);
    NSLog(@"wawawa");
    NSString *urlstr = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&cnt=0",lat,lon];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSError
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    self.address.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    NSString *country = [NSString stringWithFormat:@"%@",dict[@"sys"][@"country"]];
    NSString *US = [NSString stringWithFormat:@"US"];
    NSString *temp = [[NSString alloc] init];
    temp = [NSString stringWithFormat:@"%@",dict[@"main"][@"temp"]];
    int temps = [temp intValue];  //字符串转数据类型
    if (country == US ) {
        
        temps = (temps - 273.15)*1.8 + 32;
    }
    else
    {
        temps = temps - 273.15;
    }
    self.temperature.text = [NSString stringWithFormat:@"%d°C",temps];
    NSArray *array = dict[@"weather"];
    int arrayM = [array[0][@"id"] intValue];
    if (arrayM < 300) {
        self.icon.image = [UIImage imageNamed:@"tstorm1"];
    }
    else if (arrayM < 500){
        self.icon.image = [UIImage imageNamed:@"light_rain"];
    }
    else if (arrayM < 600){
        self.icon.image = [UIImage imageNamed:@"shower3"];
    }
    else if (arrayM < 700){
        self.icon.image = [UIImage imageNamed:@"snow4"];
    }
    else if (arrayM < 771){
        self.icon.image = [UIImage imageNamed:@"fog"];
    }
    else if (arrayM == 800 ){
        self.icon.image = [UIImage imageNamed:@"sunny"];
    }
    else if (arrayM < 804){
        self.icon.image = [UIImage imageNamed:@"cloudy2"];
    }
    else if (arrayM == 804){
        self.icon.image = [UIImage imageNamed:@"overcast"];
    }
    else if ((arrayM >= 900 && arrayM < 903)|| (arrayM > 904 && arrayM < 1000)){
        self.icon.image = [UIImage imageNamed:@"tstorm3"];
    }
    else if (arrayM == 903){
        self.icon.image = [UIImage imageNamed:@"snow5"];
    }
    else if (arrayM == 904){
        self.icon.image = [UIImage imageNamed:@"sunny"];
    }
    else{
        self.icon.image = [UIImage imageNamed:@"dunno"];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.load.text == nil) {
        self.load.text = @"无法加载";
        self.load.textAlignment = NSTextAlignmentCenter;
        NSLog(@"%@",error);
    }
}

-(CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;

}







@end
