//
//  BLAppDelegate.m
//  web3.0
//
//  Created by 微链通 on 2024/4/28.
//

#import "BLAppDelegate.h"
#import "bitlong-Swift.h"

@interface BLAppDelegate()

@property(nonatomic,strong)BLInitWalletVC *walletVC;

@end

@implementation BLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10*SCALE;
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [IQKeyboardManager sharedManager].toolbarManageBehavior = IQAutoToolbarBySubviews;
    
//    NSDictionary * walletInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"WalletInfo"];
    
    [[BLPermissionsManager shared] requestNetwork];
    [self initLuanchView];
    [self startServer];
    Weak(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf getLndState];
    });

    return YES;
}

-(UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return _window;
}

-(void)initWalletVC{
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:self.walletVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}
//饿的我
-(void)initMainTabBarVC{
    self.window.rootViewController = self.tabBarVC;
    [self.window makeKeyAndVisible];
}

-(void)initLuanchView{
    BLLuanchVC * luanchVC = [[BLLuanchVC alloc] init];
//    luanchView.view.frame = self.window.frame;
    self.window.rootViewController = luanchVC;
    [self.window makeKeyAndVisible];
}

-(void)getLndState{
    Weak(weakSelf);
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSString * litStatus = ApiGetState();
        NSSLog(@"litStatus：%@",litStatus);
        if ([litStatus isEqualToString:@"WAITING_TO_START"]){//节点正在等待成为集群的领导者，尚未启动
        }else if ([litStatus isEqualToString:@"NON_EXISTING"]){//钱包尚未初始化
            [weakSelf initWalletVC];
            [timer invalidate];
        }else if ([litStatus isEqualToString:@"LOCKED"]){//钱包已锁定
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                NSDictionary * walletInfo = [userDefaults objectForKey:@"WalletInfo"];
                NSString * passWorld = walletInfo[@"WalletPassWorld"];
                [BLTools showTostWithTip:@"开始解锁钱包~" superView:weakSelf.window];
                if(ApiUnlockWallet(passWorld)){
                    static dispatch_once_t onceToken;
                    dispatch_once(&onceToken, ^{
                        [weakSelf initMainTabBarVC];
                    });
                }else{
                    [BLTools showTostWithTip:@"解锁钱包失败" superView:weakSelf.window];
                }
            });
        }else if ([litStatus isEqualToString:@"UNLOCKED"]){//钱包已成功解锁，但 RPC 服务器尚未就绪
        }else if ([litStatus isEqualToString:@"RPC_ACTIVE"]){//RPC 服务器处于活动状态，但尚未完全准备好接受调用
        }else if ([litStatus isEqualToString:@"SERVER_ACTIVE"]){//RPC 服务器可用并准备好接受调用
            [weakSelf getTapState];
            [timer invalidate];
        }else if ([litStatus isEqualToString:@"NO_START_LND"]){//LND服务挂了，请重新启动服务
            [BLTools showTostWithTip:@"LND服务挂了，请重新启动服务" superView:weakSelf.window];
        }
    }];
}

-(void)getTapState{
    [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //获取Tap服务状态，检测错误状态
        NSString * jsonStr = ApiGetInfoOfTap();
        [BLServerErrorDealModel dealTapErrorWithJsonStr:jsonStr callBack:^(BOOL isInvalidate) {
            if(isInvalidate){
                [timer invalidate];
            }
        }];
    }];
}

-(BLInitWalletVC *)walletVC{
    if (!_walletVC) {
        _walletVC = [[BLInitWalletVC alloc] init];
    }
    
    return _walletVC;
}

-(MainTabBarVC *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = [[MainTabBarVC alloc] init];
    }
    
    return _tabBarVC;
}

-(void)applicationWillResignActive:(UIApplication *)application{
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
}

-(void)applicationDidBecomeActive:(UIApplication *)application{
}

- (void)applicationWillTerminate:(UIApplication *)application{
}

-(void)startServer{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSDictionary *attributes = @{ NSFilePosixPermissions : @(0755)};
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager setAttributes:attributes ofItemAtPath:documentsDirectory error:&error];
       
