//
//  BLAddAddressCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/28.
//

import UIKit

let BLAddAddressCellId = "BLAddAddressCellId"

class BLAddAddressCell: BLBaseTableViewCell {
    
    var addressaModel : BLAddAddressModel?
    
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
        self.contentView.addSubview(containerView)
        containerView.addSubview(addressTitleLbl)
        containerView.addSubview(addressTypeLbl)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
        }
        
        addressTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
        }
        
        addressTypeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(addressTitleLbl.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(15*SCALE)
            make?.height.mas_equalTo()(13*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        view.layer.cornerRadius = 8*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var addressTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    lazy var addressTypeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_BOLD(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func assignAddressModel(model : BLAddAddressModel?){
        addressaModel = model
        if model != nil{
            addressTitleLbl.text = model?.address
            addressTypeLbl.text = model?.derivation_path
            addressTitleLbl.mas_updateConstraints { (make : MASConstraintMaker?) in
                make?.height.mas_equalTo()(model?.height())
            }
        }else{
            addressTitleLbl.text = "--"
            addressTypeLbl.text = "-/-"
        }
    }
}
