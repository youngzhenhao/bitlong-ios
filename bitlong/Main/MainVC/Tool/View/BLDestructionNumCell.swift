//
//  BLDestructionFieldCell.swift
//  bitlong
//
//  Created by slc on 2024/6/18.
//

import UIKit

//销毁数量
let BLDestructionNumCellId = "BLDestructionFieldCellId"
class BLDestructionNumCell: BLBatchTransferCell,UITextFieldDelegate {
    
    weak var delegate : BatchTransferDelegate?
    
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
        self.contentView.addSubview(containerView)
        containerView.addSubview(textField)
        
        containerView.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.height.mas_equalTo()(40*SCALE)
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.cornerRadius = 6*SCALE
        view.layer.borderColor = UIColorHex(hex: 0x665AF0, a: 1.0).cgColor
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.textColor = .black
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:"请输入数量", attributes: [NSAttributedString.Key.font:FONT_NORMAL(s: 14*Float(SCALE)),NSAttributedString.Key.foregroundColor:UIColorHex(hex: 0x383838, a: 0.8)])
        field.keyboardType = .numberPad
        field.delegate = self
        
        return field
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.tocuhAcation))) != nil{
            delegate?.tocuhAcation!()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.didEndEditing(obj:cell:)))) != nil{
                delegate?.didEndEditing!(obj: textField.text!, cell: self)
            }
        }
    }
}
