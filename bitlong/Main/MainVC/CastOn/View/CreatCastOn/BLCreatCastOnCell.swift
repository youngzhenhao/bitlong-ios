//
//  BLCreatCastOnCell.swift
//  bitlong
//
//  Created by slc on 2024/5/17.
//

import UIKit

@objc protocol CreatCastOnDelegate : NSObjectProtocol {
    func getQueryInfo(assetsId : String)
    func minitNumSelected(num : Int64)
}

let BLCreatCastOnCellId = "BLCreatCastOnCellId"

class BLCreatCastOnCell: BLBaseTableViewCell,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate {
    
    var cellType : CreatAssetsCellType?
    weak var delegate : CreatCastOnDelegate?
    var mintNumber = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    func setCellType(type : CreatAssetsCellType){
        cellType = type
        
        containerView.isHidden = true
        textView.isHidden = true
        textLbl.isHidden = true
        dateLbl.isHidden = true
        dateImgView.isHidden = true
        percentSignLbl.isHidden = true
        
        switch type {
        case .assetsID:
            initTextViewCell()
            
            typeTitleLbl.text = "资产ID"
            break
        case .assetsName:
            initNameCell()
        
            typeTitleLbl.text = "名称"
            break
        case .assetsNum:
            initNameCell()
            
            typeTitleLbl.text = "总量"
            break
        case .assetsReserve:
            initNameCell()
            
            typeTitleLbl.text = "项目方预留"
            textLbl.text = "0~100"
            break
        case .assetsMintNum:
            initNameCell()
            
            textLbl.text = "单份Mint数量"
            break
        case .assetsBegainDate:
            initDateCell()
            
            containerView.isUserInteractionEnabled = false
            containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
            containerView.layer.borderWidth = 0.0
            typeTitleLbl.text = "开始日期"
            dateLbl.text = "开始日期"
            break
        case .assetsEndDate:
            initDateCell()
            
            containerView.isUserInteractionEnabled = false
            containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
            containerView.layer.borderWidth = 0.0
            typeTitleLbl.text = "结束日期"
            dateLbl.text = "结束日期"
            break
        case .assetsHadCastOn:
            initNameCell()
            
            typeTitleLbl.text = "已铸造"
            break
        case .assetsHolder:
            initNameCell()
            
            typeTitleLbl.text = "持有人"
            break
        case .assetsCopies:
            initCopiesCell()
            
            typeTitleLbl.text = "份数"
            textLbl.text = "1份"
            textLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
            break
        default:
            break
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.cornerRadius = 6*SCALE
        view.layer.borderColor = UIColorHex(hex: 0x665AF0, a: 1.0).cgColor
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(containerTapAcation))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var typeTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    func initTextViewCell(){
        containerView.isHidden = false
        textView.isHidden = false
        
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(textView)
        textView.addSubview(pleaseHolderLbl)
        
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
        
        textView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(5*SCALE)
            make?.right.mas_equalTo()(-5*SCALE)
            make?.bottom.mas_equalTo()(-5*SCALE)
            make?.top.mas_equalTo()(0)
        }
        
        pleaseHolderLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-10*SCALE)
        }
    }
    
    lazy var textView : UITextView = {
        var view = UITextView.init()
        view.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        view.font = FONT_NORMAL(s: 13*Float(SCALE))
        view.delegate = self
       
        return view
    }()
    
    lazy var percentSignLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "%"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 18*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var pleaseHolderLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "请输入资产ID"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
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
            if 0 < text.count{
                pleaseHolderLbl.isHidden = true
            }else{
                pleaseHolderLbl.isHidden = false
            }
        }else{
            pleaseHolderLbl.isHidden = true
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.getQueryInfo(assetsId:)))) != nil{
            delegate?.getQueryInfo(assetsId: textView.text)
        }
    }
    
    
    
    func initNameCell(){
        textLbl.isHidden = false
        
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(textLbl)
        
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        textLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(typeTitleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-80*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        if cellType == .assetsReserve{
            percentSignLbl.isHidden = false
            self.contentView.addSubview(percentSignLbl)
            percentSignLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.left.mas_equalTo()(textLbl.mas_right)?.offset()(10*SCALE)
                make?.size.mas_equalTo()(percentSignLbl.frame.size)
                make?.centerY.mas_equalTo()(textLbl.mas_centerY)
            }
        }
    }
    
    
    func initDateCell(){
        containerView.isHidden = false
        dateLbl.isHidden = false
        
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(dateLbl)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(typeTitleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
        }
        
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        dateLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.top.mas_equalTo()(10*SCALE)
        }
    }
    
    lazy var dateLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.textAlignment = .left
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        
        return lbl
    }()
    
    lazy var dateImgView : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_wallet_next"))
        
        return view
    }()
    
    func initCopiesCell(){
        containerView.isHidden = false
        textLbl.isHidden = false
        dateImgView.isHidden = false
        
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(textLbl)
        containerView.addSubview(dateImgView)
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(typeTitleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-65*SCALE)
        }
        
        textLbl.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-90*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        dateImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.mas_equalTo()(8*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    @objc func containerTapAcation(){
        if cellType == .assetsCopies{
            if pickerView.superview == nil{
                BLTools.getCurrentVC().view.addSubview(pickerView)
                pickerView.mas_remakeConstraints { (make : MASConstraintMaker?) in
                    make?.height.mas_equalTo()(180*SCALE)
                    make?.width.mas_equalTo()(90*SCALE)
                    make?.bottom.mas_equalTo()(containerView.mas_top)?.offset()(-5*SCALE)
                    make?.right.mas_equalTo()(containerView.mas_right)
                }
            }
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.pickerView.alpha = 1.0
            }
        }
    }
    
    lazy var textLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var pickerView : UIPickerView = {
        var view = UIPickerView.init()
        view.tintColor = .white
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.dataSource = self
        view.delegate = self
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    //UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mintNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35*SCALE
    }
    
    //UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String.init(format: "%ld份", row+1)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String.init(format: "%ld份", row+1), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textLbl.text = String.init(format: "%ld份", row+1)
        
        UIView.animate(withDuration: 0.3) {
            pickerView.alpha = 0.0
        }completion: { flag in
            pickerView.removeFromSuperview()
        }
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.minitNumSelected(num:)))) != nil{
            delegate?.minitNumSelected(num: Int64(row+1))
        }
    }
    
    func assignQueryIssuedItem(item : BLLaunchQueryIssuedItem){
        switch cellType {
        case .assetsID:
            textView.text = item.asset_id
            pleaseHolderLbl.isHidden = 0 < item.asset_id!.count
            break
        case .assetsName:
            textLbl.text = item.name
            break
        case .assetsNum:
            textLbl.text = item.amount
            break
        case .assetsReserve:
            textLbl.text = item.reserved
            break
        case .assetsMintNum:
            textLbl.text = item.mint_quantity
            break
        case .assetsBegainDate:
            dateLbl.text = BLTools.getFormaterWithTimeStr(timeStr: item.start_time! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
            break
        case .assetsEndDate:
            dateLbl.text = BLTools.getFormaterWithTimeStr(timeStr: item.end_time! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
            break
        case .assetsHadCastOn:
            textLbl.text = item.minted_number
            break
        case .assetsHolder:
            textLbl.text = ""
            break
        case .assetsCopies:
            break
        default:
            break
        }
    }
    
    func assignMintNumberModel(model : BLCastOnQueryInventoryMintNumberModel){
        if model.number != nil{
            mintNumber = Int(model.number!)!
            if 10 < mintNumber{
                mintNumber = 10
            }
            
            pickerView.reloadAllComponents()
        }
    }
}
