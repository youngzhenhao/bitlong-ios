//
//  BLTransactionTimeItemView.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/20.
//

import UIKit

@objc protocol TimeItemDelegate : NSObjectProtocol {
    func itemClickAcation(index : NSInteger)
}

class BLTransactionTimeItemView: BLBaseView {
    
    let itemObjList : NSMutableArray = NSMutableArray.init()
    weak var delegate : TimeItemDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColorHex(hex: 0x665AF0, a: 0.1)
        self.creatTimeItem()
    }
    
    func creatTimeItem(){
        for i in 0..<itemList.count{
            autoreleasepool {
                let bt : UIButton = UIButton.init()
                bt.setTitle((itemList[i] as! String), for: .normal)
                bt.setTitleColor(UIColorHex(hex: 0x665AF0, a: 1.0), for: .normal)
                bt.titleLabel?.font = FONT_NORMAL(s: 12*Float(SCALE))
                bt.tag = i
                bt.addTarget(self, action: #selector(itemClickAcation(sender:)), for: .touchUpInside)
                bt.sizeToFit()
                
                itemObjList.add(bt)
            }
        }
        
        for i in 0..<itemObjList.count{
            let bt : UIButton = itemObjList[i] as! UIButton
            self.addSubview(bt)
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                if i == 0{
                    make?.left.mas_equalTo()(10*SCALE)
                }else{
                    let lastBt : UIButton = itemObjList[i-1] as! UIButton
                    make?.left.mas_equalTo()(lastBt.mas_right)?.offset()(10*SCALE)
                }
                make?.top.bottom().mas_equalTo()(0)
                make?.width.mas_equalTo()(bt.frame.width)
            }
        }
    }
    
    lazy var itemList : NSArray = {
        var list = ["1分","5分","30分","1时","4时","1天","1周","更多","指标"]
        
        return list as NSArray
    }()
    
    @objc func itemClickAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.itemClickAcation(index:)))) != nil{
            delegate?.itemClickAcation(index: sender.tag)
        }
    }
}
