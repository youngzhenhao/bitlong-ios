//
//  BLCreatAssetFieldCell.swift
//  bitlong
//
//  Created by slc on 2024/5/23.
//

import UIKit

let BLCreatAssetNameCellId    = "BLCreatAssetFieldCellId"
let BLCreatAssetNumCellId     = "BLCreatAssetNumCellId"
let BLCreatAssetReserveCellId = "BLCreatAssetReserveCellId"
let BLCreatAssetMintNumCellId = "BLCreatAssetMintNumCellId"

class BLCreatAssetFieldCell: BLCreatAssetsCell,UITextFieldDelegate {
    
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
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(textField)
        self.contentView.addSubview(percentSignLbl)
        
        containerView.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(typeTitleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-65*SCALE)
        }
        
        typeTitleLbl.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        textField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(12*SCALE)
            make?.right.mas_equalTo()(-90*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.top.mas_equalTo()(10*SCALE)
        }
        
        percentSignLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(containerView.mas_right)?.offset()(10*SCALE)
            make?.size.mas_equalTo()(percentSignLbl.frame.size)
            make?.centerY.mas_equalTo()(containerView.mas_centerY)
        }
    }
    
    override func setCellType(type : CreatAssetsCellType){
        super.setCellType(type: type)
        typeTitleLbl.textAlignment = .right
        percentSignLbl.isHidden = type != .assetsReserve
        
        switch type {
        case .assetsName:
            textField.keyboardType = .namePhonePad
            typeTitleLbl.text = "名称"
            textField.placeholder = "请输入名称"
            break
        case .assetsNum:
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
            typeTitleLbl.text = "总量"
            textField.placeholder = "请输入总量"
            break
        case .assetsReserve:
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
            typeTitleLbl.text = "项目方预留"
            textField.placeholder = "0~100"
            break
        case .assetsMintNum:
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
            typeTitleLbl.text = "单份Mint数量"
            textField.placeholder = "单份Mint数量"
            break
        default:
            break
        }
    }
    
    func setCellState(isHidden : Bool){
        typeTitleLbl.isHidden = isHidden
        containerView.isHidden = isHidden
        textField.isHidden = isHidden
        percentSignLbl.isHidden = isHidden
    }
    
    lazy var percentSignLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "%"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.8)
        lbl.font = FONT_BOLD(s: 18*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var textField : UITextField = {
        var field = UITextField.init()
        field.textColor = .black
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:"", attributes: [NSAttributedString.Key.font:FONT_NORMAL(s: 14*Float(SCALE)),NSAttributedString.Key.foregroundColor:UIColorHex(hex: 0x383838, a: 0.8)])
        field.delegate = self

        return field
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if cellType == .assetsName{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsName(name:)))) != nil{
                if textField.text != nil && 0 < textField.text!.count{
                    delegate?.setAssetsName!(name: textField.text!)
                }else{
                    delegate?.setAssetsName!(name: "")
                }
            }
        }else if cellType == .assetsNum{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsNum(num:)))) != nil{
                if textField.text != nil && 0 < textField.text!.count{
                    let numText : NSString = textField.text! as NSString
                    let num : NSInteger = numText.integerValue
                    delegate?.setAssetsNum!(num: num)
                }else{
                    delegate?.setAssetsNum!(num: 0)
                }
            }
        }else if cellType == .assetsReserve{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsReserve(reserve:)))) != nil{
                if textField.text != nil && 0 < textField.text!.count{
                    let numText : NSString = textField.text! as NSString
                    let num : NSInteger = numText.integerValue
                    delegate?.setAssetsReserve!(reserve: num)
                }else{
                    delegate?.setAssetsReserve!(reserve: 0)
                }
            }
        }else if cellType == .assetsMintNum{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsMintNum(num:)))) != nil{
                if textField.text != nil && 0 < textField.text!.count{
                    let numText : NSString = textField.text! as NSString
                    let num : NSInteger = numText.integerValue
                    delegate?.setAssetsMintNum!(num: num)
                }else{
                    delegate?.setAssetsMintNum!(num: 0)
                }
            }
        }
    }
}