//        NSArray *cacheDirectories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *cacheDirectory = [cacheDirectories objectAtIndex:0];
//        NSString *SQLITETMPDIRPath = [cacheDirectory stringByAppendingPathComponent:@"SQLITE_TMPDIR"];
//        int flg = setenv("SQLITE_TMPDIR", [SQLITETMPDIRPath UTF8String], 1);
//        NSSLog(@"%d",flg);

        
        NSString *litPath = [documentsDirectory stringByAppendingPathComponent:@".lit"];
        NSString *lndPath = [documentsDirectory stringByAppendingPathComponent:@".lnd"];
        NSString *tapdPath = [documentsDirectory stringByAppendingPathComponent:@".tapd"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:litPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:litPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:lndPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:lndPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:tapdPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:tapdPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        
        //mainNet
        //第一条线
        NSString *dataPath = [lndPath stringByAppendingPathComponent:@"data"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *chainPath = [dataPath stringByAppendingPathComponent:@"chain"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:chainPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:chainPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *bitcoinPath = [chainPath stringByAppendingPathComponent:@"bitcoin"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:bitcoinPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:bitcoinPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *testnetPath = [bitcoinPath stringByAppendingPathComponent:@"mainnet"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:testnetPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:testnetPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        
        //不能直接拷贝文件到文件夹，要先生成文件路径，往里拷
        NSString *block_headersFilePath = [testnetPath stringByAppendingPathComponent:@"block_headers.bin"];
        NSString *neutrinoFilePath = [testnetPath stringByAppendingPathComponent:@"neutrino.db"];
        NSString *reg_filter_headersFilePath = [testnetPath stringByAppendingPathComponent:@"reg_filter_headers.bin"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:block_headersFilePath]){
            NSString * block_headersPath = [[NSBundle mainBundle] pathForResource:@"block_headers" ofType:@"bin"];
            if(block_headersPath){
                [[NSFileManager defaultManager] copyItemAtPath:block_headersPath toPath:block_headersFilePath error:&error];
            }
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:neutrinoFilePath]){
            NSString * neutrinoPath = [[NSBundle mainBundle] pathForResource:@"neutrino" ofType:@"db"];
            if(neutrinoPath){
                [[NSFileManager defaultManager] copyItemAtPath:neutrinoPath toPath:neutrinoFilePath error:&error];
            }
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:reg_filter_headersFilePath]){
            NSString * reg_filter_headersPath = [[NSBundle mainBundle] pathForResource:@"reg_filter_headers" ofType:@"bin"];
            if(reg_filter_headersPath){
                [[NSFileManager defaultManager] copyItemAtPath:reg_filter_headersPath toPath:reg_filter_headersFilePath error:NULL];
            }
        }
        
        //第二条线
        NSString *graphPath = [dataPath stringByAppendingPathComponent:@"graph"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:graphPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:graphPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *testnet2Path = [graphPath stringByAppendingPathComponent:@"mainnet"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:testnet2Path]){
            [[NSFileManager defaultManager] createDirectoryAtPath:testnet2Path withIntermediateDirectories:NO attributes:nil error:&error];
        }
        
        NSString *channelFilePath = [testnet2Path stringByAppendingPathComponent:@"channel.db"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:channelFilePath]){
            NSString * channelPath = [[NSBundle mainBundle] pathForResource:@"channel" ofType:@"db"];
            if(channelPath){
                [[NSFileManager defaultManager] copyItemAtPath:channelPath toPath:channelFilePath error:&error];
            }
        }
        
        //        NSString *keyInfo = [documentsDirectory stringByAppendingPathComponent:@"keyInfo.db"];
        //        if ([[NSFileManager defaultManager] fileExistsAtPath:keyInfo]){
        //            [[NSFileManager defaultManager] removeItemAtPath:keyInfo error:&error];
        //        }
                
        //        NSString * proofPath = [tapdPath stringByAppendingString:@"/data/regtest/proofs/921d8ca7bb09219c38bfe0cbac9a8bc6e8001e25f94cf115a9cc4b073903c99a/02d7935eccdaeb47661910ee76435191596db36b172624fb33a4f435f162177316-d03bc28bb272a30ab2ed406a94154072-1.assetproof"];
        //        if ([[NSFileManager defaultManager] fileExistsAtPath:proofPath]){
        //            [[NSFileManager defaultManager] removeItemAtPath:proofPath error:&error];
        //        }
        
        
        NSString *configFilePath = [documentsDirectory stringByAppendingPathComponent:@"config.txt"];
        NSMutableString * text = [NSMutableString string];
        [text appendString:[NSString stringWithFormat:@"dirpath=%@",documentsDirectory]];
        [text appendString:@"\n"];
        [text appendString:@"lndhost=127.0.0.1:10009"];
        [text appendString:@"\n"];
        [text appendString:@"taproothost=127.0.0.1:8443"];
        [text appendString:@"\n"];
        [text appendString:@"LnurlServerHost=202.79.173.41:9080"];
        [text appendString:@"\n"];
        [text appendString:@"litdhost=127.0.0.1:8443"];
        [text appendString:@"\n"];
        [text appendString:@"serverAddr=202.79.173.41"];
        [text writeToFile:configFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSString *litFilePath = [litPath stringByAppendingPathComponent:@"lit.conf"];
        NSMutableString * litText = [NSMutableString string];
        
        /*
         私链
         */
        [litText appendString:@"lnd-mode=integrated"];
        [litText appendString:@"\n"];
        [litText appendString:@"uipassword=11111111"];
        [litText appendString:@"\n"];
        [litText appendString:@"network=regtest"];
        [litText appendString:@"\n"];
        [litText appendString:@"httpslisten=0.0.0.0:8443"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.alias=lnd1"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.bitcoin.active=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.rpclisten=0.0.0.0:10009"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.rpcmiddleware.enable=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.db.bolt.auto-compact=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"autopilot.disable=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.bitcoin.regtest=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"taproot-assets.universe.federationserver=132.232.109.84:8443"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.bitcoin.node=neutrino"]; //中微子后端
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.neutrino.connect=132.232.109.84:18444"];
        [litText appendString:@"\n"];
        [litText appendString:@"taproot-assets.network=regtest"];
        [litText appendString:@"\n"];
        [litText appendString:@"taproot-assets.allow-public-uni-proof-courier=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"taproot-assets.allow-public-stats=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"taproot-assets.universe.public-access=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.neutrino.persistfilters=true"];
        [litText appendString:@"\n"];
        [litText appendString:@"lnd.neutrino.broadcasttimeout=11s"];
        
        
        /*
         主网
         */
//        [litText appendString:@"lnd-mode=integrated"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"uipassword=11111111"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"network=mainnet"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"httpslisten=0.0.0.0:8443"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.alias=lnd1"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"autopilot.disable=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.rpcmiddleware.enable=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.db.bolt.auto-compact=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.bitcoin.active=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.bitcoin.mainnet=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.bitcoin.node=neutrino"]; //中微子后端
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.rpclisten=0.0.0.0:10009"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.accept-keysend=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.accept-amp=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.neutrino.persistfilters=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.neutrino.broadcasttimeout=11s"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"taproot-assets.network=mainnet"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"taproot-assets.allow-public-uni-proof-courier=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"taproot-assets.allow-public-stats=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"taproot-assets.universe.public-access=true"];
//        [litText appendString:@"\n"];
//        [litText appendString:@"lnd.feeurl=https://nodes.lightning.computer/fees/v1/btc-fee-estimates.json"];
     
        [litText writeToFile:litFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
//        ApiSetPath(documentsDirectory,@"testnet"); //内网
        ApiSetPath(documentsDirectory,@"regtest"); //私链
//        ApiSetPath(documentsDirectory,@"mainnet"); //主网
        NSSLog(@"ApiGetPath:\n%@",ApiGetPath());
        
//        ApiReadConfigFile1();
//        NSSLog(@"-------------ApiReadConfigFile2-------------:\n");
//        ApiReadConfigFile2();
//
//        ApiCreateDir2();
//        ApiVisit();
//        [self getAllName:@"----------ApiStartLitd2--------"];
        ApiStartLitd();
    });
}

- (void)getAllName:(NSString *)local{
    NSSLog(@"local:%@\n",local);
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager      = [NSFileManager defaultManager];
//    NSString *testDirectory    = [documentsPath stringByAppendingPathComponent:@"files"];
    //取得一个目录下得所有文件名
    NSArray *files = [fileManager subpathsAtPath:documentsPath];
    NSSLog(@"Document:%@",files);
}

@end
