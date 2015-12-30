//
//  CategoryViewController.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "IFreeBaseViewController.h"

@class CategoryViewController;
@protocol  CategoryDelegate <NSObject>

- (void)categoryViewDidSelect:(CategoryViewController *)categoryView categoryID:(NSString * )categoryID;

@end
typedef void(^CategoryBlock)(NSString *categoryID);
@interface CategoryViewController : IFreeBaseViewController
@property (nonatomic,copy)CategoryBlock categoryBlock;
@property (nonatomic,weak)id<CategoryDelegate>delegate;
@end
