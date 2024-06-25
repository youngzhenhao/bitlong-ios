//
//  BLToolItemsView.swift
//  bitlong
//
//  Created by slc on 2024/6/3.
//

import UIKit

@objc protocol ToolItemClickDelegate : NSObjectProtocol {
    func itemsClicked(sender : UIButton)
}

class BLToolItemsView: BLBaseView {
    
    @objc weak var delegate : ToolItemClickDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.creatsItems()
    }
    
    func creatsItems(){
        for i in 0..<titles.count {
            let bt : UIButton = UIButton.init()
            bt.setTitle((titles[i] as! String), for: .normal)
            bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
            if i%2 != 0 || (i == titles.count-1) {
                bt.backgroundColor = UIColorHex(hex: 0x2A82E4, a: 0.1)
            }else{
                bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 0.1)
            }
            bt.tag = 100+i
            bt.layer.cornerRadius = 4*SCALE
            bt.clipsToBounds = true
            bt.addTarget(self, action: #selector(itemClicked(sender:)), for: .touchUpInside)
            self.addSubview(bt)
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(CGFloat(i/2)*(100*SCALE))
                make?.height.mas_equalTo()(60*SCALE)
                if i == titles.count-1{
                    make?.width.mas_equalTo()(SCREEN_WIDTH-40*SCALE)
                    make?.left.mas_equalTo()(20*SCALE)
                }else{
                    make?.width.mas_equalTo()((SCREEN_WIDTH-80*SCALE)/2.0)
                    if i%2 == 0{
                        make?.left.mas_equalTo()(20*SCALE)
                    }else{
                        make?.right.mas_equalTo()(-20*SCALE)
                    }
                }
            }
            
            if i == titles.count-1{
                self.mas_makeConstraints { (make : MASConstraintMaker?) in
                    make?.bottom.mas_equalTo()(bt.mas_bottom)?.offset()(20*SCALE)
                }
            }
        }
    }
    
    lazy var titles : NSArray = {
        var arr = ["浏览器","锁仓","多签","批量转账","多条件支出","销毁","IDO"]
        
        return arr as NSArray
    }()
    
    @objc func itemClicked(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.itemsClicked(sender:)))) != nil{
            delegate?.itemsClicked(sender: sender)
        }
    }
}
