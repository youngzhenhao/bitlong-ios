//
//  BLCollectionInvoiceCell.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

let BLCollectionInvoiceCellId = "BLCollectionInvoiceCellId"

class BLCollectionInvoiceCell: BLBaseTableViewCell,UITextFieldDelegate,UITextViewDelegate {
    
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
            make?.left.mas_equalTo()(0)
            if languageCode == .ZH{
                make?.width.mas_equalTo()(68*SCALE)
            }else{
                make?.width.mas_equalTo()(80*SCALE)
            }
            make?.height.mas_equalTo()(16*SCALE)
            make?.top.mas_equalTo()(10*SCALE)
        }
    }

    func assignCoinTypeView(){
        containerView.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        containerView.layer.borderWidth = 0
        titleLbl.text = NSLocalized(key: "collectionCoinType")
        textField.keyboardType = .namePhonePad

        self.contentView.addSubview(containerView)
        containerView.addSubview(coinTypeLbl)
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-38*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        coinTypeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(10*SCALE)
            make?.bottom.right().mas_equalTo()(-10*SCALE)
        }
    }
    
    func assignAmountView(){
        containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        containerView.layer.borderWidth = 1*SCALE
        titleLbl.text = NSLocalized(key: "collectionAmount")
        textField.placeholder = NSLocalized(key: "collectionAmountHolder")
        textField.keyboardType = .numberPad

        self.contentView.addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(satsLbl)
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-38*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(10*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.right.mas_equalTo()(-95*SCALE)
        }
        
        satsLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-14*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    func assignPostscriptView(){
        containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        containerView.layer.borderWidth = 1*SCALE
        titleLbl.text = NSLocalized(key: "collectionPostscript")

        self.contentView.addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(pleaseHolderLbl)
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-38*SCALE)
        }
        
        textView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(2*SCALE)
            make?.left.mas_equalTo()(2*SCALE)
            make?.bottom.right().mas_equalTo()(-2*SCALE)
        }
        
        pleaseHolderLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
        }
    }
    
    func assignAssetsItem(obj : String?){
        if obj != nil{
            coinTypeLbl.text = obj
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.cornerRadius = 4*SCALE
        view.layer.borderColor = UIColorHex(hex: 0x665AF0, a: 0.8).cgColor
        view.layer.borderWidth = 1*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var coinTypeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "collectionCoinTypeHolder")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left

        return lbl
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        field.font = FONT_BOLD(s: 14*Float(SCALE))
        field.attributedPlaceholder = NSAttributedString.init(string:"", attributes: [NSAttributedString.Key.font:FONT_NORMAL(s: 14*Float(SCALE)),NSAttributedString.Key.foregroundColor:UIColorHex(hex: 0x383838, a: 0.4)])
        field.delegate = self

        return field
    }()
    
    lazy var satsLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    lazy var textView : UITextView = {
        var view = UITextView.init()
        view.isEditable = true
        view.delegate = self
        
        return view
    }()

    
    lazy var pleaseHolderLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "collectionPostscriptHolder")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
        }
        if textView.text.count <= 0{
            pleaseHolderLbl.isHidden = false
        }else{
            pleaseHolderLbl.isHidden = true
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
   
    }
}
