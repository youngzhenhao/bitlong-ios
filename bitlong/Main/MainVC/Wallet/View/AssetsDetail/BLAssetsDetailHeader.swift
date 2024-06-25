//
//  BLAssetsDetailHeader.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/13.
//

import UIKit

@objc protocol DetailHeaderDelegate : NSObjectProtocol {
    func assetsDetailAcation()
}

class BLAssetsDetailHeader: BLBaseView {

    let bottomItemList : NSMutableArray = NSMutableArray.init()
    var headerHeight : CGFloat = 0
    weak var delegate : DetailHeaderDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(iconImgView)
        self.addSubview(titleLbl)
        self.addSubview(detailBt)
        self.addSubview(lineLbl)
        self.addSubview(assetsBalanceLbl)
        self.addSubview(balanceCNY)
        self.addSubview(balanceUSD)
        self.addSubview(bottomLine)
        iconImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.left.mas_equalTo()(15*SCALE)
            make?.width.height().mas_equalTo()(30*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(iconImgView.mas_right)?.offset()(10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(iconImgView.mas_centerY)
        }
        
        detailBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.width.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        lineLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(iconImgView.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
        
        assetsBalanceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(iconImgView.mas_bottom)?.offset()(35*SCALE)
            make?.left.mas_equalTo()(30*SCALE)
            make?.width.mas_equalTo()(assetsBalanceLbl.frame.width)
            make?.height.mas_equalTo()(16*SCALE)
        }
        
        balanceCNY.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(assetsBalanceLbl.mas_right)?.offset()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.bottom.mas_equalTo()(assetsBalanceLbl.mas_centerY)?.offset()(-5*SCALE)
        }
        
