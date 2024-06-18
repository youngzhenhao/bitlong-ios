//
//  BLSegmentView.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/8.
//

import UIKit

@objc protocol SegmentDelegate : NSObjectProtocol{
    func segmentAcation(sender : UIButton)
}

class BLSegmentView: BLBaseView {
    
    weak var delegate : SegmentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(mainLinkBt)
        self.addSubview(NFTBt)
        self.addSubview(creatChannelBt)
        self.addSubview(addBt)
        self.addSubview(bottomLineView)
        
        var leftSpeding : CGFloat = 30*SCALE
        mainLinkBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(8*SCALE)
            make?.left.mas_equalTo()(leftSpeding)
            make?.bottom.mas_equalTo()(-16*SCALE)
            make?.width.mas_equalTo()(mainLinkBt.frame.width)
        }
        
        leftSpeding += (NFTBt.frame.width + 27*SCALE)
        NFTBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(8*SCALE)
            make?.left.mas_equalTo()(leftSpeding)
            make?.bottom.mas_equalTo()(-16*SCALE)
            make?.width.mas_equalTo()(NFTBt.frame.width)
        }
        
        leftSpeding += (creatChannelBt.frame.width + 27*SCALE)
        creatChannelBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(leftSpeding)
            make?.centerY.mas_equalTo()(mainLinkBt.mas_centerY)
            make?.width.mas_equalTo()(creatChannelBt.frame.width)
            make?.height.mas_equalTo()(16*SCALE)
        }
        
        addBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(mainLinkBt.mas_centerY)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        bottomLineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(mainLinkBt.frame.width)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(4*SCALE)
            make?.left.mas_equalTo()(30*SCALE)
        }
    }
    
    lazy var mainLinkBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("资产", for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.sizeToFit()
        bt.tag = 100
        bt.addTarget(self, action: #selector(itemAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var NFTBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("NFT", for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.sizeToFit()
        bt.tag = 101
        bt.addTarget(self, action: #selector(itemAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var creatChannelBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("通道", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.setImage(imagePic(name: "ic_home_channel"), for: .normal)
        bt.sizeToFit()
        bt.tag = 102
        bt.iconInLeft(spacing: 4*SCALE)
        bt.addTarget(self, action: #selector(itemAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var addBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_home_add"), for: .normal)
        bt.tag = 103
        bt.addTarget(self, action: #selector(itemAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var bottomLineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x7B71F2, a: 1.0)
        view.layer.cornerRadius = 2*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    @objc func itemAcation(sender : UIButton){
        self.updateBottomLine(sender: sender)
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.segmentAcation(sender:)))) != nil{
            delegate?.segmentAcation(sender: sender)
        }
    }
    
    func setSelectedIndex(index : Int){
        if index < 3{
            let bt : UIButton = viewWithTag(100+index) as! UIButton
            self.updateBottomLine(sender: bt)
        }
    }
    
    func updateBottomLine(sender : UIButton){
        if sender.tag != 103{
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.bottomLineView.mas_updateConstraints { (make : MASConstraintMaker?) in
                    make?.width.mas_equalTo()(sender.frame.width)
                    make?.left.mas_equalTo()(CGRectGetMinX(sender.frame))
                }
                
                self?.layoutIfNeeded()
            }
        }
    }
}
