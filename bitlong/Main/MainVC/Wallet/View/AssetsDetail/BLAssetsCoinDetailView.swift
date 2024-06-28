//
//  BLAssetsCoinDetailView.swift
//  bitlong
//
//  Created by slc on 2024/6/4.
//

import UIKit

@objc protocol CoinDetailViewDelegate : NSObjectProtocol {
    func showAssetQR(qrStr : String)
}

class BLAssetsCoinDetailView: BLBaseView {
    
    weak var delegate : CoinDetailViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(assetsNameLbl)
        self.addSubview(assetsNameValueLbl)
        self.addSubview(assetsIdLbl)
        self.addSubview(assetsIdValueLbl)
        self.addSubview(copyBt)
        self.addSubview(sendNumLbl)
        self.addSubview(sendNumValueLbl)
        self.addSubview(sendDateLbl)
        self.addSubview(sendDateValueLbl)
        self.addSubview(sendCoinTypeLbl)
        self.addSubview(sendCoinTypeValueLbl)
        self.addSubview(canAddLbl)
        self.addSubview(canAddValueLbl)
        self.addSubview(recordsLbl)
        self.addSubview(recordsValueLbl)
        self.addSubview(descriptionLbl)
        self.addSubview(descriptionValueLbl)
        
        assetsNameLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(20*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(assetsNameLbl.frame.size)
        }
        
        assetsNameValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(assetsNameLbl.mas_right)?.offset()(10*SCALE)
            make?.width.mas_equalTo()(160*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(assetsNameLbl.mas_centerY)
        }
        
        assetsIdLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(assetsNameLbl.mas_bottom)?.offset()(20*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(assetsIdLbl.frame.size)
        }
        
        assetsIdValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(assetsIdLbl.mas_right)?.offset()(10*SCALE)
            make?.width.mas_equalTo()(160*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(assetsIdLbl.mas_centerY)
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(assetsIdValueLbl.mas_right)?.offset()(10*SCALE)
            make?.width.height().mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(assetsIdValueLbl.mas_centerY)
        }
        
        sendNumLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(assetsIdLbl.mas_bottom)?.offset()(20*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(sendNumLbl.frame.size)
        }
        
        sendNumValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendNumLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendNumLbl.mas_centerY)
        }
        
        sendDateLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendNumLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(sendDateLbl.frame.size)
        }
        
        sendDateValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendDateLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendDateLbl.mas_centerY)
        }
        
        sendCoinTypeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendDateLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(sendCoinTypeLbl.frame.size)
        }
        
        sendCoinTypeValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendCoinTypeLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendCoinTypeLbl.mas_centerY)
        }
        
        canAddLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendCoinTypeLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(canAddLbl.frame.size)
        }
        
        canAddValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(canAddLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(canAddLbl.mas_centerY)
        }
        
        recordsLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(canAddLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(recordsLbl.frame.size)
        }
        
        recordsValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(recordsLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(recordsLbl.mas_centerY)
        }
        
        descriptionLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(recordsLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(0)
            make?.size.mas_equalTo()(descriptionLbl.frame.size)
        }
        
        descriptionValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(descriptionLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(descriptionLbl.mas_centerY)
        }
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(descriptionLbl.mas_bottom)?.offset()(20*SCALE)
        }
    }
    
    lazy var assetsNameLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsName")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var assetsNameValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var assetsIdLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsAssetsId")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var assetsIdValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
        lbl.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(showAssetQR))
        lbl.addGestureRecognizer(tap)
        
        return lbl
    }()
    
    
    lazy var sendNumLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsSendNum")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var sendNumValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var sendDateLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsSendDate")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var sendDateValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var sendCoinTypeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsType")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var sendCoinTypeValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var canAddLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsCanAdd")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var canAddValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var recordsLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsOnChainRecords")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height)
        }
        
        return lbl
    }()
    
    lazy var recordsValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x2A82E4, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var descriptionLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "tokenDetailsIntroduction")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        if languageCode == .ZH{
            lbl.frame.size = CGSize.init(width: 80*SCALE, height: 18*SCALE)
        }else{
            let height : CGFloat = BLTools.textHeight(text: lbl.text!, font: lbl.font, width: 120*SCALE)
            lbl.frame.size = CGSize.init(width: 120*SCALE, height: height+5*SCALE)
        }
        
        return lbl
    }()
    
    lazy var descriptionValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var copyBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_copy"), for: .normal)
        bt.tag = 100
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
    
        return bt
    }()
    
    @objc func clickAcation(){
        if assetsIdValueLbl.text != nil{
            BLTools.pasteGeneral(string: assetsIdValueLbl.text as Any)
        }
    }
    
    @objc func showAssetQR(){
        if assetsIdValueLbl.text != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.showAssetQR(qrStr:)))) != nil{
                delegate?.showAssetQR(qrStr: assetsIdValueLbl.text!)
            }
        }
    }
    
    func assignCoinDetailModel(model : BLAssetsCoinDetailModel){
        if model.name != nil{
            assetsNameValueLbl.text = model.name
        }
        if model.assetId != nil{
            assetsIdValueLbl.text = model.assetId
        }
        if model.amount != nil{
            sendNumValueLbl.text = model.amount
        }
        if model.createTime != nil{
            sendDateValueLbl.text = BLTools.getFormaterWithTimeStr(timeStr: model.createTime! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
        }
        if model.assetType != nil{
            sendCoinTypeValueLbl.text = model.assetType
        }
        if model.assetIsGroup != nil{
            canAddValueLbl.text = model.assetIsGroup
        }
        if model.point != nil{
            recordsValueLbl.text = model.point
        }
        if model.meta != nil && model.meta!.descriptions != nil{
            descriptionValueLbl.text = model.meta!.descriptions
        }
    }
}
