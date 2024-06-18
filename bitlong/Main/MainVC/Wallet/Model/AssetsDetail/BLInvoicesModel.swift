//
//  BLInvoicesModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/7.
//

import UIKit

@objcMembers class BLInvoicesModel: BLBaseModel {
    var invoices : [BLInvoicesHisItem]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["invoices": BLInvoicesHisItem.self]
    }
}

@objcMembers class BLInvoicesHisItem: BLBaseModel {
    var invoice : String?      //发票号码
    var asset_id : String?     //资产ID,预留，00表示比特币
    var amount : String?       //发票金额
    var status : String?       //int 发票状态，0表示未支付，1表示已支付，2表示已失效
}


@objcMembers class BLInvoicesPaymentModel: BLBaseModel {
    var payments : [BLInvoicesPaymentItem]?   //交易记录数组
    var paymentsIn : NSMutableArray?    //交易记录收款数组
    var paymentsOut : NSMutableArray?   //交易记录转账数组
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["payments": BLInvoicesPaymentItem.self]
    }
}

@objcMembers class BLInvoicesPaymentItem: BLBaseModel {
    var timestamp : String?   //交易时间戳
    var bill_type : String?   //交易类型(预留)
    var away : String?        //收/付(0表示收入，1表示支出)
    var invoice : String?     //交易相关联的发票号码(如果有)
    var amount : String?      //交易金额
    var asset_id : String?    //string 资产ID,预留，00表示比特币
    var state : String?       //int 交易状态(0表示挂起中，1表示成功，2表示失败)
}
