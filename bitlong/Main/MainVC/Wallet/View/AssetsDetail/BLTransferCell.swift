//
//  BLTransferCell.swift
//  bitlong
//
//  Created by slc on 2024/5/14.
//

import UIKit

@objc protocol TransferDelegate : NSObjectProtocol {
    func scanAcation()
    func addressChanged(text : String)
    func amountChanged(text : String)
}

class BLTransferCell: BLBaseTableViewCell{
    
    @objc weak var delegate : TransferDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.contentView.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(26*SCALE)
            make?.top.mas_equalTo()(15*SCALE)
            make?.size.mas_equalTo()(titleLbl.frame.size)
        }
        
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
        
    }

    var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "收款地址"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .right
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var searchTextField : UITextField = {
        var field = UITextField.init()
        field.textColor = .black
        field.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.attributedPlaceholder = NSAttributedString.init(string:" 请手动输入收款地址或扫码识别", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14*SCALE),NSAttributedString.Key.foregroundColor:UIColor(hex: "0xA6A6A6", alpha: 1.0)])
        field.layer.cornerRadius = 4*SCALE
        field.clipsToBounds = true
        field.addTarget(self, action: #selector(textFieldAcation(field:)), for: .editingChanged)
    
        return field
    }()
    
    @objc func textFieldAcation(field : UITextField){
    }
}

//收款地址
let BLTransferAddressCellId = "BLTransferAddressCellId"
class BLTransferAddressCell: BLTransferCell,UITextViewDelegate {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(26*SCALE)
            make?.top.mas_equalTo()(15*SCALE)
            make?.size.mas_equalTo()(titleLbl.frame.size)
        }
        
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
        titleLbl.text = "收款地址"
        self.contentView.addSubview(searchTextView)
        searchTextView.addSubview(placeholderLbl)
        self.contentView.addSubview(scanImageView)
        self.contentView.addSubview(tipLbl)
        
        titleLbl.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(26*SCALE)
            make?.centerY.mas_equalTo()(searchTextView.mas_centerY)
            make?.size.mas_equalTo()(titleLbl.frame.size)
        }

        searchTextView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-52*SCALE)
            make?.height.mas_equalTo()(100*SCALE)
        }
        
        placeholderLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-10*SCALE)
        }
        
        scanImageView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.height().mas_equalTo()(22*SCALE)
            make?.centerY.mas_equalTo()(searchTextView.mas_centerY)
        }
        
        tipLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(searchTextView.mas_bottom)?.offset()(0)
            make?.left.mas_equalTo()(searchTextView.mas_left)
            make?.right.mas_equalTo()(searchTextView.mas_right)
            make?.bottom.mas_equalTo()(0)
        }
    }
    
    lazy var searchTextView : UITextView = {
        var view = UITextView.init()
        view.textColor = .black
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.font = UIFont.boldSystemFont(ofSize: 14*SCALE)
        view.layer.cornerRadius = 4*SCALE
        view.clipsToBounds = true
        view.delegate = self
    
        return view
    }()
    
    lazy var placeholderLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0xA6A6A6, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.text = "请手动输入收款地址或扫码识别"
        
        return lbl
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
    
    lazy var tipLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        let str : NSString = "· 请输入发票、LNRUL、闪电地址或BTC地址 "
        let range : NSRange = str.range(of: "·")
        let attr : NSMutableAttributedString = NSMutableAttributedString.init(string: str as String)
        attr.addAttribute(.foregroundColor, value: UIColor(hex: "0x2A82E4", alpha: 1.0), range: range)
        lbl.attributedText = attr
        
        return lbl
    }()
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
        }
        if textView.text.count <= 0{
            placeholderLbl.isHidden = false
        }else{
            placeholderLbl.isHidden = true
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.addressChanged(text:)))) != nil{
            delegate?.addressChanged(text: textView.text)
        }
    }
    
    @objc func scanAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.scanAcation))) != nil{
            delegate?.scanAcation()
        }
    }
    
    func assignAddress(str : String){
        searchTextView.text = str
        if searchTextView.text.count <= 0{
            placeholderLbl.isHidden = false
        }else{
            placeholderLbl.isHidden = true
        }
    }
}


//币种
let BLTransferCoinTypeCellId = "BLTransferCoinTypeCellId"
class BLTransferCoinTypeCell: BLTransferCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        titleLbl.text = "币种"
        self.contentView.addSubview(coinTypeLbl)
        coinTypeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-54*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
    }
    
    lazy var coinTypeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "  自动显示不用输入"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        lbl.textAlignment = .left
        lbl.layer.cornerRadius = 4*SCALE
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    func assignAddressType(type : String){
        coinTypeLbl.text = type
    }
}


//金额
let BLTransferAmountCellId = "BLTransferAmountCellId"
class BLTransferAmountCell: BLTransferCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        titleLbl.text = "金额"
        searchTextField.keyboardType = .numberPad
        self.contentView.addSubview(containerView)
        containerView.addSubview(searchTextField)
        self.contentView.addSubview(minerFee)
        self.contentView.addSubview(expectedTime)
        
        searchTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入金额", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14*SCALE),NSAttributedString.Key.foregroundColor:UIColor(hex: "0xA6A6A6", alpha: 1.0)])
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-54*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        searchTextField.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.right.mas_equalTo()(-76*SCALE)
        }
        
        minerFee.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(containerView.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(containerView.mas_left)?.offset()(30*SCALE)
            make?.size.mas_equalTo()(minerFee.frame.size)
        }
        
        expectedTime.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(minerFee.mas_right)?.offset()(30*SCALE)
            make?.centerY.mas_equalTo()(minerFee.mas_centerY)
            make?.size.mas_equalTo()(expectedTime.frame.size)
        }
        
        let model : BLWalletBalanceModel = BLWalletViewModel.getWalletBalance()
        if model.confirmed_balance != nil{
            searchTextField.placeholder = String.init(format: "总余额%@ sats", model.confirmed_balance!)
        }else{
            searchTextField.placeholder = "总余额0 sats"
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.borderColor = UIColor(hex: "0x665AF0", alpha: 1.0).cgColor
        view.layer.borderWidth = 1*SCALE
        view.layer.cornerRadius = 4*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var minerFee : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "矿工费"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var expectedTime : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "预计时间10分钟"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    override func textFieldAcation(field : UITextField){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.amountChanged(text:)))) != nil{
            delegate?.amountChanged(text: field.text!)
        }
    }
    
    func assignAmount(amount : String){
        if 0 < Int(amount)!{
            searchTextField.text = amount
            searchTextField.isUserInteractionEnabled = false
        }else{
            searchTextField.text = "0"
            searchTextField.isUserInteractionEnabled = true
        }
    }
}


//附言
let BLTransferPostscriptCellId = "BLTransferPostscriptCellId"
class BLTransferPostscriptCell: BLTransferCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        titleLbl.text = "附言"
        self.contentView.addSubview(textView)
        textView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(5*SCALE)
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(15*SCALE)
            make?.right.mas_equalTo()(-54*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
        }
    }
    
    lazy var textView : UITextView = {
        var view = UITextView.init()
        view.text = " 自动显示不用输入"
        view.font = FONT_NORMAL(s: 13*Float(SCALE))
        view.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        view.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        view.isEditable = false
        view.layer.cornerRadius = 4*SCALE
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    func assignDestination(des : String){
        textView.text = des
    }
}
