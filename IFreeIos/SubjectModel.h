//
//  SubjectModel.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ApplicationsModel

@end

@interface ApplicationsModel :JSONModel

@property (nonatomic, copy) NSString *applicationId;
@property (nonatomic, copy) NSString *downloads;
@property (nonatomic, copy) NSString <Optional>*iconUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ratingOverall;
@property (nonatomic, copy) NSString *starOverall;

@end


@interface SubjectModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *desc_img;
@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSArray<ApplicationsModel> *applications;
@end