//
//  UIImageView+GifView.h
//  TVLive
//  UIImageView智能加载模式，兼容支持gif
//  Created by shiyang on 2020/12/15.
//  Copyright © 2020 dianshijia_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
//#import "SVGAPlayer.h"
//#import "SVGA.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView(GifView)

//智能模式，加载自动判断gif或普通url
- (void)set_url_smartModel:(NSString * _Nullable)gifUrl withPlace:(UIImage * _Nullable)placeholderImage imgView:(UIImageView *)imgView completed:(void(^)(UIImage * _Nullable image,UIView * _Nullable view))completedBlock;

//普通模式，加载普通url
-(void)set_url_normalModel:(NSString*)url withPlace:(UIImage*)placeholderImage completed:(void(^)(UIImage * _Nullable image))completedBlock;

//加载本地gif
-(void)set_LocalGif:(NSString *)name;


/**
 *加载svga 动画
 *
 */
//-(void)set_url_svga:(NSString*)url completed:(void(^)(UIImage * _Nullable image))completedBlock;

/*
 @param urlStr 图片地址
 @param imgv 显示的UIImageView
 */
//-(UIImage *)svgImageUrlStr:(NSString *)urlStr imgv:(UIImageView *)imgv;

/*
 @param name 图片名
 @param imgv 显示的UIImageView
 */
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv;

/*
  @param name 图片名
  @param imgv 显示的UIImageView
 @param hexColor 16进制色值
 */
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv hexColor:(NSString *)hexColor;

/*
  @param name 图片名
  @param imgv 显示的UIImageView
  @param objColor 色值对象
 */
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv objColor:(UIColor *)objColor;


//从父视图中移除
- (void)remove;
@end

NS_ASSUME_NONNULL_END
