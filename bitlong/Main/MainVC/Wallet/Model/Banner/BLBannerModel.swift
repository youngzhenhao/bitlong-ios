//
//  BLBannerModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

@objcMembers class BLBannerModel: BLBaseModel {
    var list : [BLBannerItem]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["list": BLBannerItem.self]
    }
}

@objcMembers class BLBannerItem: BLBaseModel {
    var id : String?
    var title : String?
    var image : String?
    var status : String?
    var category : String?
    var created_at : String?
    var updated_at : String?
}
