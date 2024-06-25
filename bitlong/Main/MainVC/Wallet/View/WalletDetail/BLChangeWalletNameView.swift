//
//  BLChangeWalletNameView.swift
//  bitlong
//
//  Created by slc on 2024/6/17.
//

import UIKit

typealias CallBack = (_ name : String) -> ()

class BLChangeWalletNameView: BLBaseView {

    var callBack : CallBack?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(closeBt)
        containerView.addSubview(lineView)
        containerView.addSubview(textField)
        containerView.addSubview(confirmBt)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.bottom.mas_greaterThanOrEqualTo()(confirmBt.mas_bottom)?.offset()(30*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(15*SCALE)
            make?.left.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(-40*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
        }
        
        closeBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(50*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(1*SCALE)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineView.mas_bottom)?.offset()(20*SCALE)
            make?.left.mas_equalTo()(70*SCALE)
            make?.right.mas_equalTo()(-70*SCALE)
            make?.height.mas_equalTo()(45*SCALE)
        }
        
        confirmBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(textField.mas_bottom)?.offset()(30*SCALE)
            make?.left.mas_equalTo()(textField.mas_left)
            make?.right.mas_equalTo()(textField.mas_right)
            make?.height.mas_equalTo()(40*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "修改钱包名称"
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x383838, a: 0.8)
        
        return view
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.placeholder = "请输入钱包名"
        field.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        field.font = FONT_NORMAL(s: 14*Float(SCALE))
        field.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        field.leftViewMode = .always
        field.layer.cornerRadius = 6*SCALE
        field.clipsToBounds = true
        
        return field
    }()
    
    lazy var closeBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_close"), for: .normal)
        bt.addTarget(self, action: #selector(closeAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var confirmBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("确认修改", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s:14*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.addTarget(self, action: #selector(changeWalletName), for: .touchUpInside)
        bt.layer.cornerRadius = 22*SCALE
        bt.clipsToBounds = true
        
        return bt
    }()
    
    @objc func closeAcation(){
        self.removeFromSuperview()
    }
    
    @objc func changeWalletName(){
        if textField.text!.count <= 0{
            BLTools.showTost(tip: "请输入钱包名称", superView: BLTools.getCurrentVC().view)
        }
        
        if callBack != nil{
            callBack!(textField.text!)
            self.closeAcation()
        }
    }
}
