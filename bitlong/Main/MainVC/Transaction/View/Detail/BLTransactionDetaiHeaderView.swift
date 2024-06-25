//
//  BLTransactionDetaiHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

@objc protocol DetaiHeaderDelegate : NSObjectProtocol {
    func backAcation()
}

class BLTransactionDetaiHeaderView: BLBaseView {
    
    weak var delegate : DetaiHeaderDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(backBt)
        self.addSubview(iconImgView)
        self.addSubview(titleLbl)
        self.addSubview(detailBt)
        self.addSubview(lineHLbl)
        self.addSubview(lineVLbl)
        self.addSubview(transaction24TitleLbl)
        self.addSubview(transaction24ValueLbl)
        self.addSubview(holderTitleLbl)
        self.addSubview(holderValueLbl)
        self.addSubview(floorPriceTitleLbl)
        self.addSubview(floorPriceValueLbl)
        self.addSubview(transactionTitleLbl)
        self.addSubview(transactionValueLbl)
        self.addSubview(marketTitleLbl)
        self.addSubview(marketValueLbl)
        
        backBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(24*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.width.height().mas_equalTo()(32*SCALE)
        }
        
        iconImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(20*SCALE)
            make?.left.mas_equalTo()(backBt.mas_right)?.offset()(10*SCALE)
            make?.width.height().mas_equalTo()(40*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(iconImgView.mas_right)?.offset()(8*SCALE)
            make?.width.mas_equalTo()(120*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(iconImgView.mas_centerY)
        }
        
        detailBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-16*SCALE)
            make?.width.mas_equalTo()(60*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.centerY.mas_equalTo()(iconImgView.mas_centerY)
        }
        detailBt.iconInRight(with: 6*SCALE)
        
        lineHLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(iconImgView.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(detailBt.mas_right)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
        
        lineVLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineHLbl.mas_bottom)?.offset()(12*SCALE)
            make?.centerX.mas_equalTo()(0)
            make?.width.mas_equalTo()(0.5*SCALE)
            make?.bottom.mas_equalTo()(-12*SCALE)
        }
        
        transaction24TitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineHLbl.mas_bottom)?.offset()(12*SCALE)
            make?.left.mas_equalTo()(lineHLbl.mas_left)
            make?.width.mas_equalTo()(transaction24TitleLbl.frame.width)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        transaction24ValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(lineVLbl.mas_left)?.offset()(-20*SCALE)
            make?.centerY.mas_equalTo()(transaction24TitleLbl.mas_centerY)
            make?.left.mas_equalTo()(transaction24TitleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        holderTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(transaction24TitleLbl.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(lineHLbl.mas_left)
            make?.width.mas_equalTo()(holderTitleLbl.frame.width)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        holderValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(lineVLbl.mas_left)?.offset()(-20*SCALE)
            make?.centerY.mas_equalTo()(holderTitleLbl.mas_centerY)
            make?.left.mas_equalTo()(holderTitleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        floorPriceTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(holderTitleLbl.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(lineHLbl.mas_left)
            make?.width.mas_equalTo()(floorPriceTitleLbl.frame.width)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        floorPriceValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(lineVLbl.mas_left)?.offset()(-20*SCALE)
            make?.centerY.mas_equalTo()(floorPriceTitleLbl.mas_centerY)
            make?.left.mas_equalTo()(floorPriceTitleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        transactionTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(lineVLbl.mas_right)?.offset()(20*SCALE)
            make?.centerY.mas_equalTo()(transaction24TitleLbl.mas_centerY)
            make?.width.mas_equalTo()(transactionTitleLbl.frame.width)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        transactionValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(transactionTitleLbl.mas_centerY)
            make?.left.mas_equalTo()(transactionTitleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        marketTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(lineVLbl.mas_right)?.offset()(20*SCALE)
            make?.centerY.mas_equalTo()(holderTitleLbl.mas_centerY)
            make?.width.mas_equalTo()(marketTitleLbl.frame.width)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        marketValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(marketTitleLbl.mas_centerY)
            make?.left.mas_equalTo()(marketTitleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(floorPriceTitleLbl.mas_bottom)?.offset()(12*SCALE)
        }
    }
    
    lazy var backBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_back_black"), for: .normal)
        bt.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var iconImgView : UIImageView = {
        var img = UIImageView.init()
        img.image = imagePic(name: "ic_bit")
        
        return img
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "BTC"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var detailBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("详情", for: .normal)
        bt.setImage(imagePic(name: "ic_transaction_next"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x665AF0, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        
        return bt
    }()
    
    lazy var lineHLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1.0)
        
        return lbl
    }()
    
    lazy var lineVLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        
        return lbl
    }()
    
    lazy var transaction24TitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "24小时交易额"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var transaction24ValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var holderTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "持有人"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var holderValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var floorPriceTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "地板价"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var floorPriceValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var transactionTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "交易额"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var transactionValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var marketTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "市值"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var marketValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    @objc func back(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.backAcation))) != nil{
            delegate?.backAcation()
        }
    }
}
