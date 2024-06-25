//
//  BLAssetsSendHisModel.swift
//  bitlong
//
//  Created by slc on 2024/6/5.
//

import UIKit

@objcMembers class BLAssetsSendHisModel: BLBaseModel {
    var datas : [BLAssetsSendHisItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLAssetsSendHisItem.self]
    }
}


@objcMembers class BLAssetsSendHisItem: BLBaseModel {
    var isFairLaunchIssuance : String?
    var asset_name : String?
    var asset_id : String?
    var reserved_total : String?
    var asset_type : String?
    var issuance_time : String?
    var state : String?
}
