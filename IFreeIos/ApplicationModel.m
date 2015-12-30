//
//  ApplicationModel.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "ApplicationModel.h"

@implementation AppModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"desc"}];
}
@end
@implementation ApplicationModel

@end
