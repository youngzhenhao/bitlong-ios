//
//  BLCollectionView.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/14.
//

import UIKit

@objc protocol CollectionDelegate : NSObjectProtocol{
    func itemClickAcation(sender : UIButton,address : String)
}

var viewHeight : CGFloat = 0

class BLCollectionView: BLBaseView {
    
    @objc weak var delegate : CollectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(titleLbl)
        self.addSubview(qrImgView)
        self.addSubview(containerView)
        containerView.addSubview(collectionAddressTitleLbl)
        containerView.addSubview(collectionAddressLbl)
        containerView.addSubview(changeAddressBt)
        self.addSubview(shareBt)
        self.addSubview(copyBt)
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(30*SCALE)
            make?.size.mas_equalTo()(titleLbl.frame.size)
            make?.centerX.mas_equalTo()(0)
        }
        
        qrImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(50*SCALE)
            make?.width.height().mas_equalTo()(145*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(qrImgView.mas_bottom)?.offset()(50*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(130*SCALE)
        }
        
        collectionAddressTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(12*SCALE)
            make?.size.mas_equalTo()(titleLbl.frame.size)
            make?.centerX.mas_equalTo()(0)
        }
        
        collectionAddressLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(collectionAddressTitleLbl.mas_bottom)?.offset()(6*SCALE)
            make?.left.mas_equalTo()(30*SCALE)
            make?.right.mas_equalTo()(-30*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        changeAddressBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(collectionAddressLbl.mas_bottom)?.offset()(10*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        shareBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(69*SCALE)
            make?.top.mas_equalTo()(containerView.mas_bottom)?.offset()(12*SCALE)
            make?.width.mas_equalTo()(58*SCALE)
            make?.height.mas_equalTo()(24*SCALE)
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-69*SCALE)
            make?.centerY.mas_equalTo()(shareBt.mas_centerY)?.offset()(0)
            make?.width.mas_equalTo()(58*SCALE)
            make?.height.mas_equalTo()(24*SCALE)
        }
        
        self.layoutIfNeeded()
        viewHeight = CGRectGetMaxY(copyBt.frame) + 15*SCALE
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "扫一扫，向我支付"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var qrImgView : UIImageView = {
        var view = UIImageView.init()
        view.backgroundColor = .gray
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var collectionAddressTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "收款地址"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var collectionAddressLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var changeAddressBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("切换地址", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 12*Float(SCALE))
        bt.layer.borderColor = UIColorHex(hex: 0x665AF0, a: 1.0).cgColor
        bt.layer.borderWidth = 1*SCALE
        bt.layer.cornerRadius = 4*SCALE
        bt.clipsToBounds = true
        bt.sizeToFit()
        bt.tag = 100
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var shareBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_walletDetail_share"), for: .normal)
        bt.tag = 101
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var copyBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_walletDetail_copy"), for: .normal)
        bt.tag = 102
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func clickAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.itemClickAcation(sender:address:)))) != nil{
            delegate?.itemClickAcation(sender: sender,address: collectionAddressLbl.text ?? "")
        }
    }
    
    @objc func assignCollectionInfo(address : String){
        collectionAddressLbl.text = address
        if let qrImg : UIImage = BLTools.generateQRCode(for: address){
            qrImgView.image = qrImg
        }
    }
}
