//
//  IFreeAppListViewController.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "IFreeBaseViewController.h"

@class AFHTTPRequestOperationManager;
@interface IFreeAppListViewController : IFreeBaseViewController
{
    //网络强求类
    AFHTTPRequestOperationManager *_manager;

        UITableView *_appTableView;
    NSMutableArray *_dataArray;
    
}
//分类使用的ID
@property (nonatomic,copy)NSString *categoryID;
//每个页面对应的请求地址
@property (nonatomic, copy)NSString *requestURL;
//每个页面对应的类别
@property (nonatomic,copy)NSString *categoryType;
- (void)loadDataFromNetWithURL:(NSString *)urlString isMore:(BOOL)isMore;
@end
