//
//  BLCollectionBTCAddresCell.swift
//  bitlong
//
//  Created by slc on 2024/5/15.
//

import UIKit

let BLCollectionBTCAddresCellId = "BLCollectionBTCAddresCellId"

class BLCollectionBTCAddresCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(containerView)
        containerView.addSubview(addressLbl)
        containerView.addSubview(balanceLbl)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.bottom().mas_equalTo()(0)
        }
        
        addressLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-150*SCALE)
        }
        
        balanceLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(120*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        view.layer.cornerRadius = 4*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var addressLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.8)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var balanceLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x38D176, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    func assignAssets(item : BLBTCDetailItem,index : NSInteger){
        addressLbl.text = item.address
        if item.balance != nil{
            balanceLbl.text = String.init(format: "%@ sats", item.balance!)
        }
    }
}
