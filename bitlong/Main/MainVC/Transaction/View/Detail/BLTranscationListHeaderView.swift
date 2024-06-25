//
//  BLTranscationListHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/21.
//

import UIKit

class BLTranscationListHeaderView: BLBaseView {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(timeLbl)
        self.addSubview(transactionPriceLbl)
        self.addSubview(turnoverLbl)
        self.addSubview(transactionVolumeLbl)
        self.addSubview(userLbl)
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.top.mas_equalTo()(16*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(35*SCALE)
        }
        
        transactionPriceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(timeLbl.mas_right)?.offset()(12*SCALE+56*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(56*SCALE)
        }
        
        turnoverLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(self.mas_centerX)?.offset()(20*SCALE)
            make?.top.mas_equalTo()(timeLbl.mas_top)
            make?.height.mas_equalTo()(32*SCALE)
            make?.width.mas_equalTo()(turnoverLbl.frame.width)
        }
        
        transactionVolumeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(self.mas_centerX)?.offset()(40*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(transactionVolumeLbl.frame.width)
        }
        
        userLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(userLbl.frame.width)
        }
    }
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "时间"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var transactionPriceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "成交价($)"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right

        return lbl
    }()
    
    lazy var turnoverLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "成交量\n(Rothschild)"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var transactionVolumeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "成交额($)"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var userLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "用户"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
}
