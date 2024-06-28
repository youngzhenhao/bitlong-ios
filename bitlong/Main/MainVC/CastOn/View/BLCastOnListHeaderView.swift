//
//  BLCastOnListHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/15.
//

import UIKit

class BLCastOnListHeaderView: BLBaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
        self.creatItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.creatItems()
    }
    
    func creatItems(){
        var leftSpecing : CGFloat = 0
        for i in 0..<itemList.count{
            autoreleasepool {
                let title : String = itemList[i] as! String
                let lbl : UILabel = UILabel.init()
                lbl.text = title
                lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
                lbl.font = FONT_NORMAL(s: 16*Float(SCALE))
                lbl.textAlignment = .center
                self.addSubview(lbl)
                leftSpecing = 15*SCALE + CGFloat(i)*((SCREEN_WIDTH-30*SCALE)/4.0)
                lbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                    make?.left.mas_equalTo()(leftSpecing)
                    make?.width.mas_equalTo()((SCREEN_WIDTH-30*SCALE)/4.0)
                    make?.top.bottom().mas_equalTo()(0)
                }
                lbl.layoutIfNeeded()
            }
        }
    }
    
    lazy var itemList : NSArray = {
        var arr = [NSLocalized(key: "castOnListHeaderName"),
                   NSLocalized(key: "castOnListHeaderID"),
                   NSLocalized(key: "castOnListHeaderReserve"),
                   NSLocalized(key: "castOnListHeaderCast")]
        
        return arr as NSArray
    }()
}
