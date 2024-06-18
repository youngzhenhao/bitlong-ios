//
//  Macro.h
//  bitlong
//
//  Created by 微链通 on 2024/5/6.
//

#ifndef Macro_h
#define Macro_h

/****************************************************************
  自定义打印
******************************************************************/
#ifdef DEBUG

#define NSSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSSLog(...)

#endif


#define Weak(name)  __weak typeof (self) name = self;
#define Strong(name,obj)  __strong typeof (obj) name = obj;

//#define DSJAppDelegate  ((AppDelegate *)([UIApplication sharedApplication].delegate))

/****************************************************************
颜色
******************************************************************/
#define UIColorFromHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]

#define UIColorFromRGBA(rgbValue,alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
//主题色
#define MainThemeColor UIColorFromRGB(0x2469FE)
#define RGB(R,G,B,a) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:a]

/****************************************************************
  字体
******************************************************************/
#define FONT(s) \
[UIFont fontWithName:@"SourceHanSansCN-Light" size:s]
#define FONT_NORMAL(s) \
[UIFont systemFontOfSize:s]
#define FONT_BOLD(s) \
[UIFont fontWithName:@"Helvetica-Bold" size:s]



/****************************************************************
 宽度高度
******************************************************************/

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define ISIPAD (Device.userInterfaceIdiom == UIUserInterfaceIdiomPad ? YES : NO)
#define ISIPHONEX ((SCREEN_HEIGHT >= 812.0 && !ISIPAD) ? YES : NO)

#define IS_OS_13 [[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0

#define SCALE  (ISIPAD ? SCREEN_WIDTH/768 : SCREEN_WIDTH/375)

#define SafeAreaTopHeight (SCREEN_HEIGHT >= 812.0 && !ISIPAD ? 88 : 64)
#define SafeAreaBottomHeight (SCREEN_HEIGHT >= 812.0 && !ISIPAD ? 34 : 0)

#define SafeAreaBottomHeightLandscape (SCREEN_WIDTH >= 812.0 && !ISIPAD ? 44 : 0)

#define IPHONEX_TABBAR_FIX_HEIGHT 34
#define IPHONEX_TOPBAR_FIX_HEIGHT 44

#define StatusBarHeight (ISIPHONEX ? 44 : 20)
//导航栏的高度
#define NavBarHeight 44.0
//tabBar的高度
#define TabBarHeight (ISIPHONEX ? 83 : 49)
//状态栏和导航栏的高度
#define TopHeight (StatusBarHeight + NavBarHeight)

#define xWidth(R) (R)*(SCREEN_WIDTH)/375.0
#define xHeight(R) (R)*(SCREEN_HEIGHT)/667.0
#define font(R)  (R)*(SCREEN_WIDTH)/375.0

#define SINGLE_LINE_WIDTH (1 / [UIScreen mainScreen].scale) //默认为1 pixel

/****************************************************************
  方法
******************************************************************/
#define Device [UIDevice currentDevice]
#define imagePic(name) [UIImage imageNamed:name]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define userDefaults [NSUserDefaults standardUserDefaults]

#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define KNSDocumentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]

#define MainBuildInfo [[NSBundle mainBundle] infoDictionary]

#define COLOR16(s)\
[UIColor colorWithHexString:s];

#endif /* Macro_h */
