//
//  BLUniverseAddressListCell.swift
//  bitlong
//
//  Created by slc on 2024/6/25.
//

import UIKit

let BLUniverseAddressListCellId = "BLUniverseAddressListCellId"

class BLUniverseAddressListCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func assignAddress(addr : String){
        titleLbl.text = addr
    }
}
