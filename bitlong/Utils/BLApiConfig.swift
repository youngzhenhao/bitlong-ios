//
//  BLApiConfig.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/5.
//

import Foundation

/*
 发票
 */
//转账
let ApiInvoiceInvoicePay    = "custodyAccount/invoice/pay"
//开户（开发票）
let ApiInvoiceInvoiceApply  = "custodyAccount/invoice/apply"
//查询余额
let ApiInvoiceQueryBalance  = "custodyAccount/invoice/querybalance"
//查询发票
let ApiInvoiceQueryInvoice  = "custodyAccount/invoice/queryinvoice"
//查询交易记录
let ApiInvoiceQueryPayment  = "custodyAccount/invoice/querypayment"

/*
 铸造
 */
//查询所有已发行且未全部铸造的公平发射数据
let ApiFairLaunchQueryIssued                  = "v1/fair_launch/query/issued"
//查询合适的费率
let ApiFeeQueryRate                           = "v1/fee/query/rate"
//进行公平发射资产发行
let ApiFairLaunchSet                          = "v1/fair_launch/set"
//通过资产ID(AssetID)查询公平发射资产发行信息
let ApiFairLaunchQueryAsset                   = "v1/fair_launch/query/asset"
//通过给定参数查询是否可以进行铸造行为
let ApiFairLaunchQueryMint                    = "v1/fair_launch/query/mint"
//进行公平发射的资产铸造
let ApiFairLaunchMint                         = "v1/fair_launch/mint"
//查询用户自己的公平发射资产铸造信息
let ApiFairLaunchQueryOwnMint                 = "v1/fair_launch/query/own_mint"
//进行公平发射资产的发行保留部分取回
let ApiFairLaunchMintReserved                 = "v1/fair_launch/mint_reserved"
//通过资产ID(AssetID)查询资产的可铸造库存份数和数量
let ApiFairLaunchQueryInventoryMintNumber     = "v1/fair_launch/query/inventory_mint_number"

/*
 下载证明文件
 */
let ApiProofDownload                          = "proof/download"




