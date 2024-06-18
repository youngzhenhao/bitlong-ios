//
//  BLTranscationDetailMarketCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/21.
//

import UIKit

@objc protocol DetailMarketDelegate : NSObjectProtocol {
    func buyAcation()
}

let BLTranscationDetailMarketCellId = "BLTranscationDetailMarketCellId"

class BLTranscationDetailMarketCell: BLBaseTableViewCell {
    
    weak var delegate : DetailMarketDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func initUI(){
        self.contentView.addSubview(iconImgView)
        self.contentView.addSubview(satsLbl)
        self.contentView.addSubview(buyBt)
        self.contentView.addSubview(idLbl)
        self.contentView.addSubview(unitPriceTitleLbl)
        self.contentView.addSubview(unitPriceLbl)
        self.contentView.addSubview(unitPriceSubLbl)
        self.contentView.addSubview(totalPriceTitleLbl)
        self.contentView.addSubview(totalPriceLbl)
        self.contentView.addSubview(totalPriceSubLbl)
        self.contentView.addSubview(lineView)
        
        iconImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(16*SCALE)
            make?.width.height().mas_equalTo()(30*SCALE)
        }
        
        satsLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(iconImgView.mas_top)
            make?.left.mas_equalTo()(iconImgView.mas_right)?.offset()(8*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.right.mas_equalTo()(buyBt.mas_left)?.offset()(-16*SCALE)
        }
        
        buyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-16*SCALE)
            make?.top.mas_equalTo()(iconImgView.mas_top)
            make?.width.mas_equalTo()(60*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
        }
        
        idLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(satsLbl.mas_left)
            make?.top.mas_equalTo()(satsLbl.mas_bottom)?.offset()(3*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.width.mas_equalTo()(idLbl.frame.width+12*SCALE)
        }
        
        unitPriceTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(iconImgView.mas_left)
            make?.top.mas_equalTo()(iconImgView.mas_bottom)?.offset()(20*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(unitPriceTitleLbl.frame.width)
        }
        
        unitPriceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(unitPriceTitleLbl.mas_left)
            make?.top.mas_equalTo()(unitPriceTitleLbl.mas_bottom)?.offset()(1*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.right.mas_equalTo()(self.mas_centerX)?.offset()(-15*SCALE)
        }
        
        unitPriceSubLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(unitPriceLbl.mas_left)
            make?.top.mas_equalTo()(unitPriceLbl.mas_bottom)?.offset()(1*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(unitPriceLbl.mas_right)
        }
        
        totalPriceTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(self.mas_centerX)?.offset()(15*SCALE)
            make?.centerY.mas_equalTo()(unitPriceTitleLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(totalPriceTitleLbl.frame.width)
        }
        
        totalPriceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(totalPriceTitleLbl.mas_left)
            make?.top.mas_equalTo()(totalPriceTitleLbl.mas_bottom)?.offset()(1*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
        }
        
        totalPriceSubLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(totalPriceLbl.mas_left)
            make?.top.mas_equalTo()(totalPriceLbl.mas_bottom)?.offset()(1*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(totalPriceLbl.mas_right)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
    }
    
    lazy var iconImgView : UIImageView = {
        var view = UIImageView.init()
        view.image = imagePic(name: "ic_bit")
        
        return view
    }()
    
    lazy var satsLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "253,999,253,263 sats"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var idLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "#12653685"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.7)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.backgroundColor = UIColorHex(hex: 0xF0EEFE, a: 1.0)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 2*SCALE
        lbl.clipsToBounds = true
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var unitPriceTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "单价"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var unitPriceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$6.15552272354"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var unitPriceSubLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$663.14K"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var totalPriceTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "总价"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var totalPriceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$6.15552272354"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var totalPriceSubLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$663.14K"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var buyBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("购买", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 15*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buyClickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1.0)
        
        return view
    }()
    
    @objc func buyClickAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.buyAcation))) != nil{
            delegate?.buyAcation()
        }
    }
    
    func lineViewHidden(isHidden : Bool){
        lineView.isHidden = isHidden
    }
}
