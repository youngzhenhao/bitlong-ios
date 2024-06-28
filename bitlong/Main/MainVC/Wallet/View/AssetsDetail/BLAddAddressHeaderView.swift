//
//  BLAddAddressHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/28.
//

import UIKit

class BLAddAddressHeaderView: BLBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("· init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColorHex(hex: 0xF8F8F8, a: 1.0)
        self.addSubview(tipLblOne)
        self.addSubview(tipLblTwo)
        
        tipLblOne.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(20*SCALE)
            if SCREEN_WIDTH - 40*SCALE < tipLblOne.frame.width{
                make?.height.mas_equalTo()(32*SCALE)
            }else{
                make?.height.mas_equalTo()(15*SCALE)
            }
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        tipLblTwo.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.top.mas_equalTo()(tipLblOne.mas_bottom)?.offset()(6*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            if SCREEN_WIDTH - 40*SCALE < tipLblTwo.frame.width{
                make?.height.mas_equalTo()(40*SCALE)
            }else{
                make?.height.mas_equalTo()(15*SCALE)
            }
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        self.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(tipLblTwo.mas_bottom)?.offset()(16*SCALE)
        }
    }
    
    lazy var tipLblOne : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "addressMangerTipsOne")
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        lbl.attributedText = self.setAttributed(text: lbl.text! as NSString, attTextList: ["·","隔离见证、Taproot"])
        
        return lbl
    }()
    
    lazy var tipLblTwo : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "addressMangerTipsTwo")
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        lbl.attributedText = self.setAttributed(text: lbl.text! as NSString, attTextList: ["·"])
        
        return lbl
    }()
    
    func setAttributed(text : NSString, attTextList : NSArray) -> NSMutableAttributedString{
        let att : NSMutableAttributedString = NSMutableAttributedString.init(string: text as String)
        for obj in attTextList{
            let range : NSRange = text.range(of: obj as! String)
            if obj as! String == "·" {
                att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColorHex(hex: 0x2A82E4, a: 1.0), range: range)
                att.addAttribute(NSAttributedString.Key.font, value: FONT_BOLD(s: 20*Float(SCALE)), range: range)
            }else{
                att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColorHex(hex: 0x665AF0, a: 1.0), range: range)
            }
        }
        
        return att
    }
}
