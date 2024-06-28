//
//  BLAssetsSendHisHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/6/5.
//

import UIKit

class BLAssetsSendHisHeaderView: BLBaseView {

    let width : CGFloat = (SCREEN_WIDTH - 20*SCALE)/5.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(coinLbl)
        self.addSubview(idLbl)
        self.addSubview(typeLbl)
        self.addSubview(timeLbl)
        self.addSubview(statusLbl)
        
        coinLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(width)
            make?.centerY.mas_equalTo()(0)
        }
        
        idLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(width)
            make?.centerY.mas_equalTo()(0)
        }
        
        typeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(idLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(width)
            make?.centerY.mas_equalTo()(0)
        }
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(typeLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(width)
            make?.centerY.mas_equalTo()(0)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(timeLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(width)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var coinLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHisToken")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var idLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHisID")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var typeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHisType")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHisTime")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var statusLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHisState")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
}