        balanceUSD.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(assetsBalanceLbl.mas_centerY)?.offset()(5*SCALE)
            make?.left.mas_equalTo()(balanceCNY.mas_left)
            make?.right.mas_equalTo()(balanceCNY.mas_right)
            make?.height.mas_equalTo()(14*SCALE)
        }
        
        detailBt.iconInRight(with: 6*SCALE)
    }
    
    lazy var iconImgView : UIImageView = {
        var imgView = UIImageView.init()
        imgView.image = imagePic(name: "ic_bit")
        
        return imgView
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "--"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var detailBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("详情", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x665AF0, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 13*Float(SCALE))
        bt.setImage(imagePic(name: "ic_wallet_next"), for: .normal)
        bt.addTarget(self, action: #selector(assetsDetailClicked), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var lineLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = UIColorHex(hex: 0x383838, a: 1.0)
        
        return lbl
    }()
    
    lazy var assetsBalanceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "资产余额"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var balanceCNY : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "0"
        lbl.textColor = UIColorHex(hex: 0xEB5A5A, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var balanceUSD : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$0"
        lbl.textColor = .gray
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    func getItems(){
        for i in 0..<itemList.count {
            autoreleasepool {
                let titleBt : UIButton = UIButton.init()
                titleBt.setTitle((itemList[i] as! String), for: .normal)
                titleBt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
                titleBt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
                titleBt.sizeToFit()
                self.addSubview(titleBt)
                titleBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                    make?.top.mas_equalTo()(assetsBalanceLbl.mas_bottom)?.offset()(35*SCALE)
                    make?.height.mas_equalTo()(14*SCALE)
                    make?.width.mas_equalTo()(titleBt.frame.width)
                    if i == 0 {
                        make?.left.mas_equalTo()(35*SCALE)
                    }else if i == 1{
                        make?.centerX.mas_equalTo()(0)
                    }else{
                        make?.right.mas_equalTo()(-35*SCALE)
                    }
                }
                
                let valueBt : UIButton = UIButton.init()
                valueBt.setTitle("0 sats", for: .normal)
                valueBt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
                valueBt.titleLabel?.font = FONT_BOLD(s: 12*Float(SCALE))
                bottomItemList.add(valueBt)
                self.addSubview(valueBt)
                valueBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                    make?.top.mas_equalTo()(titleBt.mas_bottom)?.offset()(15*SCALE)
                    make?.width.mas_equalTo()(SCREEN_WIDTH/4.0)
                    make?.centerX.mas_equalTo()(titleBt)
                    make?.height.mas_equalTo()(12*SCALE)
                }
            }
        }
    }
    
    lazy var bottomLine : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        
        return view
    }()
    
    lazy var itemList : NSArray = {
        var list = NSArray.init(objects: "可用余额","待确认","锁定")
        
        return list
    }()
    
    @objc func assetsDetailClicked(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.assetsDetailAcation))) != nil{
            delegate?.assetsDetailAcation()
        }
    }
    
    func assignAssets(item : Any,type:AssetsDetailType){
        iconImgView.image = imagePic(name: "ic_bit")
        if type == .BTCType{
            titleLbl.text = "BTC"
            detailBt.isHidden = true
        }else if type == .assetsType{
            detailBt.isHidden = false
            if item is BLAssetsItem{
                let assetsItem : BLAssetsItem = item as! BLAssetsItem
                titleLbl.text = assetsItem.name ?? "--"
                DispatchQueue.global().async { [weak self] in
                    let meta : ApiMeta = ApiMeta.init(nil)!
                    meta.fetchAssetMeta(false, data: assetsItem.asset_id)
                    let data = meta.getImage()
                    DispatchQueue.main.async { [weak self] in
                        if data != nil{
                            self?.iconImgView.image = UIImage.init(data: data!)!
                        }
                    }
                }
            }
        }else if type == .channelBTCType{
            titleLbl.text = "BTC"
            detailBt.isHidden = true
        }
        
        if type == .BTCType{
            self.getItems()
            
            let bt : UIButton = bottomItemList.firstObject as! UIButton
            bottomLine.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(bt.mas_bottom)?.offset()(10*SCALE)
                make?.left.right().mas_equalTo()(0)
                make?.height.mas_equalTo()(10*SCALE)
            }
            self.layoutIfNeeded()
            headerHeight = bottomLine.frame.origin.y+bottomLine.frame.height
        }else{
            bottomLine.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(assetsBalanceLbl.mas_bottom)?.offset()(10*SCALE)
                make?.left.right().mas_equalTo()(0)
                make?.height.mas_equalTo()(20*SCALE)
            }
            self.layoutIfNeeded()
            headerHeight = bottomLine.frame.origin.y+bottomLine.frame.height
        }
    }
    
    func assignBalance(obj : Any){
        if obj is BLWalletBalanceModel{
            let balanceModel : BLWalletBalanceModel = obj as! BLWalletBalanceModel
            if balanceModel.confirmed_balance != nil{
                balanceCNY.text = (balanceModel.confirmed_balance! as String)
                balanceUSD.text = String.init(format: "$%.2f",balanceModel.confirmed_balance!.floatValue)
            }
            
            for i in 0..<bottomItemList.count{
                let valueBt : UIButton = bottomItemList[i] as! UIButton
                if i == 0{
                    if balanceModel.confirmed_balance != nil{
                        valueBt.setTitle(balanceModel.confirmed_balance as String?, for: .normal)
                    }
                }else if i == 1{
                    if balanceModel.unconfirmed_balance != nil{
                        valueBt.setTitle(balanceModel.unconfirmed_balance as String?, for: .normal)
                    }
                }else if i == 2{
                    if balanceModel.locked_balance != nil{
                        valueBt.setTitle(balanceModel.locked_balance as String?, for: .normal)
                    }
                }
            }
        }else if obj is BLAssetsItem{
            let item : BLAssetsItem = obj as! BLAssetsItem
            if item.balance != nil{
                balanceCNY.text = (item.balance! as String)
                balanceUSD.text = String.init(format: "$%.2f",item.balance!.floatValue)
            }
        }
    }
}
