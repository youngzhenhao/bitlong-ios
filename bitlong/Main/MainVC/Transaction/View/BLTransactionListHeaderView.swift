//
//  BLTransactionListHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

class BLTransactionListHeaderView: BLBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.creatItems()
    }
    
    func creatItems(){
        for i in 0..<itemList.count{
            autoreleasepool {
                let title : String = itemList[i] as! String
                let lbl : UILabel = UILabel.init()
                lbl.text = title
                lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
                lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
                lbl.sizeToFit()
                self.addSubview(lbl)
                if i == 0{
                    lbl.textAlignment = .left
                }else{
                    lbl.textAlignment = .right
                }
                lbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                    if i == 0{
                        make?.left.mas_equalTo()(20*SCALE)
                    }else if i == 1{
                        make?.right.mas_equalTo()(self.mas_centerX)?.offset()(60*SCALE)
                    }else{
                        make?.right.mas_equalTo()(-20*SCALE)
                    }
                    make?.size.mas_equalTo()(lbl.frame.size)
                    make?.centerY.mas_equalTo()(0)
                }
            }
        }
    }
    
    lazy var itemList : NSArray = {
        var arr = ["名称/交易额","热门榜","涨跌幅"]
        
        return arr as NSArray
    }()
}
