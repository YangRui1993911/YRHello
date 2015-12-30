//
//  SubjectViewController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectModel.h"
#import "SubjectCell.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "ApplicationDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appTableView.tableHeaderView = nil;
    _dataArray = [[NSMutableArray alloc]init];
    NSLog(@"%@",self.requestURL);
}
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
    urlString = [NSString stringWithFormat:self.requestURL,page];
    [self loadDataFromNetWithURL:urlString isMore:isMore];
}
- (void)loadDataFromNetWithURL:(NSString *)urlString isMore:(BOOL)isMore
{
    //显示Loading提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //NSLog(@"%@",urlString);
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_appTableView reloadData];
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in array) {
            SubjectModel *model = [[SubjectModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        
        [_appTableView reloadData];
        
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏Loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"identifier";
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SubjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//设置选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
    }
    SubjectModel *model = _dataArray[indexPath.row];
    
    __weak typeof (self) weakSelf = self;
    cell.applicationSelectionBlock = ^(NSInteger index){
         ApplicationsModel *subModel = model.applications[index];
        ApplicationDetailViewController *applicationDetail = [ApplicationDetailViewController new];
    
       applicationDetail.title = @"应用详情";
        applicationDetail.hidesBottomBarWhenPushed = YES;
        applicationDetail.applicationID =subModel.applicationId;
        [self.navigationController pushViewController:applicationDetail animated:YES];
        
    };
  
    
    [cell setModel:model];
    //cell.textLabel.text = model.title;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}


//重写方法
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
