//
//  BLAssetsDetailCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/13.
//

import UIKit

let BLAssetsDetailCellId = "BLAssetsDetailCellId"

class BLAssetsDetailCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(addressLbl)
        self.contentView.addSubview(copyBt)
        self.contentView.addSubview(valueLbl)
        self.contentView.addSubview(lineLbl)
        
        addressLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(15*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.height.mas_equalTo()(17*SCALE)
            make?.right.mas_equalTo()(copyBt.mas_left)?.offset()(-10*SCALE)
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.width.height().mas_equalTo()(18*SCALE)
            make?.centerY.mas_equalTo()(addressLbl.mas_centerY)
        }
        
        valueLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(120*SCALE)
            make?.bottom.mas_equalTo()(-5*SCALE)
        }
        
        lineLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(addressLbl.mas_left)
            make?.right.mas_equalTo()(valueLbl.mas_right)
            make?.height.mas_equalTo()(0.5*SCALE)
            make?.bottom.mas_equalTo()(0)
        }
    }
    
    lazy var addressLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.8)
        lbl.font = FONT_NORMAL(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
        
        return lbl
    }()
    
    lazy var copyBt : UIButton = {
        var bt = UIButton.init()
        bt.setBackgroundImage(imagePic(name: "ic_wallet_copy"), for: .normal)
        bt.addTarget(self, action: #selector(pastAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var valueLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x50AF95, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var lineLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1.0)
        
        return lbl
    }()
    
    @objc func pastAcation(){
        BLTools.pasteGeneral(string: addressLbl.text as Any)
    }
    
    func assignAssets(item : Any, type : Any){
        if item is BLBTCDetailItem{
            let btcDetailItem : BLBTCDetailItem = item as! BLBTCDetailItem
            addressLbl.text = btcDetailItem.address
            if type is String{
                valueLbl.text = String.init(format: "%@ %@", btcDetailItem.balance!,type as! String)
            }else{
                valueLbl.text = String.init(format: "%@ %@", btcDetailItem.balance!,"sats")
            }
        }else if item is BLAssetsDetailItem{
            let assetsDetailItem : BLAssetsDetailItem = item as! BLAssetsDetailItem
            if assetsDetailItem.addr != nil{
                let addr : BLAssetsAddrItem = assetsDetailItem.addr!
                addressLbl.text = addr.encoded
                if type is String{
                    valueLbl.text = String.init(format: "%@ %@", addr.amount!,type as! String)
                }else{
                    valueLbl.text = String.init(format: "%@ %@", addr.amount!,"sats")
                }
            }
        }else if item is BLInvoicesPaymentItem{
            let paymentItem : BLInvoicesPaymentItem = item as! BLInvoicesPaymentItem
            if paymentItem.invoice != nil{
                addressLbl.text = paymentItem.invoice
                if type is String{
                    valueLbl.text = String.init(format: "%@ %@", paymentItem.amount!,type as! String)
                }else{
                    valueLbl.text = String.init(format: "%@ %@", paymentItem.amount!,"sats")
                }
            }
        }
    }
}
