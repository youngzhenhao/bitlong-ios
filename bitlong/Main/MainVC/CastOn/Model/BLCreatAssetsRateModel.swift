//
//  BLCreatAssetsRateModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/11.
//

import UIKit

@objcMembers class BLCreatAssetsRateModel: BLBaseModel {
    var sat_per_kw : String?
    var sat_per_b : String?
    var btc_per_kb : String?
}

@objcMembers class BLCastOnQueryMintModel: BLBaseModel {
    var calculated_fee_rate_sat_per_b : String?
    var calculated_fee_rate_sat_per_kw : String?
    var inventory_amount : String?
    var is_mint_available : String?
}

@objcMembers class BLCastOnQueryInventoryMintNumberModel: BLBaseModel {
    var number : String?
    var amount : String?
}
