//
//  BLCoinAssetsCell.swift
//  bitlong
//
//  Created by slc on 2024/5/8.
//

import UIKit

let BLCoinAssetsCellId = "BLCoinAssetsCellId"

class BLCoinAssetsCell: BLBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.contentView.addSubview(coinImgView)
        self.contentView.addSubview(coinTitle)
        self.contentView.addSubview(coinPriceCNY)
        self.contentView.addSubview(coinPriceUSD)
        self.contentView.addSubview(bottomLine)
        
        coinImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(30*SCALE)
            make?.width.height().mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        coinTitle.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinImgView.mas_right)?.offset()(8*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(coinImgView.mas_centerY)
        }
        
        coinPriceCNY.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-30*SCALE)
            make?.top.mas_equalTo()(6*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(120*SCALE)
        }
        
        coinPriceUSD.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(coinPriceCNY.mas_right)
            make?.bottom.mas_equalTo()(-3*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(120*SCALE)
        }
        
        bottomLine.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinImgView.mas_left)
            make?.right.mas_equalTo()(coinPriceCNY.mas_right)
            make?.top.mas_equalTo()(0)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
    }
    
    lazy var coinImgView : UIImageView = {
        var imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 10*SCALE
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    lazy var coinTitle : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()

    lazy var coinPriceCNY : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0xEB5A5A, a: 1.0)
        lbl.font = FONT_NORMAL(s: 16*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var coinPriceUSD : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = .gray
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var bottomLine : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1)
        
        return view
    }()
    
    func assignBtc(model : Any){
        coinImgView.image = imagePic(name: "ic_bit")
        coinTitle.text = "BTC"
        
        if model is BLWalletBalanceModel{
            let balanceModel : BLWalletBalanceModel = model as! BLWalletBalanceModel
            if balanceModel.confirmed_balance != nil{
                coinPriceCNY.text = balanceModel.confirmed_balance as String?
                coinPriceUSD.text = String.init(format: "$%@", balanceModel.confirmed_balance!)
            }else{
                coinPriceCNY.text = "0"
                coinPriceUSD.text = "$0"
            }
        }else{
            coinPriceCNY.text = "0"
            coinPriceUSD.text = "$0"
        }
    }
    
    func assignAssets(assetsObj : Any){
        if assetsObj is NSDictionary{
            let assetsDic : NSDictionary = assetsObj as! NSDictionary
            coinImgView.image = imagePic(name: "ic_bit")
            coinTitle.text = assetsDic[AssetsName] as? String
            let num : Int64 = assetsDic[AssetsNum] as! Int64
            let assetsNum : String = String.init(format: "%ld",num)
            coinPriceCNY.text = assetsNum
            coinPriceUSD.text = String.init(format: "$%@", assetsNum)
            coinPriceCNY.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        }else if assetsObj is BLAssetsItem{
            let assetsItem : BLAssetsItem = assetsObj as! BLAssetsItem

            let img = BLTools.getAssetIconImg(assetId: assetsItem.asset_id!, isImageData: false)
            if img != nil{
                coinImgView.image = img
            }else{
                coinImgView.image = imagePic(name: "ic_bit")
            }

            coinTitle.text = assetsItem.name
            coinPriceCNY.text = assetsItem.balance as? String
            coinPriceUSD.text = String.init(format: "$%@", assetsItem.balance!)
            coinPriceCNY.textColor = UIColorHex(hex: 0x38D176, a: 1.0)
        }
    }
}
