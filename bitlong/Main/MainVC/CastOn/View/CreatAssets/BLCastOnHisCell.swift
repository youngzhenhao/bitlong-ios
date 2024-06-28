//
//  BLCastOnHisCell.swift
//  bitlong
//
//  Created by slc on 2024/6/12.
//

import UIKit

let BLCastOnHisCellId = "BLCastOnHisCell"

class BLCastOnHisCell: BLBaseTableViewCell {
    
    let itemWidth = SCREEN_WIDTH/6.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(nameLbl)
        self.addSubview(idLbl)
        self.addSubview(numLbl)
        self.addSubview(gasLbl)
        self.addSubview(timeLbl)
        self.addSubview(statusLbl)
        
        nameLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        idLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(nameLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        numLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(idLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        gasLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(numLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(gasLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(itemWidth)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(timeLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(itemWidth)
        }
    }

    lazy var nameLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var idLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var numLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var gasLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 10*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var statusLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    func assignQueryOwnMintItem(item : BLLaunchQueryOwnMintItem){
        nameLbl.text = item.asset_name
        idLbl.text = item.asset_id
        numLbl.text = item.minted_number
        gasLbl.text = item.minted_gas_fee
        timeLbl.text = BLTools.getFormaterWithTimeStr(timeStr: item.minted_set_time! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
        statusLbl.text = self.getStutes(state: item.state!)
    }
    
    //阶段 0未支付 1支付进行中 2已支付未发行 3发行中 4已发行。此时可以进行11.进行公平发射资产的发行保留部分取回 5保留资产发送中 6保留资产已发送
    func getStutes(state : String) -> String{
        let state : Int32 = Int32(state)!
        switch state {
        case 0:
            return NSLocalized(key: "castOnSendUnpaid")
        case 1:
            return NSLocalized(key: "castOnSendPaing")
        case 2:
            return NSLocalized(key: "castOnSendPaidButNotIssued")
        case 3:
            return NSLocalized(key: "castOnSendIssueing")
        case 4:
            return NSLocalized(key: "castOnSendIssued")
        case 5:
            return NSLocalized(key: "castOnSendRetainedAssetsIssueing")
        case 6:
            return NSLocalized(key: "castOnSendRetainedAssetsIssued")
        default:
            return"--"
        }
    }
}
