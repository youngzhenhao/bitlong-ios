//
//  BLNoticeListCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/28.
//

import UIKit

let BLNoticeListCellId = "BLNoticeListCellId"

class BLNoticeListCell: BLBaseTableViewCell {
    
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
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLbl)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(12*SCALE)
            make?.right.mas_equalTo()(-12*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func assign(item : BLNoticeListItem,index : NSInteger){
        if item.title != nil{
            titleLbl.text = String(index) + "、" + item.title!
        }else{
            titleLbl.text = String(index) + "、" + NSLocalized(key: "walletNotice")
        }
    }
}
