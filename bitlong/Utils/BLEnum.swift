//
//  BLEnum.swift
//  bitlong
//
//  Created by slc on 2024/4/28.
//

import Foundation

//Lit服务状态
enum LitStatus : String{
    case WAITING_TO_START = "WAITING_TO_START" //节点正在等待成为集群的领导者，尚未启动
    case NON_EXISTING = "NON_EXISTING"         //钱包尚未初始化
    case LOCKED = "LOCKED"                     //钱包已锁定
    case UNLOCKED = "UNLOCKED"                 //钱包已成功解锁，但 RPC 服务器尚未就绪
    case RPC_ACTIVE = "RPC_ACTIVE"             //RPC 服务器处于活动状态，但尚未完全准备好接受调用
    case SERVER_ACTIVE = "SERVER_ACTIVE"       //RPC 服务器可用并准备好接受调用
    case NO_START_LND = "NO_START_LND"         //LND服务挂了，请重新启动服务
    case UNKNOW = "UNKNOW"                     //未知
}

//创建钱包，钱包属性信息
enum CreatWalletCellType : NSInteger {
    case walletName = 0            //钱包名称
    case walletPassWorld           //钱包密码
    case walletPassWorldAgain      //重复钱包密码
    case walletPassWorldNoti       //钱包密码提示
}

enum GenSeedPageType : NSInteger{
    case backupsGenSeed     = 0   //创建钱包备份助记词
    case exportGenSeed            //导出助记词
    case inportGenSeed            //导入助记词
    case verifyGenSeed            //验证助记词
}


//创建资产，资产属性信息
enum CreatAssetsCellType : NSInteger {
    case assetsLogo = 0            //资产Logo
    case assetsName                //资产名称
    case assetsType                //资产类型
    case assetsNum                 //资产总量
    case assetsReserve             //项目方预留
    case assetsMintNum             //单份Mint数量
    case assetsBegainDate          //开始日期
    case assetsEndDate             //结束日期
    case assetsLockoutTime         //锁仓时间
    case assetsDescription         //介绍信息
    case assetsID                  //资产ID
    case assetsHadCastOn           //已铸造
    case assetsHolder              //持有人
    case assetsCopies              //份数
    
}

//资产详情页类型
enum AssetsDetailType : NSInteger {
    case BTCType = 0            //BTC
    case assetsType             //资产
    case channelBTCType         //通道
}

//category分页类型
enum CategoryPageType : String {
    //TransactionDetail
    case detailMarket   = "市场"           //市场
    case detailList     = "交易"           //交易
    case detailPool     = "池子"           //池子
    case detailMyOrder  = "我的挂单"        //我的挂单
}

//k线图标时间分类
enum ChartTimeType : NSInteger {
    case chartOneMin      = 0     //1分
    case chartFiveMin             //5分
    case chartThirtyMin           //30分
    case chartOneHour             //1时
    case chartFourHour            //4时
    case chartOneDay              //1天
    case chartOneWeek             //1周
    case chartMore                //更多
    case chartIndex               //指标
}

//地址类型 BTC||资产||发票
enum AddressType : NSInteger {
    case addresNone          = 0   //类型未知
    case addressBTC                //BTC
    case addressAssets             //Assets
    case addressInvoice            //发票
}

//语言类型
enum LanguageType : String{
    case ZH = "zh" //中文
    case EN = "en" //英文
}
