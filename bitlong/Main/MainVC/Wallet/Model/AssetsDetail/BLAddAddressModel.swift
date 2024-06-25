//
//  BLAddAddressModel.swift
//  bitlong
//
//  Created by slc on 2024/5/28.
//

import UIKit

@objcMembers class BLAddAddressModel: BLBaseModel {
    var name : String?
    var address : String?
    var balance : NSString?
    var address_type : String?
    var derivation_path : String?
    var is_internal : String?
    
    func height() -> CGFloat{
        if address != nil && 0 < address!.count{
            let width : CGFloat =  BLTools.textWidth(text: address!, font: FONT_BOLD(s: 13*Float(SCALE)), height: 14*SCALE)
            if SCREEN_WIDTH - 62*SCALE < width{
                return 32*SCALE
            }
            
            return 14*SCALE
        }
        
        return 14*SCALE
    }
}

//资产发票地址解码
@objcMembers class BLAssetAddressDecodeModel: BLBaseModel {
    var encoded : String?
    var asset_id : String?
    var asset_type : NSString?
    var amount : String?
    var group_key : String?
    var script_key : String?
    var internal_key : String?
    var tapscript_sibling : String?
    var taproot_output_key : String?
    var proof_courier_addr : String?
    var asset_version : String?
    //铸造新加
    var hashmail : String?
}

//闪电发票地址解码
@objcMembers class BLLightingAddressDecodeModel: BLBaseModel {
    var descriptions : String?
    var amount : String?
    var timestamp : NSString?
    var expiry : String?
    var payment_hash : String?
    var destination : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["descriptions": "description"]
    }
}
