//
//  AppTableViewCell.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "AppTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"
#import "KillAllDefine.h"
#import "iStarsView.h"
@implementation AppTableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UILabel *_middleLabel;
    UILabel *_priceLabel;
    
    UILabel *_shareLabel;
    iStarsView *_starsView;
    UILabel *_lineLabel;
    

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customViews];
    }
    return self;
}
- (void)customViews
{
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius = 10.0;
    //把超过父视图的那一部分切掉
    _iconImageView.layer.masksToBounds = YES;
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _middleLabel = [UILabel new];
    _middleLabel.textColor = [UIColor lightGrayColor];
    _middleLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel = [UILabel new];
    _priceLabel.textColor = [UIColor lightGrayColor];
    
    _shareLabel = [UILabel new];
    _shareLabel.textColor = [UIColor lightGrayColor];
    _shareLabel.font = [UIFont systemFontOfSize:13];
    
    _starsView = [iStarsView new];
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor = [UIColor blackColor];
    
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_middleLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_shareLabel];
    [self.contentView addSubview:_starsView];
    [self.contentView addSubview:_lineLabel];
}
//frame有改变就会调用layout
- (void)layoutSubviews
{
    [super layoutSubviews ];
    
    CGFloat leftPadding = 14;
    CGFloat topPadding = 10;
    CGFloat padding = 10.0;
    _iconImageView.frame = CGRectMake(leftPadding, topPadding, 60, 60);
    _titleLabel.frame = CGRectMake(maxX(_iconImageView)+padding,topPadding,width(self.contentView)-maxX(_iconImageView)-2*padding,20);
    _priceLabel.frame = CGRectMake(width(self.contentView)-40-padding, maxY(_titleLabel)+padding, 40, 20);
   _lineLabel.frame = CGRectMake(0, 0, width(_priceLabel), 1);
    //[self layoutIfNeeded];
    _lineLabel.center = _priceLabel.center;
    
    
    _middleLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+padding/2, width(self.contentView)-minX(_titleLabel)-width(_priceLabel)-padding, 13);
    _shareLabel.frame = CGRectMake(leftPadding, maxY(_iconImageView)+padding, width(self.contentView)-2*padding, 20);
    _starsView.frame = CGRectMake(minX(_titleLabel), maxY(_middleLabel)+padding/2, 65, 23);
}
- (void)setModel:(AppModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    _titleLabel.text = model.name;
    _priceLabel.text =[NSString stringWithFormat:@"￥%@", model.lastPrice];
    
    
    if ([model.priceTrend isEqualToString:kLimitType]) {
        //根据一个字符切割字符串
        NSArray *strings = [model.expireDatetime componentsSeparatedByString:@" "];
        if (strings.count == 2) {
             _middleLabel.text = [NSString stringWithFormat:@"剩余时间:%@",strings[1]];
        }
        _lineLabel.hidden = NO;
       
        
    }
    else if([model.priceTrend isEqualToString:kReduceType])
    {
    _middleLabel.text = [NSString stringWithFormat:@"现价:￥%@",model.currentPrice];
    _lineLabel.hidden = NO;
    }
    else if ([model.priceTrend isEqualToString:kFreeType]){
         _middleLabel.text = [NSString stringWithFormat:@"评分:%@",model.starCurrent];
        _lineLabel.hidden = YES;

    }
    else if ([model.priceTrend isEqualToString:kHotType]){
        _middleLabel.text = [NSString stringWithFormat:@"评分:%@",model.starCurrent];
        _lineLabel.hidden = YES;
    }
    _shareLabel.text = [NSString stringWithFormat:@"分享: %@ 收藏: %@ 下载: %@",model.shares,model.favorites,model.downloads];
    [_starsView setLevel:[model.starCurrent doubleValue]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
