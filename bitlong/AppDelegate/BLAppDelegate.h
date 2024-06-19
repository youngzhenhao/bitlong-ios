//
//  BLAppDelegate.h
//  bitlong
//
//  Created by slc on 2024/4/28.
//

#import <UIKit/UIKit.h>
#import "MainTabBarVC.h"
#import "Api/Api.h"

@interface BLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) MainTabBarVC * tabBarVC;
@property (strong, nonatomic) NSString * universeServer;

/*
 初始化主控制器
 */
-(void)initWalletVC;
-(void)initMainTabBarVC;
-(void)getAllName:(NSString *)local;
-(void)startServer;
-(void)getLndState:(BOOL)isNeedUnLock callBack:(void (^)(NSString * litStatus))blok;

@end

