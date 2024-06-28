//
//  BLAssetsTransferVC.swift
//  bitlong
//
//  Created by slc on 2024/5/14.
//

import UIKit

class BLAssetsTransferVC: BLBaseVC,TransferDelegate {

    var pageType : AssetsDetailType?
    var assetsItem : BLAssetsItem?
    var walletBalanceModel : BLWalletBalanceModel?
    var addressType : AddressType?
    var addressStr : String?
    var amountStr : String?
    var descriptionStr : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalized(key: "transferNavTitle")
        
        self.initUI()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initUI(){
        self.view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.tableView.backgroundColor = self.view.backgroundColor
        self.tableView.isScrollEnabled = false
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
        }
        
        self.tableView.register(BLTransferAddressCell.self, forCellReuseIdentifier: BLTransferAddressCellId)
        self.tableView.register(BLTransferCoinTypeCell.self, forCellReuseIdentifier: BLTransferCoinTypeCellId)
        self.tableView.register(BLTransferAmountCell.self, forCellReuseIdentifier: BLTransferAmountCellId)
        self.tableView.register(BLTransferPostscriptCell.self, forCellReuseIdentifier: BLTransferPostscriptCellId)
    }
    
    override func loadData() {

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 150*SCALE
        }else if indexPath.section == 1{
            return 65*SCALE
        }else if indexPath.section == 2{
            return 90*SCALE
        }
        
        return 113*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : BLTransferAddressCell = tableView.dequeueReusableCell(withIdentifier: BLTransferAddressCellId)! as! BLTransferAddressCell
            cell.delegate = self
            if addressStr != nil{
                cell.assignAddress(str: addressStr!)
            }
            
            return cell
        }else if indexPath.section == 1{
            let cell : BLTransferCoinTypeCell = tableView.dequeueReusableCell(withIdentifier: BLTransferCoinTypeCellId)! as! BLTransferCoinTypeCell
            if addressType == .addressBTC{
                cell.assignAddressType(type: "BTC")
            }else if addressType == .addressAssets{
                if assetsItem != nil && assetsItem?.name != nil{
                    cell.assignAddressType(type: (assetsItem?.name)!)
                }
            }else if addressType == .addressInvoice{
                cell.assignAddressType(type: "BTC")
            }
            
            return cell
        }else if indexPath.section == 2{
            let cell : BLTransferAmountCell = tableView.dequeueReusableCell(withIdentifier: BLTransferAmountCellId)! as! BLTransferAmountCell
            if amountStr != nil{
                cell.assignAmount(amount: amountStr!)
            }
            
            return cell
        }else{
            let cell : BLTransferPostscriptCell = tableView.dequeueReusableCell(withIdentifier: BLTransferPostscriptCellId)! as! BLTransferPostscriptCell
            if descriptionStr != nil{
                cell.assignDestination(des: descriptionStr!)
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 70*SCALE
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3{
            let view : UIView = UIView.init()
            let bt = UIButton.init()
            bt.setTitle(NSLocalized(key: "transferConfirm"), for: .normal)
            bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_NORMAL(s: 18*Float(SCALE))
            bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
            bt.layer.cornerRadius = 24*SCALE
            bt.clipsToBounds = true
            bt.addTarget(self, action: #selector(transferConfirmAcation), for: .touchUpInside)
            view.addSubview(bt)
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(20*SCALE)
                make?.bottom.mas_equalTo()(0)
                make?.left.mas_equalTo()(24*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
            }
            
            return view
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //TransferDelegate
    func addressChanged(text: String) {
        self.getDecodeAddr(codeStr: text)
    }
    
    func amountChanged(text: String) {
        amountStr = text
    }
    
    func scanAcation() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        let vc : BLQRScanVC = BLQRScanVC.init()
        vc.callBack = { [weak self] codeStr in
            self?.getDecodeAddr(codeStr: codeStr)
        }
        self.pushBaseVC(vc: vc, animated: true)
    }

    func getDecodeAddr(codeStr : String){
        addressStr = codeStr
        
        if 0 < codeStr.count{
            addressType = BLTools.addressType(address: codeStr)
            if addressType == .addressBTC{//比特币
                self.tableView.reloadData()
            }else if addressType == .addressAssets{//资产
                let jsonStr : String = ApiDecodeAddr(codeStr)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    let assetDecodeModel : BLAssetAddressDecodeModel = BLWalletViewModel.getAssetAddressDecode(jsonStr: jsonStr)
                    amountStr = assetDecodeModel.amount
    //                   if assetDecodeModel.tapscript_sibling != nil{
    //                       self?.destinationStr = assetDecodeModel.tapscript_sibling
    //                   }
                }else{
                    BLTools.showTost(tip: status, superView: (self.view)!)
                }
                
                self.tableView.reloadData()
            }else if addressType == .addressInvoice{//发票
                let jsonStr : String = ApiDecodePayReq(codeStr)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    let lightingDecodeModel : BLLightingAddressDecodeModel = BLWalletViewModel.getLightingAddressDecode(jsonStr: jsonStr)
                    amountStr = lightingDecodeModel.amount

                    if lightingDecodeModel.descriptions != nil{
                        descriptionStr = lightingDecodeModel.descriptions
                    }
                }else{
                    BLTools.showTost(tip: status, superView: (self.view)!)
                }
                
                self.tableView.reloadData()
            }else{
                BLTools.showTost(tip: NSLocalized(key: "transferAddressError"), superView: (self.view)!)
            }
        }
    }
    
    //确认转账
    @objc func transferConfirmAcation(){
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        var amount : Int64 = 0
        let feeRate : Int64 = 0
        
        if addressStr == nil || addressStr!.count <= 0{
            BLTools.showTost(tip: NSLocalized(key: "transferAddressNil"), superView: self.view)
            return
        }
        
        if amountStr != nil{
            amount = Int64(amountStr!)!
        }
        
        if amount <= 0{
            BLTools.showTost(tip: NSLocalized(key: "transferAmountNil"), superView: self.view)
            return
        }
        
        if addressType == .addressBTC{
            let sendCoins : String = ApiSendCoins(addressStr, amount, feeRate, false)//true全部发送btc，指定费率 0自动判断
            let status = BLTools.getResaultStatus(jsonStr: sendCoins as String)
            if status == APISECCUSS{
                self.back()
                BLTools.showTost(tip: NSLocalized(key: "transferSeccuse"), superView: appDelegate.window)
            }else{
                BLTools.showTost(tip: status, superView: self.view)
            }
        }else if addressType == .addressAssets{
            //资产地址金额不可能为0，发票有可能
            let addrs : NSArray = [addressStr as Any]
            let status : String = ApiSendAssets(addrs.mj_JSONString(), feeRate)
            if status == APISECCUSS{
                self.back()
                BLTools.showTost(tip: NSLocalized(key: "transferSeccuse"), superView: appDelegate.window)
            }else{
                BLTools.showTost(tip: status, superView: self.view)
            }
        }else if addressType == .addressInvoice{
            let param = ["invoice" : addressStr as Any,"feeLimit" : feeRate] as [String : Any]
            BLWalletViewModel.invoiceInvoicePay(param: param as NSDictionary) { [weak self] respObj in
                if let payment = respObj["payment"]{
                    if payment is String{
                        if payment as! String == "success"{
                            BLTools.showTost(tip: NSLocalized(key: "transferSeccuse"), superView: (self?.view)!)
                        }
                    }
                }
            } failed: { [weak self] error in
                BLTools.showTost(tip: NSLocalized(key: "transferFailed"), superView: (self?.view)!)
            }
        }
    }
}
