//
//  UIImageView+GifView.m
//  TVLive
//。 UIImageView智能加载模式，兼容支持gif
//  Created by shiyang on 2020/12/15.
//  Copyright © 2020 dianshijia_ios. All rights reserved.
//

#import "UIImageView+GifView.h"
#import <objc/runtime.h>
//#import "SVGKLayeredImageView.h"

static const char *UrlKey = "UrlKey";
//static const char *PagViewKey = "PagViewKey";
//static const char *SVGAViewKey = "SVGAViewKey";
//static const char *SVGAParserKey = "SVGAParserKey";

@interface UIImageView(GifView)

@end

@implementation UIImageView(GifView)

/**
 智能模式，加载自动判断gif或普通url
 */
- (void)set_url_smartModel:(NSString * _Nullable)gifUrl withPlace:(UIImage * _Nullable)placeholderImage imgView:(UIImageView *)imgView completed:(void(^)(UIImage * _Nullable image,UIView * _Nullable view))completedBlock{
    if(!gifUrl || gifUrl.length <= 0 || ![gifUrl isKindOfClass:[NSString class]]){
        return;
    }

    [self removeAllSubviews];
    self.hidden = NO;
    self.image = placeholderImage;
    
    __weak typeof(self)weakSelf = self;
    if(gifUrl&&([gifUrl hasPrefix:@"http"] || [gifUrl hasPrefix:@"https"])){
        [self setImage:nil];
        if ([gifUrl containsString:@".gif"]) {
            [self set_url_normalModel:gifUrl withPlace:placeholderImage completed:^(UIImage * _Nullable image) {
                objc_setAssociatedObject(weakSelf, &UrlKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                if (completedBlock) {
                    completedBlock(image,nil);
                }
            }];
        }
//        else if ([gifUrl hasSuffix:@".svg"]) {
//            UIImage * image = [self svgImageUrlStr:gifUrl imgv:imgView];
//            objc_setAssociatedObject(self, &UrlKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            if (completedBlock) {
//                completedBlock(image,nil);
//            }
//        }else if ([gifUrl hasSuffix:@".svga"]) {
//            self.clipsToBounds = YES;
//            [self set_url_svga:gifUrl completed:^(UIImage * _Nullable image) {
//                if (completedBlock) {
//                    completedBlock(image,nil);
//                }
//            }];
//        }else if([gifUrl hasSuffix:@".pag"]){
//            [self pagFileWithUrl:gifUrl completed:^(DSJ_PagView * _Nullable view) {
//                objc_setAssociatedObject(weakSelf, &PagViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                if (completedBlock) {
//                    completedBlock(nil,view);
//                }
//            }];
//        }
        else{
            [self set_url_normalModel:gifUrl withPlace:placeholderImage completed:^(UIImage * _Nullable image) {
                objc_setAssociatedObject(weakSelf, &UrlKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                if (completedBlock) {
                    completedBlock(image,nil);
                }
            }];
        }
    }else{
//        if([gifUrl hasSuffix:@".pag"]){
//            [self pagFileLocalPath:gifUrl];
//        }
    }
}

/**
 普通模式，加载普通url
 */
-(void)set_url_normalModel:(NSString*)url withPlace:(UIImage*)placeholderImage completed:(nonnull void (^)(UIImage * _Nullable))completedBlock{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            if (completedBlock) {
                completedBlock(image);
            }
        }
    }];
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageRetryFailed | SDWebImageQueryMemoryData completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (image) {
//            if (completedBlock) {
//                completedBlock(image);
//            }
//        }
//    }];
}

/**
 *加载svga 动画
 *
 */
