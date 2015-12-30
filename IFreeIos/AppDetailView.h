//
//  AppDetailView.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/11.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

typedef enum : NSUInteger {
    AppDetailButtonShare = 0,
    AppDetailButtonFavorite,
    AppDetailButtonDownLoad,
} AppDetailButtonType;

@class AppDetailView;
@protocol DetailButtonClickDelegate <NSObject>
- (void)buttonClick:(AppDetailView *)detailView clickButtonType:(AppDetailButtonType )clickButtonType;
@end


@interface AppDetailView : UIView

@property (nonatomic,weak)id<DetailButtonClickDelegate>delegate;

//数据源
@property (nonatomic,strong)DetailModel *model;
//视图的高
@property (nonatomic,assign,readonly)CGFloat viewHeight;
//设置收藏按钮的Title
// isFavourite是否收藏
- (void)setFavouriteButton:(BOOL)isFavourite;
@end
