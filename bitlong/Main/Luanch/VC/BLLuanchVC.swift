//
//  LuanchVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/28.
//

import UIKit

class BLLuanchVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    func initUI(){
        self.view.addSubview(imgView)
        self.view.addSubview(titleLbl)
        imgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(self.view)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
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
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "Taproot Assets 生 态 钱 包"
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
}
