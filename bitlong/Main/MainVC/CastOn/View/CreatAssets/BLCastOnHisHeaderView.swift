//
//  BLCastOnHisHeaderView.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/12.
//

import UIKit

class BLCastOnHisHeaderView: BLAssetsSendHisHeaderView {
    
    let itemWidth = SCREEN_WIDTH/6.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initUI(){
        self.addSubview(coinLbl)
        self.addSubview(idLbl)
        self.addSubview(numLbl)
        self.addSubview(gasLbl)
        self.addSubview(timeLbl)
        self.addSubview(statusLbl)
        
        coinLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        idLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinLbl.mas_right)?.offset()(0)
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
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(timeLbl.mas_right)?.offset()(0)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(itemWidth)
            make?.centerY.mas_equalTo()(0)
        }
    }

    lazy var numLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "数量"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var gasLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "Gas"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()

}
