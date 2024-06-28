//
//  BLAssetsDetailItemView.swift
//  bitlong
//
//  Created by slc on 2024/5/30.
//

import UIKit

@objc protocol DetailItemViewDelegate : NSObjectProtocol {
    func itemSelectAcation(sender : UIButton)
}

class BLAssetsDetailItemView: BLBaseView {
    
    weak var delegate : DetailItemViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(changeIntoBt)
        self.addSubview(changeOutBt)
        self.addSubview(lineView)
        
        let width : CGFloat = (SCREEN_WIDTH-40*SCALE) / 4.0
        changeIntoBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.size.mas_equalTo()(changeIntoBt.frame.size)
            make?.centerY.mas_equalTo()(0)
            make?.centerX.mas_equalTo()(self.mas_centerX)?.offset()(-(width - changeIntoBt.frame.width/2 + 10*SCALE))
        }
        
        changeOutBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.size.mas_equalTo()(changeIntoBt.frame.size)
            make?.centerY.mas_equalTo()(0)
            make?.centerX.mas_equalTo()(self.mas_centerX)?.offset()(width - changeIntoBt.frame.width/2 + 10*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(0)
            make?.height.mas_equalTo()(3*SCALE)
            make?.left.mas_equalTo()(changeIntoBt.mas_left)
            make?.right.mas_equalTo()(changeIntoBt.mas_right)
        }
    }
    
    lazy var changeIntoBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "assetsDetailsToChangeInto"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x2A82E4, a: 0.5), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x2A82E4, a: 1.0), for: .selected)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.tag = 100
        bt.sizeToFit()
        bt.isSelected = true
        bt.addTarget(self, action: #selector(changeAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var changeOutBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "assetsDetailsTransferOut"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x2A82E4, a: 0.5), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x2A82E4, a: 1.0), for: .selected)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.tag = 101
        bt.sizeToFit()
        bt.addTarget(self, action: #selector(changeAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x2A82E4, a: 1.0)
        
        return view
    }()
    
    @objc func changeAcation(sender : UIButton){
        if sender.isSelected{
            return
        }
        
        sender.isSelected = !sender.isSelected
        
        if sender == changeIntoBt{
            changeOutBt.isSelected = false
        }else if sender == changeOutBt{
            changeIntoBt.isSelected = false
        }
        
        lineView.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(0)
            make?.height.mas_equalTo()(2*SCALE)
            make?.left.mas_equalTo()(sender.mas_left)
            make?.right.mas_equalTo()(sender.mas_right)
        }
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.itemSelectAcation(sender:)))) != nil{
            delegate?.itemSelectAcation(sender: sender)
        }
    }
}
