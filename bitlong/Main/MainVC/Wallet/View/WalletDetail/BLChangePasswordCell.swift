//
//  BLChangePasswordCell.swift
//  bitlong
//
//  Created by slc on 2024/6/17.
//

import UIKit

let BLChangePasswordCellId = "BLChangePasswordCellId"

class BLChangePasswordCell: BLBaseTableViewCell {
    
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
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.contentView.addSubview(containerView)
        containerView.addSubview(textField)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.top.bottom().mas_equalTo()(0)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        field.font = FONT_NORMAL(s: 14*Float(SCALE))
        
        return field
    }()
    
    func assignIndexPath(path : IndexPath){
        if path.section == 0{
            textField.placeholder = "请输入原密码"
        }else{
            textField.placeholder = "请输入8~12位数字与字母组成密码"
        }
    }
}
