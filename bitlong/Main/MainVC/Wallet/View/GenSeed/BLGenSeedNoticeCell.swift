//
//  BLGenSeedNoticeCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/30.
//

import UIKit

let GenSeedNoticeCellId = "GenSeedNoticeCellId"

class BLGenSeedNoticeCell: BLBaseTableViewCell {
    
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
            make?.left.mas_equalTo()(24*SCALE)
            make?.right.mas_equalTo()(-24*SCALE)
            make?.top.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-9*SCALE)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    override func `deinit`() {
        super.`deinit`()
    }
}
