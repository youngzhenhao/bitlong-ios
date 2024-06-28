//
//  BLAssetsSendHisCell.swift
//  bitlong
//
//  Created by slc on 2024/6/5.
//

import UIKit

let BLAssetsSendHisCellId = "BLAssetsSendHisCellId"

class BLAssetsSendHisCell: BLBaseTableViewCell {
    
    let width : CGFloat = (SCREEN_WIDTH - 20*SCALE)/5.0
    
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

        // Configure the view for the selected state
    }
    
    func initUI(){
        self.addSubview(coinLbl)
        self.addSubview(idLbl)
        self.addSubview(typeLbl)
        self.addSubview(timeLbl)
        self.addSubview(statusLbl)
        
        coinLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
        }
        
        idLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(coinLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
        }
        
        typeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(idLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
        }
        
        timeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(typeLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
        }
        
        statusLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(timeLbl.mas_right)?.offset()(0)
            make?.top.bottom().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
        }
    }
    
    lazy var coinLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var idLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var typeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var timeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var statusLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
        if languageCode == .ZH{
            lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        }else{
            lbl.font = FONT_NORMAL(s: 10*Float(SCALE))
        }
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    func assignHisItem(item : BLAssetsSendHisItem){
        if item.asset_name != nil{
            coinLbl.text = item.asset_name
        }
        if item.asset_id != nil{
            idLbl.text = item.asset_id
        }
        if item.asset_type != nil{
            //资产类型（0是正常类型，即同质化代币，1是收藏品类型，即非同质化代币）
            let type : Int32 = Int32(item.asset_type!)!
            if type == 0{
                typeLbl.text = NSLocalized(key: "castOnCreatHisStateNormal")
            }else{
                typeLbl.text = NSLocalized(key: "castOnCreatHisStateNFT")
            }
        }
        if item.issuance_time != nil{
            timeLbl.text = BLTools.getFormaterWithTimeStr(timeStr: item.issuance_time! as NSString, formatStr: "yyyy-MM-dd HH:mm:ss")
        }
        if item.isFairLaunchIssuance != nil && item.state != nil{
            let status : String = self.getStutes(isFairLaunchIssuance: item.isFairLaunchIssuance!, status: item.state!)
            statusLbl.text = status
        }
    }
    
    func getStutes(isFairLaunchIssuance : String,status : String) -> String{
        let isFairLaunchIssuance : Bool = (isFairLaunchIssuance as NSString).boolValue
        let status : Int32 = Int32(status)!
        if isFairLaunchIssuance{
            switch status {
            case 0://FairLaunchStateNoPay
                return NSLocalized(key: "castOnSendUnpaid")
            case 1://FairLaunchStatePaidPending
                return NSLocalized(key: "castOnSendPaing")
            case 2://FairLaunchStatePaidNoIssue
                return NSLocalized(key: "castOnSendPaidButNotIssued")
            case 3://FairLaunchStateIssuedPending
                return NSLocalized(key: "castOnSendIssueing")
            case 4://FairLaunchStateIssued
                return NSLocalized(key: "castOnSendIssued")
            case 5://FairLaunchStateReservedSentPending
                return NSLocalized(key: "castOnSendRetainedAssetsIssueing")
            case 6://FairLaunchStateReservedSent
                return NSLocalized(key: "castOnSendRetainedAssetsIssued")
            default:
                return""
            }
        }else{
            switch status {
            case 0://BatchState_BATCH_STATE_UNKNOWN
                return NSLocalized(key: "castOnCreatHisStateUnkonw")
            case 1://BatchState_BATCH_STATE_PENDING
                return NSLocalized(key: "castOnCreatHisStateWaiting")
            case 2://BatchState_BATCH_STATE_FROZEN
                return NSLocalized(key: "castOnCreatHisStateFrozen")
            case 3://BatchState_BATCH_STATE_COMMITTED
                return NSLocalized(key: "castOnCreatHisStateSubmitted")
            case 4://BatchState_BATCH_STATE_BROADCAST
                return NSLocalized(key: "castOnCreatHisStateBroadcast")
            case 5://BatchState_BATCH_STATE_CONFIRMED
                return NSLocalized(key: "castOnCreatHisStateConfirmed")
            case 6://BatchState_BATCH_STATE_FINALIZED
                return NSLocalized(key: "castOnCreatHisStateSubmittedFinalize")
            case 7://BatchState_BATCH_STATE_SEEDLING_CANCELLED
                return NSLocalized(key: "castOnCreatHisStateSeedlingCancellation")
            case 8://BatchState_BATCH_STATE_SPROUT_CANCELLED
                return NSLocalized(key: "castOnCreatHisStateSproutCancellation")
            default:
                return""
            }
        }
    }
}
