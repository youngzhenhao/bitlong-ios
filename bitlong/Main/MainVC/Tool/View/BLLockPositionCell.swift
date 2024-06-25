//
//  BLLockPositionCell.swift
//  bitlong
//
//  Created by slc on 2024/6/18.
//

import UIKit

class BLLockPositionCell: BLBatchTransferCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
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

}


//资产
let BLLockPositionAssetCellId = "BLLockPositionAssetCellId"
class BLLockPositionAssetCell: BLLockPositionCell {
    
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
        self.contentView.addSubview(subTitleLbl)
        self.contentView.addSubview(selectBt)
        self.contentView.addSubview(lineLbl)

        subTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(30*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.right.mas_equalTo()(-60*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        selectBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.mas_equalTo()(15*SCALE)
            make?.height.mas_equalTo()(8*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        lineLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(1*SCALE)
            make?.bottom.mas_equalTo()(0)
        }
    }
    
    lazy var subTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var selectBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_tool_down"), for: .normal)
        
        return bt
    }()
    
}



//ID || 数量
let BLLockPositionIDCellId = "BLLockPositionIDCellId"
class BLLockPositionIDCell: BLBatchTransferCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        
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
        self.contentView.addSubview(subTitleLbl)
        
        subTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(30*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
    }
    
    lazy var subTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_BOLD(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
}


//锁仓数量
let BLLockPositionLockNumCellId = "BLLockPositionLockNumCellId"
class BLLockPositionLockNumCell: BLDestructionNumCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        
        self.initUI()
        textField.placeholder = "请输入锁仓数量"
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
}


//解锁时间
let BLLockPositionTimeCellId = "BLLockPositionTimeCellId"
class BLLockPositionTimeCell: BLCreatAssetDateCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
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
    
    override func initUI() {
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(containerView)
        containerView.addSubview(dateLbl)
        containerView.addSubview(dateImgView)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerY.mas_equalTo()(0)
            make?.left.mas_equalTo()(typeTitleLbl.mas_right)?.offset()(10*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(5*SCALE)
            make?.width.mas_equalTo()(65*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        dateLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.top.mas_equalTo()(10*SCALE)
        }
        
        dateImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(6*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
    }
    
    override func datePickerDelected(date: Date) {
        dateLbl.text = BLTools.getFormater(date: date, formatStr: "yyyy-MM-dd HH:mm:ss")
        dateLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsUnLockDate(date:)))) != nil{
            delegate?.setAssetsUnLockDate!(date: date)
        }
    }
}



//哈希锁
let BLLockPositionHashLockCellId = "BLLockPositionHashLockCellId"
class BLLockPositionHashLockCell: BLBatchTransferAddrCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        
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
    
    override func initUI(){
        addrContainerView.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        addrTextField.placeholder = "请手动输入或扫码"
        
        self.contentView.addSubview(addrContainerView)
        addrContainerView.addSubview(addrTextField)
        self.contentView.addSubview(scanImageView)

        addrContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(scanImageView.mas_left)?.offset()(-10*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        addrTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-10*SCALE)
        }
        
        scanImageView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.height().mas_equalTo()(24*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(addrTextField.mas_centerY)
        }
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.tocuhAcation))) != nil{
            delegate?.tocuhAcation!()
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if addrTextField.text != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.didEndEditing(obj:cell:)))) != nil{
                delegate?.didEndEditing!(obj: textField.text!, cell: self)
            }
        }
    }
    
    @objc override func scanAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.scanAcation(cell:)))) != nil{
            delegate?.scanAcation!(cell: self)
        }
    }
}
