//
//  IFreeAppListViewController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "IFreeAppListViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "KillAllDefine.h"
#import "ApplicationModel.h"
#import "AppTableViewCell.h"
#import "UIView+Common.h"
#import "SearchViewController.h"
#import "NSString+Common.h"
#import "CategoryViewController.h"
#import "ApplicationDetailViewController.h"
#import "NSString+Common.h"

//缓存类
#import "JWCache.h"
//第三方Loading提示框
#import <MBProgressHUD/MBProgressHUD.h>
@interface IFreeAppListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CategoryDelegate>
{

 
   
    
}

@end

@implementation IFreeAppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _categoryID = 0;
    [self addNavigationItemWithTitel:@"分类" aSelector:@selector(categoryAction) isLeft:YES];
    [self addNavigationItemWithTitel:@"设置" aSelector:@selector(settingAction) isLeft:NO];
    [self createTableView];
    [self createSearchBar];
    [self initRequestManager];
}

- (void)initRequestManager
{

    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}
- (void)categoryAction
{
    NSLog(@"%s",__func__);
    CategoryViewController *categoryViewController = [CategoryViewController new];
    //第二种代理方法
    categoryViewController.delegate = self;
    //第一种block传值方法
//    categoryViewController.categoryBlock = ^(NSString *categoryID){
//        NSLog(@"哈哈哈。我拿到ID了");
//        _categoryID = categoryID;
//        [_appTableView.mj_header beginRefreshing];
//    };
    categoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryViewController animated:YES];
    
}
//代理方法
- (void)categoryViewDidSelect:(CategoryViewController *)categoryView categoryID:(NSString *)categoryID
{
    _categoryID = categoryID;
    [_appTableView.mj_header beginRefreshing];
}
- (void)settingAction
{
NSLog(@"%s",__func__);
}
- (void)createTableView
{
    if (_appTableView == nil) {
         _appTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _appTableView.dataSource = self;
        _appTableView.delegate = self;
        [self.view addSubview:_appTableView];
    }
    //去掉多余的线（下面全是尾视图）
    _appTableView.tableFooterView = [UIView new];
    //改变线的颜色
    _appTableView.separatorColor = [UIColor greenColor];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self prepareToLoadData:NO];
    }];
    _appTableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self prepareToLoadData:YES];
    }];
    _appTableView.mj_footer = footer;
    //第一次进来刷新
    [_appTableView.mj_header beginRefreshing];
    
    
}
- (void)createSearchBar
{
    UISearchBar *serachBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, width(_appTableView), 44.0)];
    serachBar.placeholder = @"60万款应用，搜搜看";
    serachBar.delegate = self;
    //放在头视图上
    _appTableView.tableHeaderView = serachBar;
    
    
}
#pragma mark-网络请求数据
//拼接URL（封装）
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
    if ([_categoryType isEqualToString:kLimitType]||[_categoryType isEqualToString:kReduceType]||[_categoryType isEqualToString:kFreeType]) {
      urlString = [NSString stringWithFormat:_requestURL,page,_categoryID];//0代表全部
    }else{
        urlString = [NSString stringWithFormat:_requestURL,page];
    }
    [self loadDataFromNetWithURL:urlString isMore:isMore];
}
- (void)loadDataFromNetWithURL:(NSString *)urlString isMore:(BOOL)isMore
{
    
    /**
     *  网络请求数据
     */
    //显示loading 提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //判断有没有缓存
    NSData *cacheData = [JWCache objectForKey:MD5Hash(urlString)];
    if (cacheData) {
        ApplicationModel *model = [[ApplicationModel alloc]initWithData:cacheData error:nil];
        if (isMore) {
            [_dataArray addObjectsFromArray:model.applications];
        }else{
            [_dataArray removeAllObjects];
            [_appTableView reloadData];
            _dataArray = model.applications;
        }
       
        [_appTableView reloadData];
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
        return;

    }
   
    
    //NSLog(@"%@",urlString);
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ApplicationModel *model = [[ApplicationModel alloc]initWithData:responseObject error:nil];
        //NSLog(@"%@",model);
        if (isMore) {
            [_dataArray addObjectsFromArray:model.applications];
        }else{
            [_dataArray removeAllObjects];
            [_appTableView reloadData];
            _dataArray = model.applications;
        }
       // NSLog(@"%ld",_dataArray.count);
        [_appTableView reloadData];
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
        
        
        //把数据进行缓存
        [JWCache setObject:responseObject forKey:MD5Hash(urlString)];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏Loading提示框
        [MBProgressHUD hideAllHUDsForView:self.view
                                 animated:YES];
        
        isMore?[_appTableView.mj_footer endRefreshing]:[_appTableView.mj_header endRefreshing];
    }];

}

#pragma mark-代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"identifier";
    AppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AppTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //设置选中风格
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置cell后面的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row%2 ) {
//        UIImageView *backgroundView = [[UIImageView alloc]init];
//        backgroundView.image = [UIImage imageNamed:@"cate_list_bg"];
       // cell.backgroundView = backgroundView;
        cell.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:239 / 255.0 alpha:1.0];
    }else{
    
//        UIImageView *backgroundView = [[UIImageView alloc]init];
//        backgroundView.image = [UIImage imageNamed:@"cata_list_bg2"];
//        cell.backgroundView = backgroundView;
        cell.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    
    }
    //[cell setModel:_dataArray[indexPath.row]];跟下面一样
    cell.model= _dataArray[indexPath.row];
   // cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",self.title,indexPath.row];
    return cell;
    
}
//跳入详情页面
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//   AppModel *model = _dataArray[indexPath.row];
//    ApplicationDetailViewController *application = [ApplicationDetailViewController new];
//    application.applicationID = model.applicationId;
//    application.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:application animated:YES];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppModel *model = _dataArray[indexPath.row];
    ApplicationDetailViewController *application = [[ApplicationDetailViewController alloc]init];
    application.applicationID = model.applicationId;
   application.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:application animated:YES];


}
#pragma mark-UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //设置取消的按钮
    [searchBar setShowsCancelButton:YES];

    //把取消按钮变成汉字
    for (UIView *view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal ];
        }
    }
    
    
    return YES;
}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    //取消第一响应
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//
//    [@"" isEqual:<#(id)#>]比较是不是同一个对象
//   @"" == @""比较地址
//    [@"" isEqualToString:<#(nonnull NSString *)#>]是不是同一个
//    [@"" isKindOfClass:<#(__unsafe_unretained Class)#>]是不是同一类
//    [@"" isMemberOfClass:<#(__unsafe_unretained Class)#>]//是不是他的子类
    if (searchBar.text.length>0) {
  
        SearchViewController *searchViewController = [[SearchViewController alloc]init];
        if ([_categoryType isEqualToString: kLimitType]) {
            searchViewController.requestURL = SEARCH_LIMIT_URL;
        }else if ([_categoryType isEqualToString:kReduceType]){
            searchViewController.requestURL = SEARCH_REDUCE_URL;
        }else if ([_categoryType isEqualToString:kFreeType]){
            searchViewController.requestURL = SEARCH_FREE_URL;
        }else if ([_categoryType isEqualToString:kHotType]){
            searchViewController.requestURL = SEARCH_HOT_URL;
        }
        //在地址遇到中文或者特殊字符的时候需要转码，服务端会有对应的解码
        searchViewController.searchText = URLEncodedString(searchBar.text);
        self.navigationController.hidesBottomBarWhenPushed = YES;
        //压入搜索的视图
        [self.navigationController pushViewController:searchViewController animated:YES];
    }
    [searchBar resignFirstResponder];
    
    searchBar.text = @"";
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
