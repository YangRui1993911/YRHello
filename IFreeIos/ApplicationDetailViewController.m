//
//  ApplicationDetailViewController.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/11.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "ApplicationDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "KillAllDefine.h"
#import "DetailModel.h"
#import "AppDetailView.h"
#import "UIView+Common.h"
#import "DBManager.h"
#import <UMengSocial/UMSocial.h>
//邮件分享
#import <MessageUI/MessageUI.h>
@interface ApplicationDetailViewController ()<DetailButtonClickDelegate,MFMailComposeViewControllerDelegate>
{
    UIScrollView *_scrollView;
    AppDetailView *_detailView;
}
@end

@implementation ApplicationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用详情";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createScrollView];
    [self loadDataFromNet];
}
- (void)loadDataFromNet{
    NSString *url = [NSString stringWithFormat:kDetailUrl,_applicationID];
    NSLog(@"(%@)",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        DetailModel *model = [[DetailModel alloc] initWithData:responseObject error:nil];
        _detailView.model = model;
        [self resetScrollViewFrame];
        
        [self refreshDetailUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}
//刷新UI
- (void)refreshDetailUI
{
    DetailModel *model = _detailView.model;
    BOOL isExistRecord = [[DBManager sharedManager]isExistAppForAppId:_detailView.model.applicationId recordType:_detailView.model.categoryName];
    [_detailView setFavouriteButton:isExistRecord];
}
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //取消延迟响应
    _scrollView.delaysContentTouches = NO;
    [self.view addSubview:_scrollView];
    
    _detailView = [[AppDetailView alloc]initWithFrame:CGRectMake(10, 10, width(_scrollView)-20, 0)];
    _detailView.delegate = self;
    [_scrollView addSubview:_detailView];
    
    
}
- (void)resetScrollViewFrame
{
    _detailView.frame = CGRectMake(10, 10, width(_scrollView)-20, _detailView.viewHeight);
    _scrollView.contentSize = CGSizeMake(width(self.view), _detailView.viewHeight);
}

- (void)createActionSheet
{

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"分享" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"566a8c11e0f55a839300243b"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"account_candou"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                           delegate:nil];
        

    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"邮件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailController =[[MFMailComposeViewController alloc]init];
            //指定发送给谁
           [ mailController setToRecipients:@[@"1517@abc.com",@"10086@sb.com"]];
            //抄送给谁
            [mailController setCcRecipients:@[@"me@iluckly.com"]];
            
            //设置主题
            [mailController setSubject:@"这个APP真棒，美女有很多"];
            //设置内容
            [mailController setMessageBody:[NSString stringWithFormat:@"我们的应用妹子比较多，快来下载吧!下载地址:%@",_detailView.model.itunesUrl ] isHTML:NO];
            //添加附件
            [mailController addAttachmentData:UIImagePNGRepresentation([UIImage imageNamed:@"account_candou" ]) mimeType:@"image/png" fileName:@"icon.png"];
            mailController.mailComposeDelegate = self;
            [self presentViewController:mailController animated:YES completion:^{
                
            }];
        }
        
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [controller addAction:action1];
    [controller addAction:action2];
    [controller addAction:action3];
    //模态弹出
    [self presentViewController:controller animated:YES completion:^{
        NSLog(@"视图弹出完毕");
    }];

}

//邮件代理方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"邮件取消发送");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"保存邮件");
        break;
        case MFMailComposeResultFailed:
            NSLog(@"邮件发送失败");
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];

}
- (void)buttonClick:(AppDetailView *)detailView clickButtonType:(AppDetailButtonType )clickButtonType
{
   NSLog(@"%lu",clickButtonType);
    switch (clickButtonType) {
        case AppDetailButtonShare:{
            [self createActionSheet];
        
        }
            NSLog(@"分享中");
            break;
        case AppDetailButtonFavorite:{
            //判断存在这条记录（从数据库中查询）
            BOOL isExistRecord = [[DBManager sharedManager]isExistAppForAppId:_detailView.model.applicationId recordType:_detailView.model.categoryName];
            //如果用户收藏过了。再点击即取消收藏
            if (isExistRecord) {
                //如果收藏则删除状态
            [[DBManager sharedManager]deleteModelForAppId:_detailView.model.applicationId recordType:_detailView.model.categoryName];
            }else{
            
            [[DBManager sharedManager]insertModel:_detailView.model recordType:_detailView.model.categoryName];
            }
            //把已收藏传过去
            [detailView setFavouriteButton:! isExistRecord];
        
        
        }
            NSLog(@"收藏中");
            break;
        case AppDetailButtonDownLoad:
            NSLog(@"下载中");
            //打开APPStore对应的应用界面
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_detailView.model.itunesUrl]];
            break;
        default:
            break;
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
