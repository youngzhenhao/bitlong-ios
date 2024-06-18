//
//  BLAssetsDetailModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/14.
//

import UIKit

/*
 资产列表
 */
@objcMembers class BLAssetsDetailModel: BLBaseModel {
    var datas : [BLAssetsDetailItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }

    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLAssetsDetailItem.self]
    }
}

@objcMembers class BLAssetsDetailItem: BLBaseModel {
    var creation_time_unix_seconds : String?
    var addr : BLAssetsAddrItem?
    var status : String?
    var outpoint : String?
    var utxo_amt_sat : String?
    var taproot_sibling : String?
    var confirmation_height : String?
    var has_proof : String?
}

@objcMembers class BLAssetsAddrItem: BLBaseModel {
    var encoded : String?
    var asset_id : String?
    var asset_type : String?
    var amount : String?
    var group_key : String?
    var script_key : String?
    var internal_key : String?
    var tapscript_sibling : String?
    var taproot_output_key : String?
    var proof_courier_addr : String?
    var asset_version : String?
}


/*
 btc 列表
 */
@objcMembers class BLBTCDetailModel: BLBaseModel {
    var datas : [BLBTCDetailItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }

    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLBTCDetailItem.self]
    }
}

@objcMembers class BLBTCDetailItem: BLBaseModel {
    var name : String?
    var address : String?
    var balance : String?
    var address_type : String?
    var derivation_path : String?
    var is_internal : String?
}
