//
//  CategoryModel.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CategoryModel;


@protocol CategoryModel

@end

@interface FLModel : JSONModel
@property (nonatomic,strong)NSMutableArray<CategoryModel> *models;
@end



@interface CategoryModel : JSONModel
@property (nonatomic, copy) NSString *categoryCname;
@property (nonatomic, copy) NSString *categoryCount;
@property (nonatomic, copy) NSString *up;
@property (nonatomic, copy) NSString *down;
@property (nonatomic, copy) NSString *same;
@property (nonatomic, copy) NSString *limited;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString <Optional>*picUrl;
@property (nonatomic, copy) NSString *free;
@property (nonatomic, copy) NSString *categoryName;
@end
