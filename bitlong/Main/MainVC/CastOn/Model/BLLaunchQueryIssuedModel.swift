//
//  BLLaunchQueryIssuedModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/11.
//

import UIKit

@objcMembers class BLLaunchQueryIssuedModel: BLBaseModel {
    var datas : [BLLaunchQueryIssuedItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLLaunchQueryIssuedItem.self]
    }
}


//公平发射发行信息
@objcMembers class BLLaunchQueryIssuedItem: BLBaseModel {
    var ID : String?//公平发射资产发行信息ID
    var CreatedAt : String?//
    var UpdatedAt : String?//
    var DeletedAt : String?//
    var image_data : String?//
    var name : String?//名字
    var asset_type : String?//资产类型
    var amount : String?//资产数量
    var reserved : String?//保留百分比
    var mint_quantity : String?//铸造每份数量
    var start_time : String?//开始时间
    var end_time : String?//结束时间
    var descriptions : String?//资产描述
    var fee_rate : String?//发行费率
    var set_time : String?//公平发射发起时间
    var actual_reserved : String?//实际保留百分百
    var reserve_total : String?//保留的资产总量
    var mint_number : String?//mint_number
    var is_final_enough : String?//最后一份是否足量
    var final_quantity : String?//最后一份资产数量
    var mint_total : String?// 铸造的资产总量
    var actual_mint_total_percent : String?//实际铸造百分比
    var calculation_expression : String?//资产总数构成表达式
    var batch_key : String?//批次秘钥
    var batch_state : String?//批次状态
    var batch_txid_anchor : String?//批次锚定交易ID
    var asset_id : String?//资产ID
    var user_id : String?//资产发行用户ID
    var pay_method : String?//支付手续费方式
    var paid_success_time : String?//手续费支付成功时间
    var issuance_fee_paid_id : String?//发行费用支付ID
    var issuance_time : String?//资产用tapd进行mint和finalize的时间
    var reserved_could_mint : String?//保留部分资产是否可以取回
    var is_reserved_sent : String?//保留部分资产是否已经取回
    var minted_number : String?//已经铸造份数
    var is_mint_all : String?//是否已经全部铸造
    var status : String?//状态，默认为1
    var state : String?//阶段 0未支付 1支付进行中 2已支付未发行 3发行中 4已发行。此时可以进行11.进行公平发射资产的发行保留部分取回 5保留资产发送中 6保留资产已发送
}
