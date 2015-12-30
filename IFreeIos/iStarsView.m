//
//  iStarsView.m
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "iStarsView.h"

@implementation iStarsView{
    UIImageView *_foregroundView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customViews];
    }
    return self;
}
- (void)customViews
{
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 23)];
    //白色的五角星
    backgroundView.image = [UIImage imageNamed:@"StarsBackground"];
    [self addSubview:backgroundView];
    _foregroundView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _foregroundView.contentMode = UIViewContentModeBottomLeft;
    _foregroundView.clipsToBounds = YES;
    _foregroundView.image = [UIImage imageNamed:@"StarsForeground"];
    [self addSubview:_foregroundView];
}
- (void)setLevel:(double)level
{
    _foregroundView.frame = CGRectMake(0, 0, 65*(level/5.00), 23);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
