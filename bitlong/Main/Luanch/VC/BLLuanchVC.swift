//
//  LuanchVC.swift
//  bitlong
//
//  Created by slc on 2024/4/28.
//

import UIKit

class BLLuanchVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        self.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initUI(){
        self.view.addSubview(imgView)
        self.view.addSubview(activityView)
        self.view.addSubview(loadingLabel)
        self.view.addSubview(adTitleLbl)
        imgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(self.view)
        }
        
        activityView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerY.mas_equalTo()(loadingLabel.mas_centerY)
            make?.right.mas_equalTo()(loadingLabel.mas_left)?.offset()(-5*SCALE)
            make?.width.height().mas_equalTo()(30*SCALE)
        }
        
        loadingLabel.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerX.mas_equalTo()(15*SCALE)
            make?.size.mas_equalTo()(loadingLabel.frame.size)
            make?.top.mas_equalTo()(2*(SCREEN_HEIGHT/3.0))
        }
        
        adTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.bottom.mas_equalTo()(-70*SCALE)
        }
    }
    
    lazy var imgView : UIImageView = {
        var img = UIImageView.init(image: imagePic(name: "ic_luanch_img"))
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    // 使用方式
    lazy var activityView : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView.init()
        // 停止后，隐藏菊花
        view.hidesWhenStopped = false
        view.color = UIColorHex(hex: 0x1EFA76, a: 1.0)
        view.style = .medium
        
        return view
    }()
    
    lazy var loadingLabel : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "钱包正在初始化中，请稍后"
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var adTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "Taproot Assets" + " " + NSLocalized(key: "walletTypeAdTitle")
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        let str : NSString = lbl.text! as NSString
        let range : NSRange = str.range(of: "Taproot Assets")
        let attr : NSMutableAttributedString = NSMutableAttributedString.init(string: str as String)
        attr.addAttribute(.font, value: FONT_NORMAL(s: 12*Float(SCALE)), range: range)
        lbl.attributedText = attr
        
        return lbl
    }()
    
    @objc func startAnimating(){
        activityView.startAnimating()
    }
    
    @objc func stopAnimating(){
        activityView.stopAnimating()
    }
}
