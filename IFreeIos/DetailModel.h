//
//  DetailModel.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/11.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol PhotoModel
@end

@interface PhotoModel : JSONModel
@property (nonatomic, copy) NSString *smallUrl;
@property (nonatomic, copy) NSString *originalUrl;
@end

@interface DetailModel : JSONModel
@property (nonatomic, copy) NSString *applicationId;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *currentVersion;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *lastPrice;
@property (nonatomic, copy) NSString *priceTrend;
@property (nonatomic, copy) NSString *expireDatetime;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *description_long;
@property (nonatomic, copy) NSString *systemRequirements;
@property (nonatomic, copy) NSString *sellerId;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *itunesUrl;
@property (nonatomic, copy) NSString *downloads;
@property (nonatomic, copy) NSString *starCurrent;
@property (nonatomic, copy) NSString *starOverall;
@property (nonatomic, copy) NSString *ratingOverall;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, copy) NSString *updateDate;
@property (nonatomic, copy) NSString *appurl;
@property (nonatomic, copy) NSString<Optional> *newversion;
@property (nonatomic, strong) NSMutableArray<PhotoModel> *photos;
@end
