//
//  BLLaunchQueryOwnMintModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/12.
//

import UIKit

@objcMembers class BLLaunchQueryOwnMintModel: BLBaseModel {
    var success : String?
    var error : String?
    var datas : [BLLaunchQueryOwnMintItem]?

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLLaunchQueryOwnMintItem.self]
    }
}

@objcMembers class BLLaunchQueryOwnMintItem: BLBaseModel {
    var ID : String?//公平发射资产发行信息ID
    var CreatedAt : String?
    var UpdatedAt : String?
    var DeletedAt : String?
    var fair_launch_info_id : String?
    var minted_number : String?//已经铸造份数
    var minted_fee_rate_sat_per_kw : String?
    var minted_gas_fee : String?
    var encoded_addr : String?
    var mint_fee_paid_id : String?
    var pay_method : String?//支付手续费方式
    var paid_success_time : String?//手续费支付成功时间
    var user_id : String?//资产发行用户ID
    var asset_name : String?
    var asset_id : String?//资产ID
    var asset_type : String?//资产类型
    var amount_addr : String?
    var script_key : String?
    var internal_key : String?
    var taproot_output_key : String?
    var proof_courier_addr : String?
    var minted_set_time : String?
    var send_asset_time : String?
    var is_addr_sent : String?
    var outpoint_tx_hash : String?
    var outpoint : String?
    var address : String?
    var status : String?//状态，默认为1
    var state : String?//阶段 0未支付 1支付进行中 2已支付未发行 3发行中 4已发行。此时可以进行11.进行公平发射资产的发行保留部分取回 5保留资产发送中 6保留资产已发送
}


