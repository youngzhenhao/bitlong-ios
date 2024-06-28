//
//  BLCollectionHisHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

class BLCollectionHisHeaderView: BLBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(amountLbl)
        self.addSubview(statusLbl)
        self.addSubview(timeLbl)
        
        amountLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(20*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerX.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var amountLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "collectionInvoiceAmount")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var statusLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "collectionInvoiceStatus")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "collectionInvoiceDate")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
}
