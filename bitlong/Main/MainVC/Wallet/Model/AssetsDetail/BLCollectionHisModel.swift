//
//  BLCollectionHisModel.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

@objcMembers class BLCollectionHisModel: BLBaseModel {
    var datas : [BLCollectionHisItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }

    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLCollectionHisItem.self]
    }
}

@objcMembers class BLCollectionHisItem: BLBaseModel {
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
