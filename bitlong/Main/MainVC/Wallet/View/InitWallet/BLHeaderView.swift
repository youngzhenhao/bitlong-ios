//
//  BLHeaderView.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

class BLHeaderView: BLBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(imgLeftView)
        self.addSubview(imgRightView)
        self.addSubview(imgMidView)
        self.addSubview(titleLbl)
        
        imgLeftView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(-103*SCALE)
            make?.width.mas_equalTo()(365*SCALE)
            make?.height.mas_equalTo()(206*SCALE)
            make?.left.mas_equalTo()(-145*SCALE)
        }
        
        imgRightView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-30*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
            make?.height.mas_equalTo()(47*SCALE)
            make?.bottom.mas_equalTo()(imgLeftView.mas_bottom)?.offset()(-20*SCALE)
        }
        
        imgMidView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(50*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
            make?.height.mas_equalTo()((SCREEN_WIDTH - 100*SCALE)/1.5)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(imgMidView.mas_bottom)?.offset()(4*SCALE)
            make?.left.mas_equalTo()(37*SCALE)
            make?.right.mas_equalTo()(-37*SCALE)
            make?.height.mas_equalTo()(22*SCALE)
        }
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(titleLbl.mas_bottom)
        }
    }
    
    lazy var imgLeftView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_initWallet_headerL")
        
        return view
    }()
    
    lazy var imgRightView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_initWallet_coin")
        
        return view
    }()
    
    lazy var imgMidView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_initWallet_headerM")
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "creatWalletAdTitle")
        lbl.font = FONT_BOLD(s: 20*Float(SCALE))
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.textAlignment = .center
        
        return lbl
    }()
}
