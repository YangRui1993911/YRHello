//
//  SearchViewController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //搜索到那一界面时隐藏搜索条
    _appTableView.tableHeaderView = nil;
}
//重写父类方法
- (void)prepareToLoadData:(BOOL)isMore
{
    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count%10 == 0) {
            page = _dataArray.count/10+1;
        }else{
            return;
        }
        
    }
    urlString = [NSString stringWithFormat:self.requestURL,page,_searchText];
    //调用父类方法
    [self loadDataFromNetWithURL:urlString isMore:isMore];
}
//重写
- (void)addNavigationItemWithTitel:(NSString *)title aSelector:(SEL)aSelector isLeft:(BOOL)isLeft
{
    
    
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