//-(void)set_url_svga:(NSString*)url completed:(void(^)(UIImage * _Nullable image))completedBlock{
//    if(self){
//        SVGAPlayer * player = objc_getAssociatedObject(self, &SVGAViewKey);
//        SVGAParser * parser = objc_getAssociatedObject(self, &SVGAParserKey);
//        
//        if(!player || ![player isKindOfClass:[SVGAPlayer class]]){
//            player=[self svgaPlayer];
//            player.delegate =self;
//            [self addSubview:player];
//            [player mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.bottom.left.right.mas_equalTo(0);
//            }];
//            
//            if(self){
//                objc_setAssociatedObject(self, &SVGAViewKey, player, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//        
//        if(!parser || ![parser isKindOfClass:[SVGAParser class]]){
//            parser = [[SVGAParser alloc] init];
//            
//            if(self){
//                objc_setAssociatedObject(self, &SVGAParserKey, parser, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//        
//        Weak(weakSelf);
//        [parser parseWithURL:[NSURL URLWithString:url] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
//            if (videoItem != nil) {
//                player.videoItem = videoItem;
//                player.fillMode = @"Forward";
//                [player startAnimation];
//            }
//            
//            //有svga视图去掉因复用有的image
//            if (0 < weakSelf.subviews.count) {
//                weakSelf.image = nil;
//            }
//            
//            if (completedBlock) {
//                completedBlock(nil);
//            }
//        } failureBlock:nil];
//    }
//}

-(void)set_LocalGif:(NSString *)name{
    [self removeAllSubviews];
    self.image = nil;
    
    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:name withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL); //将GIF图片转换成对应的图片源
    size_t frameCout = CGImageSourceGetCount(gifSource);// 获取其中图片源个数，即由多少帧图片组成
    NSMutableArray *imgs = [[NSMutableArray alloc] init];  // 定义数组存储拆分出来的图片
    for (size_t i = 0; i < frameCout; i++) {
        @autoreleasepool {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); // 从GIF图片中取出源图片
            UIImage *imageName = [UIImage imageWithCGImage:imageRef]; // 将图片源转换成UIimageView能使用的图片源
            [imgs addObject:imageName];
            CGImageRelease(imageRef);
        }
    }
    self.animationImages = imgs;
    self.animationDuration = 3;
    [self startAnimating];
}


//- (SVGAPlayer *)svgaPlayer{
//    SVGAPlayer*_svgaPlayer = [[SVGAPlayer alloc] init];
//    _svgaPlayer.frame = self.bounds;
//    _svgaPlayer.loops = 1;
//    _svgaPlayer.clearsAfterStop = YES;
//    _svgaPlayer.contentMode = UIViewContentModeScaleToFill;
//    
//    return _svgaPlayer;
//}
//
//#pragma SVGAPlayerDelegate
//-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
//    [player startAnimation];
//}


/*
 SVG加载
 */
