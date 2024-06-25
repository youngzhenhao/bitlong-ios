//
//  BLCreatAssetLogoCell.swift
//  bitlong
//
//  Created by slc on 2024/5/23.
//

import UIKit

let BLCreatAssetLogoCellId = "BLCreatAssetLogoCellId"

class BLCreatAssetLogoCell: BLCreatAssetsCell {
    
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
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(logoImgView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(subTitleLbl)
        
        typeTitleLbl.attributedText = setAttributed(text: "*上传logo")
        containerView.backgroundColor = UIColorHex(hex: 0xE3E1FC, a: 1.0)
     
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(8*SCALE)
            make?.left.mas_equalTo()(60*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        containerView.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(typeTitleLbl.mas_bottom)?.offset()(10*SCALE)
            make?.bottom.mas_equalTo()(0)
            make?.left.mas_equalTo()(typeTitleLbl.mas_left)
            make?.right.mas_equalTo()(-60*SCALE)
        }
        
        logoImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(25*SCALE)
            make?.width.mas_equalTo()(44*SCALE)
            make?.height.mas_equalTo()(32*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(logoImgView.mas_bottom)?.offset()(12*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.left.right().mas_equalTo()(0)
        }
        
        subTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(12*SCALE)
            make?.height.mas_equalTo()(10*SCALE)
            make?.left.right().mas_equalTo()(0)
        }
    }
    
    override func setCellType(type : CreatAssetsCellType){
        super.setCellType(type: type)
        typeTitleLbl.textAlignment = .left
    }
    
    lazy var logoImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_creatAssets_logo"))
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "上传你的logo"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var subTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "支持PNG和JPEG格式"
        lbl.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        lbl.font = FONT_NORMAL(s: 10*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    @objc override func containerTapAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.getLogoPicAcation))) != nil{
            delegate?.getLogoPicAcation!()
        }
    }
}
