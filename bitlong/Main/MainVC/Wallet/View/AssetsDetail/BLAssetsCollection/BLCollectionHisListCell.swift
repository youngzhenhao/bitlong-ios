//
//  BLCollectionHisListCell.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

let BLCollectionHisListCellID = "BLCollectionHisListCellID"

class BLCollectionHisListCell: BLBaseTableViewCell {
    
    var coinType : String?
    
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
        self.contentView.addSubview(amountLbl)
        self.contentView.addSubview(statusLbl)
        self.contentView.addSubview(timeLbl)
        
        amountLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(20*SCALE)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerX.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_greaterThanOrEqualTo()(timeLbl.frame.width)
        }
    }
    
    lazy var amountLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var statusLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "1970-01-01\n24:00:00"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.6)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        
        return lbl
    }()
    
    func assignHisItem(coinType : String?,hisObj : Any){
        
        timeLbl.text = "1970-01-01\n00:00:00"
        
        var amount : String?
        var timeKey : NSString?
        if hisObj is BLCollectionHisItem{
            let hisItem : BLCollectionHisItem = hisObj as! BLCollectionHisItem
            amount = hisItem.amount
            timeKey = hisItem.asset_id as? NSString
            
            statusLbl.text = "其它"
        }else if hisObj is BLInvoicesHisItem{
            let hisItem : BLInvoicesHisItem = hisObj as! BLInvoicesHisItem
            amount = hisItem.amount
            timeKey = hisItem.invoice as? NSString
            
            self.setStatus(status: hisItem.status!)
        }
        
        if coinType != nil{
            if amount != nil{
                amountLbl.text = String.init(format: "%@ %@", amount!,coinType!)
            }else{
                amountLbl.text = String.init(format: "-- %@", coinType!)
            }
        }else{
            if amount != nil{
                amountLbl.text = amount
            }else{
                amountLbl.text = "--"
            }
        }
       
        let obj = userDefaults.value(forKey: AssetsInvoiceCreatTime)
        if obj != nil && obj is NSDictionary && timeKey != nil{
            let md5Str : NSString  = (timeKey! as NSString).fromMD5()! as NSString
            let dic : NSDictionary = obj as! NSDictionary
            if let obj = dic.object(forKey: md5Str){
                var timeStr : NSString = obj as! NSString
                timeStr = timeStr.replacingOccurrences(of: " ", with: "\n") as NSString
                timeLbl.text = (timeStr as String)
            }
        }
    }
    
    func setStatus(status : String){
        //status： int 发票状态，0表示未支付，1表示已支付，2表示已失效
        if status == "0"{
            statusLbl.text = "未支付"
        }else if status == "1"{
            statusLbl.text = "已支付"
        }else if status == "2"{
            statusLbl.text = "已失效"
        }else{
            statusLbl.text = "其它"
        }
    }
}
