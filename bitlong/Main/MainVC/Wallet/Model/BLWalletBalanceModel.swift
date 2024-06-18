//
//  BLWalletBalanceModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/9.
//

import UIKit

@objcMembers class BLWalletBalanceModel: BLBaseModel {
    var total_balance : NSString?
    var confirmed_balance : NSString?
    var unconfirmed_balance : NSString?
    var locked_balance : String?
    var reserved_balance_anchor_chan : String?
    var account_balance : NSDictionary?
}


//{
//    "total_balance":  "999969442",
//    "confirmed_balance":  "999969442",
//    "unconfirmed_balance":  "0",
//    "locked_balance":  "0",
//    "reserved_balance_anchor_chan":  "0",
//    "account_balance":  {
//        "alice":  {
//            "confirmed_balance":  "73270",
//            "unconfirmed_balance":  "0"
//        },
//        "default":  {
//            "confirmed_balance":  "999892172",
//            "unconfirmed_balance":  "0"
//        },
//        "imported":  {
//            "confirmed_balance":  "4000",
//            "unconfirmed_balance":  "0"
//        }
//    }
//}

