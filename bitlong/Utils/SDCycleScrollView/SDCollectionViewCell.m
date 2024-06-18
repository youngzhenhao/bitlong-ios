//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UIImageView *_maskView;
    __weak UILabel *_titleLabel;
    __weak UIImageView * _bakImgView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupMaskView];
        [self setupTitleLabel];
    }
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    //    _titleLabel.backgroundColor = titleLabelBackgroundColor;//ui所需，屏蔽掉以前的color
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
    
   
    [self setCornerImage:imageView];
    
    [self.contentView addSubview:imageView];
}

//封面图-圆角
-(void)setCornerImage:(UIImageView*)img{
    img.layer.cornerRadius = 6;
    img.layer.masksToBounds = YES;
    img.backgroundColor=UIColor.clearColor;
}

- (void)setupMaskView{
    UIImageView *maskView = [[UIImageView alloc] init];
    _maskView = maskView;
    [self.contentView addSubview:_maskView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
    
    UIImageView * bakImgView = [[UIImageView alloc]init];
    _bakImgView = bakImgView;
    //_bakImgView.image = imagePic(@"ic_bannel_img");
    _bakImgView.backgroundColor=UIColor.clearColor;
    _bakImgView.hidden = YES;
    [self.contentView insertSubview:_bakImgView belowSubview:_titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = title;
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
    if (_bakImgView.hidden) {
        _bakImgView.hidden = NO;
    }
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment
{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.onlyDisplayText) {
        _bakImgView.frame = self.bounds;
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 15;
        CGFloat titleLabelY = self.sd_height - titleLabelH-10;
        _bakImgView.frame = CGRectMake(0, titleLabelY, titleLabelW, titleLabelH+10);
        _maskView.frame = CGRectMake(0, titleLabelY-30, titleLabelW, titleLabelH+10+30);
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
    [self setCornerImage:_imageView];
}


-(void)scrollNext{
    //NSLog(@"banner_play-5秒内播放失败--跳转到下一个 ");
    [self showCoverPic:YES];
    [self setCornerImage:_imageView];
}

-(void)showCoverPic:(BOOL)show{
    if (show) {
        _imageView.hidden=NO;
        [self.contentView bringSubviewToFront:_imageView];
        [self.contentView bringSubviewToFront:_titleLabel];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }else{
        _imageView.hidden=YES;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    }
}

- (void)removeNotifcation {
}

@end
