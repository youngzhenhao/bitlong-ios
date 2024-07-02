//
//  BLBottomView.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

class BLBottomView: BLBaseView {
    
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
        
        imgLeftView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(70*SCALE)
            make?.bottom.mas_equalTo()(-14*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
            make?.height.mas_equalTo()(45*SCALE)
        }
        
        imgRightView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(164*SCALE)
            make?.width.mas_equalTo()(365*SCALE)
            make?.height.mas_equalTo()(198*SCALE)
            make?.bottom.mas_equalTo()(140*SCALE)
        }
    }
    
    lazy var imgLeftView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_initWallet_coin")
        
        return view
    }()
    
    lazy var imgRightView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_initWallet_bottomR")
        
        return view
    }()
    
}
