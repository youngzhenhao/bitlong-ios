//
//  BLCreatAssetsConfirmView.swift
//  bitlong
//
//  Created by slc on 2024/6/11.
//

import UIKit

@objc protocol ConfirmDelegate : NSObjectProtocol {
    func confirmAcation()
}

class BLCreatAssetsConfirmView: BLBaseView {
    
    weak var delegate : ConfirmDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(containerView)
        containerView.addSubview(msgLbl)
        containerView.addSubview(cancelBt)
        containerView.addSubview(confirmBt)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(SCREEN_WIDTH-30*SCALE)
            make?.height.mas_equalTo()(130*SCALE)
            make?.center.mas_equalTo()(0)
        }
        
        msgLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        cancelBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.left.mas_equalTo()(30*SCALE)
            make?.right.mas_equalTo()(containerView.mas_centerX)?.offset()(-15*SCALE)
        }
        
        confirmBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(-30*SCALE)
            make?.left.mas_equalTo()(containerView.mas_centerX)?.offset()(15*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var msgLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatHandlingFees")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 15*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var cancelBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "castOnCreatCancelIssuance"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.backgroundColor = UIColorHex(hex: 0x7C70FF, a: 0.5)
        bt.layer.cornerRadius = 6*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(clickedAcation(sennder:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var confirmBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "castOnCreatConfirmIssuance"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 6*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(clickedAcation(sennder:)), for: .touchUpInside)
        
        return bt
    }()
    
    func assignTransactionFee(title: String,fee : String){
        msgLbl.text = title + fee
    }
    
    @objc func clickedAcation(sennder : UIButton){
        self.removeFromSuperview()
        self.alpha = 0
        
        if sennder == confirmBt{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.confirmAcation))) != nil{
                delegate?.confirmAcation()
            }
        }
    }
}
