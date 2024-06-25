//
//  BLTranscationDetailListCell.swift
//  bitlong
//
//  Created by slc on 2024/5/21.
//

import UIKit

let BLTranscationDetailListCellId = "BLTranscationDetailListCellId"

class BLTranscationDetailListCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(timeLbl)
        self.contentView.addSubview(transactionPriceLbl)
        self.contentView.addSubview(turnoverLbl)
        self.contentView.addSubview(transactionVolumeLbl)
        self.contentView.addSubview(userLbl)
        self.contentView.addSubview(starBt)
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.top.mas_equalTo()(9*SCALE)
            make?.bottom.mas_equalTo()(-9*SCALE)
            make?.width.mas_equalTo()(35*SCALE)
        }
        
        transactionPriceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(timeLbl.mas_right)?.offset()(12*SCALE+56*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.left.mas_equalTo()(timeLbl.mas_right)?.offset()(5*SCALE)
        }
        
        turnoverLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(self.mas_centerX)?.offset()(20*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.left.mas_equalTo()(transactionPriceLbl.mas_right)?.offset()(5*SCALE)
        }
        
        transactionVolumeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(self.mas_centerX)?.offset()(40*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(userLbl.mas_right)?.offset()(-5*SCALE)
        }
        
        userLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(starBt.mas_left)?.offset()(-3*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(54*SCALE)
        }
        
        starBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(timeLbl.mas_centerY)
            make?.height.mas_equalTo()(13*SCALE)
            make?.width.mas_equalTo()(15*SCALE)
        }
    }
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "13:36"
        lbl.textColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var transactionPriceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "0.0{9}426"
        lbl.textColor = UIColorHex(hex: 0xEC3468, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var turnoverLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "9,253.212亿"
        lbl.textColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var transactionVolumeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "5226.36"
        lbl.textColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var userLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "0x...5266"
        lbl.textColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var starBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_transcation_starNormal"), for: .normal)
        bt.setImage(imagePic(name: "ic_transcation_starSelected"), for: .selected)
        bt.addTarget(self, action: #selector(starClickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func starClickAcation(sender : UIButton){
        sender.isSelected = !sender.isSelected
    }
}
