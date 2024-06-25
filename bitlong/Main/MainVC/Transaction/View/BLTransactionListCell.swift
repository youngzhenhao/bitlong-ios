//
//  BLTransactionListCell.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

let BLTransactionListCellId = "BLTransactionListCellId"

class BLTransactionListCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(valueLbl)
        self.contentView.addSubview(btcValueLbl)
        self.contentView.addSubview(stasValueLbl)
        self.contentView.addSubview(upDownlbl)
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(8*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.height.mas_equalTo()(13*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        valueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(self.mas_centerX)?.offset()(60*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.height.mas_equalTo()(13*SCALE)
        }
        
        btcValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_left)
            make?.bottom.mas_equalTo()(-8*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.height.mas_equalTo()(13*SCALE)
        }
        
        stasValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(valueLbl.mas_right)
            make?.centerY.mas_equalTo()(btcValueLbl.mas_centerY)
            make?.left.mas_equalTo()(btcValueLbl.mas_right)?.offset()(10*SCALE)
            make?.height.mas_equalTo()(13*SCALE)
        }
        
        upDownlbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "satx"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var valueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$6.15552272354"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var btcValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$663.14 BTC"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var stasValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "$663.14 stas"
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    let upDownlbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "+5.62%"
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.backgroundColor = UIColorHex(hex: 0x41BF71, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4*SCALE
        lbl.clipsToBounds = true
        
        return lbl
    }()
}
