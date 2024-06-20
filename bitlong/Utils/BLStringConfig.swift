//
//  BLStringConfig.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/30.
//
 
import Foundation

/*
 key
 */
//api成功状态
let APISECCUSS  = "SECCUSS"
//助解字
let GenSeed = "GenSeed"
//钱包信息
let WalletInfo               = "WalletInfo"
let WalletName               = "WalletName"
let WalletPassWorld          = "WalletPassWorld"
let WalletPassWorldNotice    = "WalletPassWorldNotice"
let WalletBalance            = "WalletBalance"//钱包资产信息 包含一下信息
let TotalBalance             = "TotalBalance" //总资产
let ConfirmedBalance         = "ConfirmedBalance" //已确认资产
let UnconfirmedBalance       = "UnconfirmedBalance" //未已确认资产
let LockedBalance            = "LockedBalance" //锁定的资产
//钱包地址
let WalletAddress            = "WalletAddress"
//资产信息
let AssetsInfo               = "AssetsInfo"
let AssetsName               = "AssetsName"
let AssetsNum                = "AssetsNum"
//创建资产发票时间
let AssetsInvoiceCreatTime   = "AssetsInvoiceCreatTime"
//token
let Token  = "Token"
//是否修改密码标志位
let IsNeedChangePassWord     = "IsNeedChangePassWord"

/*
 test
 */
//创建钱包
let genSeedTitle              = "备份助记词"
let genSeedSubTitle           = "请按顺序抄写助记词，确保备份正确。"
let genSeedWarnTitle          = "妥善保管助记词至隔离网络的安全地方。"
let genSeedWarnSubTitle       = "请勿将助记词在联网环境下分享和存储，比如邮件、相册、社交应用等。"

let manualBackupTitle         = "手动备份"
let cloudBackupTitle          = "云备份"
let laterBackupTitle          = "稍后备份"


/*
 file path
 */
let Key_Assets           = "key_Assets"
//资产图标
let Key_AssetsIcon       = "assetsIcon.plist"


/*
 error type
 */
//proof file
let Error_ProofPre       = "unable to make proof file path: proof file "
let Error_ProofLast      = " does not exist: unable to find proof"



/*
 regex 正则表达式
 */
//手机号
let PhoneNumRegex        = "^1\\d{10}$"
//邮箱
let EmailRegex           = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//身份证号码
let IDCardRegex        = "^(\\d{14}|\\d{17})(\\d|[xX])$"
//IP验证
let IPRegex              = "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])(\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)){3}$"
//由字母和数字组成的8-12位字符
let PasswordRegex        = "^[a-zA-Z0-9]{8,12}$"
//0到10的数字，最多两位小数
let NumRegex             = "^[0-9](\\.[0-9]{1,2}){0,1}$"
