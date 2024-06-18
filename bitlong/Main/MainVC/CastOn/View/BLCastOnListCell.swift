//
//  BLCastOnListCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/16.
//

import UIKit

let BLCastOnListCellID = "BLCastOnListCellID"

class BLCastOnListCell: BLBaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initUI(){
        self.contentView.addSubview(coinImgView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(IDLbl)
        self.contentView.addSubview(reserveLbl)
        self.contentView.addSubview(castLbl)
        self.contentView.addSubview(lineView)
        
        coinImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.width.height().mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    
        nameLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinImgView.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        IDLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerX.mas_equalTo()(-80*SCALE/2.0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        reserveLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerX.mas_equalTo()(90*SCALE/2.0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        castLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-35*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(0.5*SCALE)
            make?.bottom.mas_equalTo()(0)
        }
    }
    
    lazy var coinImgView : UIImageView = {
        var view = UIImageView.init()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var nameLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var IDLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var reserveLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var castLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x383838, a: 1.0)
        
        return view
    }()
    
    func assignLaunchQuery(item : BLLaunchQueryIssuedItem){
        let img = BLTools.getAssetIconImg(assetId: item.image_data!, isImageData: true)
        if img != nil{
            coinImgView.image = img
        }else{
            coinImgView.image = imagePic(name: "ic_bit")
        }
        
        nameLbl.text = item.name
        IDLbl.text = item.asset_id
        reserveLbl.text = String.init(format: "%@%@", (item.reserved)!,"%")
        let minted = Float(item.minted_number!)
        let mint = Float(item.mint_number!)
        if mint == 0{
            castLbl.text = "0%"
        }else{
            castLbl.text = String.init(format: "%.2f%@", minted!/mint!,"%")
        }
    }
}
