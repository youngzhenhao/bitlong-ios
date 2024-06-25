//
//  BLAssetsCoinDetailModel.swift
//  bitlong
//
//  Created by slc on 2024/6/4.
//

import UIKit

@objcMembers class BLAssetsCoinDetailModel: BLBaseModel {
    var assetId : String?
    var name : String?
    var point : String?
    var assetType : String?
    var assetIsGroup : String?
    var amount : String?
    var meta : BLAssetsCoinMetaItem?
    var createTime : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["descriptions": "description"]
    }
}


@objcMembers class BLAssetsCoinMetaItem: BLBaseModel {
    var descriptions : String?
    var image_data : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["descriptions": "description"]
    }
}
