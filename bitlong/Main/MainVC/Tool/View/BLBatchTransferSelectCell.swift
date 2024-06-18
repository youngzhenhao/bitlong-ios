//
//  BLBatchTransferSelectCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/3.
//

import UIKit

let BLBatchTransferSelectCellId = "BLBatchTransferSelectCellId"
class BLBatchTransferSelectCell: BLBaseTableViewCell {
    
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
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(20*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-20*SCALE)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func assignData(obj : Any){
        if obj is String{
            titleLbl.text = (obj as! String)
        }else if obj is BLAssetsItem{
            let item : BLAssetsItem = obj as! BLAssetsItem
            titleLbl.text = item.name
        }
    }
}
