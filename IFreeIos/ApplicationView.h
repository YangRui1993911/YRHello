//
//  ApplicationView.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectModel.h"
@interface ApplicationView : UIView
@property (nonatomic,strong)ApplicationsModel *model;
- (void)resetPostion;
@end
