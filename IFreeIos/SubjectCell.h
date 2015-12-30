//
//  SubjectCell.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectModel.h"

typedef void(^ApplicationSelectorBlock)(NSInteger index);

@interface SubjectCell : UITableViewCell
@property (nonatomic,strong)SubjectModel *model;

@property (nonatomic,copy)ApplicationSelectorBlock applicationSelectionBlock;
@end
