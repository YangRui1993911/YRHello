//
//  ApplicationView.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/10.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "ApplicationView.h"
#import "iStarsView.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>
@implementation ApplicationView{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    iStarsView *_istartView;
    UIImageView *_downLoadImageView;
    UILabel *_downsLabel;
    
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customViews];
    }
    return self;
}
- (void)customViews
{
    _iconImageView = [UIImageView new];
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _downLoadImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topic_Download"]];
    _downsLabel = [UILabel new];
    _istartView = [iStarsView new];
    
    [self addSubview:_iconImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_downLoadImageView];
    [self addSubview:_downsLabel];
    [self addSubview:_istartView];
    
}
- (void)setModel:(ApplicationsModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    _titleLabel.text = model.name;
    _downsLabel.text = model.downloads;
    [_istartView  setLevel:[model.starOverall doubleValue]];
    
    
    
    
}
- (void)resetPostion
{

    CGFloat leftPadding = 0;
    CGFloat topPadding = 0;
    CGFloat padding = 10;
    _iconImageView.frame = CGRectMake(leftPadding, topPadding, 40, 40);
    _titleLabel.frame = CGRectMake(maxX(_iconImageView)+padding, topPadding, width(self) - width(_iconImageView)-2*padding, 15);
    _istartView.frame = CGRectMake(maxX(_iconImageView)+padding, maxY(_titleLabel)+padding, 65, 23);
    _downLoadImageView.frame = CGRectMake(maxX(_istartView)+padding, (height(self)-6)/2, 5, 6);
    _downsLabel.frame = CGRectMake(maxX(_downLoadImageView)+padding/2, minY(_downLoadImageView)-3, width(self)-maxX(_downLoadImageView)+padding, 12);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
