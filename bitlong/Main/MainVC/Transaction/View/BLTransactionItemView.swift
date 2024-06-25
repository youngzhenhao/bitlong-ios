//
//  BLTransactionItemView.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

class BLTransactionItemView: BLBaseView {
    
    let itemList : NSMutableArray = NSMutableArray.init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.creatItems()
        self.addSubview(lineLbl)
    }
    
    func creatItems(){
        for i in 0..<titleArr.count{
            let bt : UIButton =  UIButton.init()
            bt.setTitle((titleArr[i] as! String), for: .normal)
            bt.setTitleColor(UIColorHex(hex: i == 0 ? 0x383838 : 0x808080, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
            bt.addTarget(self, action: #selector(itemClickAcation(sender:)), for: .touchUpInside)
            bt.sizeToFit()
            self.addSubview(bt)
            itemList.add(bt)
        }
        
        for i in 0..<itemList.count{
            let bt : UIButton = itemList[i] as! UIButton
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                if i == 0{
                    make?.left.mas_equalTo()(15*SCALE)
                }else{
                    let lastBt : UIButton = itemList[i-1] as! UIButton
                    make?.left.mas_equalTo()(lastBt.mas_right)?.offset()(20*SCALE)
                }
                make?.size.mas_equalTo()(bt.frame.size)
                make?.centerY.mas_equalTo()(5*SCALE)
            }
        }
        
        let bt : UIButton = itemList.firstObject as! UIButton
        lineLbl.frame = CGRect(x: 15*SCALE, y: 46*SCALE, width: CGRectGetWidth(bt.frame), height: 4*SCALE)
    }
    
    lazy var titleArr : NSArray = {
        var arr = ["TAP20","NFT"]
        
        return arr as NSArray
    }()
    
    lazy var lineLbl : UILabel = {
        var lbl = UILabel.init(frame: .zero)
        lbl.backgroundColor = UIColorHex(hex: 0x7B71F2, a: 1.0)
        lbl.layer.cornerRadius = 2*SCALE
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    @objc func itemClickAcation(sender : UIButton){
        sender.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.lineLbl.frame = CGRect(x: CGRectGetMinX(sender.frame), y: 46*SCALE, width: CGRectGetWidth(sender.frame), height: 4*SCALE)
        }
        
        for obj in itemList{
            let bt : UIButton = obj as! UIButton
            if bt == sender{
                bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
            }else{
                bt.setTitleColor(UIColorHex(hex: 0x808080, a: 1.0), for: .normal)
            }
        }
    }
}
