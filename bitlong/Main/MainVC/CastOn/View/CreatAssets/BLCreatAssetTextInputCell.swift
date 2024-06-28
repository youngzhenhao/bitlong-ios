//
//  BLCreatAssetTextInputCell.swift
//  bitlong
//
//  Created by slc on 2024/5/23.
//

import UIKit

let BLCreatAssetTextInputCellId = "BLCreatAssetTextInputCellId"

class BLCreatAssetTextInputCell: BLCreatAssetsCell,UITextViewDelegate {

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
        containerView.addSubview(textView)
        containerView.addSubview(pleaseHolderLbl)
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(30*SCALE)
            make?.right.mas_equalTo()(-30*SCALE)
            make?.bottom.mas_equalTo()(0)
        }
        
        textView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(5*SCALE)
            make?.left.mas_equalTo()(5*SCALE)
            make?.right.mas_equalTo()(-5*SCALE)
            make?.bottom.mas_equalTo()(-5*SCALE)
        }
        
        pleaseHolderLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.size.mas_equalTo()(pleaseHolderLbl.frame.size)
        }
    }
    
    override func setCellType(type : CreatAssetsCellType){
        super.setCellType(type: type)
        typeTitleLbl.textAlignment = .right
    }
    
    lazy var textView : UITextView = {
        var view = UITextView.init()
        view.isEditable = true
        view.delegate = self
        
        return view
    }()
    
    lazy var pleaseHolderLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatIntroduce")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        lbl.sizeToFit()
        
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
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsDescription(description:)))) != nil{
            delegate?.setAssetsDescription!(description: textView.text)
        }
    }
}
