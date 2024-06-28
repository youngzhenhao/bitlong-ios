//
//  BLCastOnHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/15.
//

import UIKit

@objc protocol CastOnDelegate : NSObjectProtocol {
    func clickAcation(sender : UIButton)
}

class BLCastOnHeaderView: BLBaseView,UITextFieldDelegate {
    
    @objc weak var delegate : CastOnDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(searchView)
        searchView.addSubview(searchImgView)
        searchView.addSubview(searchTextField)
        self.addSubview(creatAssetBt)
        self.addSubview(castONOutBt)
        
        searchView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(StatusBarHeight+15*SCALE)
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        searchImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.width.height().mas_equalTo()(12*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        searchTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(searchImgView.mas_right)?.offset()(20*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-30*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        creatAssetBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.top.mas_equalTo()(searchView.mas_bottom)?.offset()(25*SCALE)
            make?.width.mas_equalTo()((SCREEN_WIDTH-60*SCALE)/2.0)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        castONOutBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(searchView.mas_bottom)?.offset()(25*SCALE)
            make?.width.mas_equalTo()((SCREEN_WIDTH-60*SCALE)/2.0)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(creatAssetBt.mas_bottom)
        }
    }
    
    func showOfPageIDO(){
        searchView.removeAllSubviews()
        searchView.removeFromSuperview()
        creatAssetBt.mas_updateConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(25*SCALE)
        }
        
        castONOutBt.mas_updateConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(25*SCALE)
        }
        
        creatAssetBt.setTitle("发布", for: .normal)
        castONOutBt.setTitle("参与", for: .normal)
    }
    
    lazy var searchView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        view.layer.cornerRadius = 20*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var searchImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_search_img"))
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    lazy var searchTextField : UITextField = {
        var field = UITextField.init()
        field.textColor = .black
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:NSLocalized(key: "castOnSearchHolder"), attributes: [NSAttributedString.Key.font:FONT_BOLD(s: 14*Float(SCALE)),NSAttributedString.Key.foregroundColor:UIColor(hex: "0x383838", alpha: 1.0)])
        field.delegate = self

        return field
    }()
    
    lazy var creatAssetBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "castOnSearchSend"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 0.1)
        bt.layer.cornerRadius = 6*SCALE
        bt.clipsToBounds = true
        bt.tag = 100
        bt.addTarget(self, action: #selector(clickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var castONOutBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "castOnSearchCasting"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x2A82E4, a: 0.1)
        bt.layer.cornerRadius = 6*SCALE
        bt.clipsToBounds = true
        bt.tag = 101
        bt.addTarget(self, action: #selector(clickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func clickAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.clickAcation(sender:)))) != nil{
            delegate?.clickAcation(sender: sender)
        }
    }
}
