//
//  MainTabBarVC.m
//  TVFamily
//
//  Created by xiaohesong on 15/10/11.
//  Copyright (c) 2015年 xiaohesong. All rights reserved.
//

#import "MainTabBarVC.h"
#import "Macro.h"

@interface MainTabBarVC ()<UITabBarControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *arrVC;
@property (nonatomic, strong) UILabel *  tabTitleLabelOne;
@property (nonatomic, strong) UILabel *  tabTitleLabelTwo;
@property (nonatomic, strong) UILabel *  tabTitleLabelThree;
@property (nonatomic, strong) NSMutableArray <UILabel *> *tabTitleLabelArr;
@property (nonatomic, assign) NSInteger tabMainSelected;

@end

@implementation MainTabBarVC

- (instancetype)init{

    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self initializeController];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(Device.userInterfaceIdiom != UIUserInterfaceIdiomPad){
        CGRect frame = self.tabBar.frame;
        frame.size.height = TabBarHeight;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
        self.tabBar.barStyle = UIBarStyleDefault;
    }
}

/**
 初始化控制器
 */
-(void)initializeController{
    [self setupChildControllers:self.arrVC];
    [self creatAnimationTabBarView:self.arrVC];
}

#pragma mark - 添加控制器
-(void)setupChildControllers:(NSArray *)arr{
    NSMutableArray *arrVC = [NSMutableArray array];
    for (NSDictionary *dictVC in arr) {
        @autoreleasepool {
            NSString *clsName = dictVC[@"clsName"];
            NSString *title = dictVC[@"title"];
            
            UIViewController *clsVCName = [[NSClassFromString(clsName) alloc] init];
            if ([clsVCName isKindOfClass:[UIViewController class]]) {
                clsVCName.navigationItem.title = title;
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:clsVCName];
                nav.delegate=self;
                nav.navigationBar.hidden = YES;
                [arrVC addObject:nav];
            }
        }
    }
    
    self.viewControllers = arrVC;
}

/**
 * navigation bar
 **/
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

    
- (void)hideTabBar{
    if (self.tabBar.hidden == YES) return;
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBar.frame.size.height);
    self.tabBar.hidden = YES;
}

- (void)showTabBar{
    if (self.tabBar.hidden == NO)   return;
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBar.frame.size.height);
    self.tabBar.hidden = NO;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [self updateTabBarAnimation];
}

-(void)updateTabBarAnimation{
    if (_tabMainSelected == self.selectedIndex) {
        return;
    }
    
    _tabMainSelected=self.selectedIndex;
    
    Weak(weakSelf);
    [self.tabTitleLabelArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == weakSelf.selectedIndex){
            obj.textColor = UIColorFromHex(0x665AF0);
        }else{
            obj.textColor =UIColorFromHex(0xC4C4C4);
        }
    }];
}

#pragma mark //屏幕旋转
- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

#pragma mark  状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)creatAnimationTabBarView:(NSArray *)vcArr{
    if (!_tabTitleLabelArr) {
        _tabTitleLabelArr = [NSMutableArray array];
    }else{
        [self.tabTitleLabelArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
        [self.tabTitleLabelArr removeAllObjects];
    }
    
    for (int i = 0; i < vcArr.count; i++) {
        @autoreleasepool {
            UILabel * tabTitleLbl = [UILabel new];
            tabTitleLbl.text = vcArr[i][@"title"];
            tabTitleLbl.textColor = UIColorFromHex(0xC4C4C4);
            tabTitleLbl.font = FONT_NORMAL(10*SCALE);
            tabTitleLbl.textAlignment = NSTextAlignmentCenter;
            if (i == 0) {
                tabTitleLbl.textColor = UIColorFromHex(0x665AF0);
                self.tabTitleLabelOne = tabTitleLbl;
            }else if (i == 1){
                self.tabTitleLabelTwo = tabTitleLbl;
            }else if (i == 2){
                self.tabTitleLabelThree = tabTitleLbl;
            }
            [self.tabTitleLabelArr addObject:tabTitleLbl];
            
            static NSInteger index = 0;
            Class btnClass = NSClassFromString(@"UITabBarButton");
            [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @autoreleasepool {
                    if ([obj isKindOfClass:[btnClass class]]) {
                        if (index == 0) {
                            index = idx;
                        }
                        [self.tabBar insertSubview:tabTitleLbl atIndex:index];
                        tabTitleLbl.frame = CGRectMake((SCREEN_WIDTH/vcArr.count)*i, TabBarHeight/2 - 30/2, SCREEN_WIDTH/vcArr.count, 30);
                    }
                }
            }];
        }
    }
    
    //去黑线
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    self.tabBar.backgroundColor = UIColorFromHex(0xFAFAFA);
    //去默认图标
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.image = nil;
        obj.tabBarItem.selectedImage = nil;
        obj.tabBarItem.title = @"";
        if (!ISIPAD) {
            [obj.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];
            obj.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }];
}

-(NSMutableArray *)arrVC{
    if (!_arrVC) {
        _arrVC = [NSMutableArray array];
        [_arrVC addObject:@{@"clsName" : @"bitlong.BLWalletVC" ,
                            @"title" : NSLocalized(@"tabBarItemOne"),
                            @"imageNor" :@"",
                            @"imageSel" : @"",
                          }];
        [_arrVC addObject:@{@"clsName" : @"bitlong.BLCastOnOutWellVC" ,
                            @"title" :   NSLocalized(@"tabBarItemTwo"),
                            @"imageNor" : @"",
                            @"imageSel" : @"",
                          }];
        [_arrVC addObject:@{@"clsName" : @"bitlong.BLTransactionVC" ,
                            @"title" :  NSLocalized(@"tabBarItemThree"),
                            @"imageNor" : @"",
                            @"imageSel" : @"",
                          }];
        [_arrVC addObject:@{@"clsName" : @"bitlong.BLToolVC" ,
                            @"title" :  NSLocalized(@"tabBarItemFour"),
                            @"imageNor" : @"",
                            @"imageSel" : @"",
                          }];
        [_arrVC addObject:@{@"clsName" : @"bitlong.BLNostrVC" ,
                            @"title" : NSLocalized(@"tabBarItemFive"),
                            @"imageNor" : @"",
                            @"imageSel" : @"",
                          }];
    }
    return _arrVC;
}

@end
