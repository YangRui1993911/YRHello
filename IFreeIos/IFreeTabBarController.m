//
//  IFreeTabBarController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "IFreeTabBarController.h"
#import "IFreeAppListViewController.h"
#import "KillAllDefine.h"
#import "UIView+Common.h"
@interface IFreeTabBarController ()

@end

@implementation IFreeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
      [self createSplashView];
}
- (void)createViewControllers
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Controllers" ofType:@"plist"];
    NSArray *vcArrays = [[NSArray alloc]initWithContentsOfFile:plistPath];
    NSArray *urlArray = @[kLimitUrl,kReduceUrl,kFreeUrl,kSubjectUrl,kHotUrl];
    NSArray *catagoryArray = @[kLimitType,kReduceType,kFreeType,kSubjectType,kHotType];
    //创建存放控制器的数组
    NSMutableArray *controllers = [NSMutableArray new];
   
    
    int i = 0;
    
    for (NSDictionary *dict in vcArrays) {
        Class class = NSClassFromString(dict[@"className"]);
        IFreeAppListViewController *controller = [[class alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:controller];
        controller.tabBarItem.image =[UIImage imageNamed: dict[@"iconName"]];
        controller.title = dict[@"title"];
        controller.requestURL = urlArray[i];
        controller.categoryType = catagoryArray[i++];
        [controllers addObject:nc];
        
    }
    self.viewControllers = controllers;

//    AppDelegate *app = [[UIApplication sharedApplication]delegate];
//    app.window.rootViewController =
  
}
- (void)createSplashView
{
    //C语言方法获取宽和高
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
    
    //arc4random_uniform(7)从1到6
        //大图必须这样创建
    NSString *splashPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"Defaultretein%d@2x",arc4random_uniform(7)+1] ofType:@"png"];
    imageView.image = [[UIImage alloc]initWithContentsOfFile:splashPath];
    
    [self.view addSubview:imageView];
    [UIView animateWithDuration:5 animations:^{
        //让透明度变成0
        imageView.alpha = 0.0;
    }completion:^(BOOL finished) {
        //动画结束让图片从父视图移除
        [imageView removeFromSuperview];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
