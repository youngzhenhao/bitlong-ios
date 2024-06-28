//
//  BLImportAssetsCell.swift
//  bitlong
//
//  Created by slc on 2024/6/3.
//

import UIKit

@objc protocol ImportAssetsDelegate : NSObjectProtocol {
    func scanAcation()
    @objc optional func editBegin()
}

class BLImportAssetsCell: BLBaseTableViewCell {
    
    weak var delegate : ImportAssetsDelegate?
    
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
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.borderColor = UIColorHex(hex: 0xF2F2F2, a: 1.0).cgColor
        view.layer.borderWidth = 1*SCALE
        view.layer.cornerRadius = 12*SCALE
        view.clipsToBounds = true
        
        return view
    }()
}



//资产id
let BLImportAssetsIDCellId = "BLImportAssetsIDCellId"
class BLImportAssetsIDCell: BLImportAssetsCell,UITextViewDelegate {
    
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
        containerView.addSubview(addrTextView)
        containerView.addSubview(placeholderLbl)
        containerView.addSubview(scanImageView)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        addrTextView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(10*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
        }
        
        placeholderLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-50*SCALE)
        }
        
        scanImageView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.height().mas_equalTo()(22*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }

    lazy var addrTextView : UITextView = {
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
        lbl.text = NSLocalized(key: "importAssetsIdHolder")
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.editBegin))) != nil{
            delegate?.editBegin!()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil || textView.text.count <= 0{
            placeholderLbl.isHidden = false
        }else{
            placeholderLbl.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text.count <= 0{
            placeholderLbl.isHidden = false
        }
    }
    
    @objc func scanAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.scanAcation))) != nil{
            delegate?.scanAcation()
        }
    }
    
    func assignAddr(addr : String){
        addrTextView.text = addr
        placeholderLbl.isHidden = true
    }
}




//宇宙地址
let BLImportUniverseAddressCellId = "BLImportUniverseAddressCellId"
class BLImportUniverseAddressCell: BLImportAssetsCell {
    
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
        containerView.addSubview(addrLbl)
        containerView.addSubview(selectBt)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        addrLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.right.mas_equalTo()(-50*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        selectBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.mas_equalTo()(15*SCALE)
            make?.height.mas_equalTo()(8*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var addrLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "132.232.109.84:8443"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var selectBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_tool_down"), for: .normal)
        
        return bt
    }()
}



//资产详情
let BLImportAssetsDetailCellId = "BLImportAssetsDetailCellId"
class BLImportAssetsDetailCell: BLImportAssetsCell {
    
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
        containerView.layer.borderWidth = 0
        containerView.backgroundColor = UIColorHex(hex: 0xD2D9FA, a: 0.6)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(sendNumLbl)
        containerView.addSubview(sendNumValueLbl)
        containerView.addSubview(sendDateLbl)
        containerView.addSubview(sendDateValueLbl)
        containerView.addSubview(sendCoinTypeLbl)
        containerView.addSubview(sendCoinTypeValueLbl)
        containerView.addSubview(canAddLbl)
        containerView.addSubview(canAddValueLbl)
        containerView.addSubview(recordsLbl)
        containerView.addSubview(recordsValueLbl)
        containerView.addSubview(descriptionLbl)
        containerView.addSubview(descriptionValueLbl)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.bottom().mas_equalTo()(0)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.height.mas_equalTo()(18*SCALE)
            make?.top.mas_equalTo()(25*SCALE)
            make?.centerX.mas_equalTo()(0)
            make?.width.mas_equalTo()(120*SCALE)
        }
        
        sendNumLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(20*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.width.mas_equalTo()(sendNumLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        sendNumValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendNumLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendNumLbl.mas_centerY)
        }
        
        sendDateLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendNumLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(sendNumLbl.mas_left)
            make?.width.mas_equalTo()(sendDateLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        sendDateValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendDateLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendDateLbl.mas_centerY)
        }
        
        sendCoinTypeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendDateLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(sendNumLbl.mas_left)
            make?.width.mas_equalTo()(sendCoinTypeLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        sendCoinTypeValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(sendCoinTypeLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(sendCoinTypeLbl.mas_centerY)
        }
        
        canAddLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(sendCoinTypeLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(sendNumLbl.mas_left)
            make?.width.mas_equalTo()(canAddLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        canAddValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(canAddLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(canAddLbl.mas_centerY)
        }
        
        recordsLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(canAddLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(sendNumLbl.mas_left)
            make?.width.mas_equalTo()(recordsLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        recordsValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(recordsLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(recordsLbl.mas_centerY)
        }
        
        descriptionLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(recordsLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(sendNumLbl.mas_left)
            make?.width.mas_equalTo()(descriptionLbl.frame.width)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        descriptionValueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(descriptionLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(15*SCALE)
            make?.centerY.mas_equalTo()(descriptionLbl.mas_centerY)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsAssetsDetails")
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 18*Float(SCALE))
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
    
    
    lazy var sendNumLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsSendNum") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var sendNumValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var sendDateLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsSendDate") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var sendDateValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var sendCoinTypeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsCoinType") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var sendCoinTypeValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var canAddLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsCanAdd") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var canAddValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var recordsLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsOnChainRecords") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var recordsValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var descriptionLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "importAssetsCoinIntroduction") + ":"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.sizeToFit()
        
        return lbl
    }()
    
    lazy var descriptionValueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    func assignCoinDetailModel(model : BLAssetsCoinDetailModel){
        if model.amount != nil{
            sendNumValueLbl.text = model.amount
        }
        if model.createTime != nil{
            sendDateValueLbl.text = BLTools.getFormaterWithTimeStr(timeStr: model.createTime! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
        }
        if model.assetType != nil{
            sendCoinTypeValueLbl.text = model.assetType
        }
        if model.assetIsGroup != nil{
            canAddValueLbl.text = model.assetIsGroup
        }
        if model.point != nil{
            recordsValueLbl.text = model.point
        }
        if model.meta != nil && model.meta!.descriptions != nil{
            descriptionValueLbl.text = model.meta!.descriptions
        }
    }
}
