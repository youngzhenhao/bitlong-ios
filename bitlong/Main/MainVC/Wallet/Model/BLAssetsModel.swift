//
//  BLAssetsModel.swift
//  bitlong
//
//  Created by slc on 2024/5/9.
//

import UIKit

@objcMembers class BLAssetsModel: BLBaseModel {
    var datas : [BLAssetsItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }

    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLAssetsItem.self]
    }
}

@objcMembers class BLAssetsItem: BLBaseModel {
    var genesis_point : String?
    var name : String?
    var meta_hash : String?
    var asset_id : String?
    var asset_type : String?
    var output_index : String?
    var version : String?
    var balance : NSString?
    
    override class func supportsSecureCoding() -> Bool {
        return true
    }
}
