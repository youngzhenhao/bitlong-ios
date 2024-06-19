//
//  BLTransactionHeaderView.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/7.
//

import UIKit

class BLTransactionHeaderView: BLBaseView,UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.addSubview(bgView)
        self.addSubview(searchView)
        searchView.addSubview(searchImgView)
        searchView.addSubview(searchTextField)
        self.addSubview(bannerView)
        
        bgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_equalTo()(SCREEN_WIDTH/1.89)
        }
        
        searchView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(StatusBarHeight + 16*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()((SCREEN_WIDTH - 32*SCALE)/9.94)
        }
        
        searchImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.width.height().mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        searchTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(searchImgView.mas_right)?.offset()(7*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(8*SCALE)
            make?.bottom.mas_equalTo()(-8*SCALE)
        }
        
        bannerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(searchView.mas_bottom)?.offset()(16*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()((SCREEN_WIDTH - 32*SCALE)/3.0)
        }
        
        BLTools.topColorChange(view: bgView, colorBegin: UIColorHex(hex: 0xD3CFFC, a: 1.0), colorEnd: UIColorHex(hex: 0xD3CFFC, a: 0.0), direction: 0)
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(bannerView.mas_bottom)
        }
    }
    
    lazy var bgView : UIView = {
        var view = UIView.init()
        
        return view
    }()
    
    lazy var searchView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        view.layer.cornerRadius = 15*SCALE
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
        field.attributedPlaceholder = NSAttributedString.init(string:"搜索Tapr20、NFT", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14*SCALE),NSAttributedString.Key.foregroundColor:UIColor(hex: "0xA6A6A6", alpha: 1.0)])
        field.delegate = self

        return field
    }()
    
    lazy var bannerView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_banner"))
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
