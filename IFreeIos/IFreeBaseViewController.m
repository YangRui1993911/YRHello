//
//  IFreeBaseViewController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "IFreeBaseViewController.h"

@interface IFreeBaseViewController ()

@end

@implementation IFreeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationTitleWithTitle:self.title];
    
}
- (void)addNavgationTitleWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor =  [UIColor colorWithRed:30/255.f green:160/255.f blue:230/255.f alpha:1];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}
- (void)addNavigationItemWithTitel:(NSString *)title aSelector:(SEL)aSelector isLeft:(BOOL)isLeft
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    //判断有没有方法。
    if (aSelector) {
        if ([self respondsToSelector:aSelector]) {
            [button addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
        }
    }
    UIBarButtonItem *batButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = batButtonItem;
    }else{
        self.navigationItem.rightBarButtonItem = batButtonItem;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
