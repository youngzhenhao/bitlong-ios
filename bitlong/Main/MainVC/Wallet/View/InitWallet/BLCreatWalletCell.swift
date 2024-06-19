//
//  BLCreatWalletCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/29.
//

import UIKit

let CreatWalletCellId = "CreatWalletCellId"

class BLCreatWalletCell: BLBaseTableViewCell,UITextFieldDelegate {

    var cellType : CreatWalletCellType?

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
        containerView.addSubview(textField)
        containerView.addSubview(passWorldVisibleBt)
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.right.mas_equalTo()(0)
            make?.height.mas_equalTo()(46)
            make?.bottom.mas_equalTo()(0)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(14)
            make?.right.mas_equalTo()(-45)
            make?.height.mas_equalTo()(46)
            make?.bottom.mas_equalTo()(0)
        }
        
        passWorldVisibleBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(17)
            make?.height.mas_equalTo()(12)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-14)
        }
            
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        //设置阴影颜色
        view.layer.shadowColor = UIColor.lightGray.cgColor
        //设置透明度
        view.layer.shadowOpacity = 0.7
        //设置阴影半径
        view.layer.shadowRadius = 1.5
        //设置阴影偏移量
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        return view
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.backgroundColor = .white
        field.textColor = .black
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:"", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14),NSAttributedString.Key.foregroundColor:UIColor.lightText])
        field.delegate = self

        return field
    }()
    
    lazy var passWorldVisibleBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_passworld_hide"), for: .normal)
        bt.setImage(imagePic(name: "ic_passworld_show"), for: .selected)
        bt.addTarget(self, action: #selector(passWorldVisible(sender:)), for: .touchUpInside)
        bt.isHidden = true
        
        return bt
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func passWorldVisible(sender : UIButton){
        textField.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    func walletCellType(type : CreatWalletCellType){
        switch type {
        case .walletName:
            textField.placeholder = "输入1-12个字符"
            passWorldVisibleBt.isHidden = true
            textField.isSecureTextEntry = false
            break
        case .walletPassWorld:
            textField.placeholder = "输入密码"
            passWorldVisibleBt.isHidden = false
            textField.isSecureTextEntry = true
            break
        case .walletPassWorldAgain:
            textField.placeholder = "重复输入密码"
            passWorldVisibleBt.isHidden = false
            textField.isSecureTextEntry = true
            break
        case .walletPassWorldNoti:
            textField.placeholder = "输入提醒文字"
            passWorldVisibleBt.isHidden = true
            textField.isSecureTextEntry = false
            break
        }
    }
    
    func getText() -> String{
        return textField.text!
    }
}
