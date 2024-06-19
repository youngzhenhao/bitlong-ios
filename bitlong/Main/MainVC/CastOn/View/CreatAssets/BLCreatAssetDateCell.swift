//
//  BLCreatAssetDateCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/23.
//

import UIKit

let BLCreatAssetBegainDateCellId = "BLCreatAssetBegainDateCellId"
let BLCreatAssetEndDateCellId    = "BLCreatAssetEndDateCellId"

class BLCreatAssetDateCell: BLCreatAssetsCell,DatePickerDelegate {
    
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
        containerView.addSubview(dateLbl)
        containerView.addSubview(dateImgView)
        
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
        
        dateImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(6*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
        }
    }
    
    override func setCellType(type : CreatAssetsCellType){
        super.setCellType(type: type)
        typeTitleLbl.textAlignment = .right
        
        switch type {
        case .assetsBegainDate:
            containerView.tag = 102
            containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
            containerView.layer.borderWidth = 0.0
            typeTitleLbl.text = "开始日期"
            break
        case .assetsEndDate:
            containerView.tag = 103
            containerView.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
            containerView.layer.borderWidth = 0.0
            typeTitleLbl.text = "结束日期"
            break
        default:
            break
        }
    }
    
    func setCellState(isHidden : Bool){
        typeTitleLbl.isHidden = isHidden
        containerView.isHidden = isHidden
        dateLbl.isHidden = isHidden
        dateImgView.isHidden = isHidden
    }
    
    lazy var dateLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "请选择时间"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.8)
        lbl.textAlignment = .left
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        
        return lbl
    }()
    
    lazy var dateImgView : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_wallet_next"))
        
        return view
    }()
    
    lazy var pickerView : BLUIDatePickerView = {
        var view = BLTools.shared.getPickerView()
        view.delegate = self
        
        return view
    }()
    
    @objc override func containerTapAcation(){
        showDatePicker()
    }
    
    //展示日期选择器
    func showDatePicker(){
        if pickerView.superview == nil{
            pickerView.alpha = 1.0
            BLTools.getCurrentVC().view.addSubview(pickerView)
        }
        pickerView.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(containerView.mas_bottom)?.offset()(5*SCALE)
            make?.centerX.mas_equalTo()(containerView.mas_centerX)
            make?.width.mas_equalTo()(262*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
        }
    }
    
    func removeDatePicker(){
        pickerView.removePickerView()
    }
    
    //DatePickerDelegate
    func datePickerDelected(date: Date) {
        dateLbl.text = BLTools.getFormater(date: date, formatStr: "yyyy-MM-dd HH:mm:ss")
        dateLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        
        if cellType == .assetsBegainDate{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsBegainDate(date:)))) != nil{
                delegate?.setAssetsBegainDate!(date: date)
            }
        }else if cellType == .assetsEndDate{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsEndDate(date:)))) != nil{
                delegate?.setAssetsEndDate!(date: date)
            }
        }
    }
}
