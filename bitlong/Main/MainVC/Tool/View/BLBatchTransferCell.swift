//
//  BLBatchTransferCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/3.
//

import UIKit

@objc protocol BatchTransferDelegate : NSObjectProtocol {
    @objc optional func tocuhAcation()
    @objc optional func scanAcation(cell : BLBatchTransferAddrCell)
    @objc optional func didEndEditing(addr : String, amount : String)
}

class BLBatchTransferCell: BLBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(20*SCALE)
            make?.width.mas_equalTo()(40*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
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

    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var lineLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1.0)
        
        return lbl
    }()
    
    func setCellType(isDestruction : Bool){
        titleLbl.mas_updateConstraints { (make : MASConstraintMaker?) in
            if isDestruction{
                make?.left.mas_equalTo()(5*SCALE)
                make?.width.mas_equalTo()(65*SCALE)
            }else{
                make?.left.mas_equalTo()(20*SCALE)
                make?.width.mas_equalTo()(40*SCALE)
            }
        }
    }
}

//类型 || 资产
let BLBatchTransferTypeCellId = "BLBatchTransferTypeCellId"
class BLBatchTransferTypeCell: BLBatchTransferCell {
    
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
let BLBatchTransferIDCellId = "BLBatchTransferIDCellId"
class BLBatchTransferIDCell: BLBatchTransferCell {
    
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



//地址
let BLBatchTransferAddrCellId = "BLBatchTransferAddrCellId"
class BLBatchTransferAddrCell: BLBatchTransferCell,UITextFieldDelegate {
    
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
        self.contentView.addSubview(addrContainerView)
        addrContainerView.addSubview(addrTextField)
        addrContainerView.addSubview(scanImageView)
        self.contentView.addSubview(amountContainerView)
        amountContainerView.addSubview(amountTextField)

        addrContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(5*SCALE)
            make?.height.mas_equalTo()(46*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        addrTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-60*SCALE)
        }
        
        scanImageView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.height().mas_equalTo()(24*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(addrTextField.mas_centerY)
        }
        
        amountContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(addrContainerView.mas_bottom)?.offset()(0)
            make?.left.mas_equalTo()(addrContainerView.mas_left)
            make?.right.mas_equalTo()(addrContainerView.mas_right)
            make?.height.mas_equalTo()(30*SCALE)
        }
        
        amountTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-10*SCALE)
        }
    }
    
    lazy var addrContainerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 4*SCALE
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColorHex(hex: 0xFAFAFA, a: 1.0).cgColor
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var addrTextField : UITextField = {
        var field = UITextField.init()
        field.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:"添加地址", attributes: [NSAttributedString.Key.font:FONT_BOLD(s: 14*Float(SCALE)),NSAttributedString.Key.foregroundColor:UIColorHex(hex: 0x383838, a: 0.7)])
        field.delegate = self
        field.keyboardType = .numberPad
    
        return field
    }()
    
    lazy var scanImageView : UIImageView = {
        var imgView = UIImageView.init()
        imgView.image = imagePic(name: "ic_walletDetail_scan")
        imgView.contentMode = .scaleAspectFill
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(scanAcation))
        imgView.addGestureRecognizer(tap)
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    
    lazy var amountContainerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 4*SCALE
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColorHex(hex: 0xFAFAFA, a: 1.0).cgColor
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var amountTextField : UITextField = {
        var field = UITextField.init()
        field.text = "0"
        field.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        field.font = FONT_BOLD(s: 13*Float(SCALE))
        field.delegate = self
    
        return field
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.tocuhAcation))) != nil{
            delegate?.tocuhAcation!()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if addrTextField.text != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.didEndEditing(addr:amount:)))) != nil{
                delegate?.didEndEditing!(addr: addrTextField.text!, amount: textField.text!)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func scanAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.scanAcation(cell:)))) != nil{
            delegate?.scanAcation!(cell: self)
        }
    }
}


//销毁数量
let BLBatchTransferFieldCellId = "BLBatchTransferFieldCellId"
class BLBatchTransferFieldCell: BLBatchTransferCell,UITextFieldDelegate {
    
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
            make?.right.mas_equalTo()(-10*SCALE)
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
}
