//
//  DetailModel.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/11.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "DetailModel.h"

@implementation PhotoModel

@end

@implementation DetailModel

+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"desc"}];
}

@end