//-(UIImage *)svgImageUrlStr:(NSString *)urlStr imgv:(UIImageView *)imgv{
//    return [self urlStr:urlStr imgv:imgv];
//}
//
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv{
//    return [self name:name imgv:imgv];
//}
//
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv hexColor:(NSString *)hexColor{
//    UIColor *tintColor = [self colorWithHexString:hexColor];
//    return [self name:name imgv:imgv tintColor:tintColor];
//}
//
//-(UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv objColor:(UIColor *)objColor{
//    UIColor *tintColor = objColor;
//    return [self name:name imgv:imgv tintColor:tintColor];
//}
//
//#pragma mark - 加载svg图片统一调用此方法
//-(UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv{
//    SVGKImage *svgImage = [SVGKImage imageNamed:name];
//    svgImage.size = CGSizeMake(imgv.frame.size.width, imgv.frame.size.height);
//    return svgImage.UIImage;
//}
//
//-(UIImage *)urlStr:(NSString *)urlStr imgv:(UIImageView *)imgv{
//    SVGKImage *svgImage = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:urlStr]];
//    svgImage.size = CGSizeMake(imgv.frame.size.width, imgv.frame.size.height);
//    return svgImage.UIImage;
//}

/*
 pag格式加载
 */
//-(void)pagFileWithUrl:(NSString *)url completed:(void(^)(DSJ_PagView * _Nullable view))completedBlock{
//    DSJ_DownLoadManager* loader = [[DSJ_DownLoadManager alloc] init];
//    [loader downloadFileWithPath:url isDownApk:NO];
//    Weak(weakSelf);
//    loader.downLoadStateBlock = ^(CGFloat progress, NSString * _Nullable filePath, BOOL isDown) {
//        if (isDown) {
//            if(weakSelf){
//                NSData * data = [NSData dataWithContentsOfFile:filePath];
//                
//                DSJ_PagView * pagView = objc_getAssociatedObject(weakSelf, &PagViewKey);
//                if(pagView && [pagView isKindOfClass:[DSJ_PagView class]]){
//                    [pagView loadPagFileWithData:data repeatCount:0];
//                    if(completedBlock){
//                        completedBlock(pagView);
//                    }
//                }else{
//                    pagView = [[DSJ_PagView alloc] init];
//                    [pagView loadPagFileWithData:data repeatCount:0];
//                    [weakSelf.superview insertSubview:pagView belowSubview:weakSelf];
//                    if(weakSelf.superview.superview){
//                        [pagView mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.edges.mas_equalTo(weakSelf);
//                        }];
//                    }
//                    
//                    weakSelf.hidden = YES;
//                    weakSelf.gestureRecognizers = nil;
//                    
//                    if(completedBlock){
//                        completedBlock(pagView);
//                    }
//                }
//            }
//        }
//    };
//}

//-(void)pagFileLocalPath:(NSString *)path{
//    if(self){
//        DSJ_PagView * pagView = objc_getAssociatedObject(self, &PagViewKey);
//        if(pagView && [pagView isKindOfClass:[DSJ_PagView class]]){
//            [pagView loadLocalPagFileWithPath:path repeatCount:0];
//        }else{
//            pagView = [[DSJ_PagView alloc]initWithFrame:CGRectZero];
//            [pagView loadLocalPagFileWithPath:path repeatCount:0];
//            [self.superview insertSubview:pagView belowSubview:self];
//            [pagView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_equalTo(self);
//            }];
//            
//            if(self){
//                objc_setAssociatedObject(self, &PagViewKey, pagView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//        self.hidden = YES;
//    }
//}

#pragma mark - 修改颜色统一调用此方法
//-(UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv tintColor:(UIColor *)tintColor{
//    
//    UIImage *svgImage = [self name:name imgv:imgv];
//    
//    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
//    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.CGImage);
//    BOOL opaque = alphaInfo == (kCGImageAlphaNoneSkipLast | kCGImageAlphaNoneSkipFirst | kCGImageAlphaNone);
//    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, svgImage.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextClipToMask(context, rect, svgImage.CGImage);
//    
//    CGContextSetFillColorWithColor(context, tintColor.CGColor);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//    
//}

#pragma mark - 16进制色值转化
-(UIColor *)colorWithHexString:(NSString *)color{

    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
     
   // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


/**
 * 从父视图中移除
 */
- (void)remove{
//    [self checkGifLayer];
    if(self){
        objc_setAssociatedObject(self, &UrlKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [super removeFromSuperview];
}

//-(void)checkGifLayer{
//    if(self){
//        //检查是否有gif图层，有先移除gif绘制层
//        DSJ_PagView * pagView = objc_getAssociatedObject(self, &PagViewKey);
//        SVGAPlayer * player = objc_getAssociatedObject(self, &SVGAViewKey);
//        SVGAParser * parser = objc_getAssociatedObject(self, &SVGAParserKey);
//        
//        if (pagView) {
//            [pagView stop];
//            [pagView removeFromSuperview];
//            pagView = nil;
//            if(self){
//                objc_setAssociatedObject(self, &PagViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//        
//        if (player) {
//            [player stopAnimation];
//            [player removeFromSuperview];
//            player = nil;
//            if(self){
//                objc_setAssociatedObject(self, &SVGAViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//        
//        if (parser) {
//            parser = nil;
//            if(self){
//                objc_setAssociatedObject(self, &SVGAParserKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//        }
//    }
//}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
