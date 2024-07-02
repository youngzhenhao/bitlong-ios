//
//  BLNoticeModel.swift
//  bitlong
//
//  Created by slc on 2024/6/28.
//

import UIKit

@objcMembers class BLNoticeModel: BLBaseModel {
    var list : [BLNoticeListItem]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["list": BLNoticeListItem.self]
    }
}

@objcMembers class BLNoticeListItem: BLBaseModel {
    var id : String?
    var title : String?
    var content : String?
    var category : String?
    var language : String?
    var pin : String?
    var status : String?
    var created_at : String?
    var updated_at : String?
}
