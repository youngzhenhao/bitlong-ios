//
//  BLAssetsDetailVC.swift
//  bitlong
//
//  Created by slc on 2024/5/13.
//

import UIKit

class BLAssetsDetailVC: BLBaseVC,DetailHeaderDelegate,DetailItemViewDelegate {
    var pageType : AssetsDetailType?
    var balanceModel: BLWalletBalanceModel?
    var btcDetailModel : BLBTCDetailModel?
    var assetsDetailModel : BLAssetsDetailModel?
    var assetsItem : BLAssetsItem?
    var paymentModel : BLInvoicesPaymentModel?
    var isPaymentInto : Bool = true //是否收款转入，默认true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "资产详情"
        
        self.initUI()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }
    
    func initUI(){
        self.view.addSubview(detailHeader)
        self.view.addSubview(allTitleLbl)
        self.view.addSubview(detailItemView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(transferBt)
        self.view.addSubview(collectionBt)
        detailHeader.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(detailHeader.headerHeight+10*SCALE)
        }
        
        allTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(detailHeader.mas_bottom)?.offset()(10*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
        }
        
        detailItemView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(allTitleLbl.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(45*SCALE)
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(detailItemView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight-95*SCALE)
        }
        
        transferBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(self.view.mas_centerX)?.offset()(-8*SCALE)
            make?.height.mas_equalTo()(65*SCALE)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight-15*SCALE)
            make?.width.mas_equalTo()(151*SCALE)
        }
        
        collectionBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(self.view.mas_centerX)?.offset()(8*SCALE)
            make?.height.mas_equalTo()(65*SCALE)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight-15*SCALE)
            make?.width.mas_equalTo()(151*SCALE)
        }
        
        transferBt.iconInTop(spacing: 0)
        collectionBt.iconInTop(spacing: 8*SCALE)
        
        self.tableView.mj_header = self.gifHeader
        self.tableView.register(BLAssetsDetailCell.self, forCellReuseIdentifier: BLAssetsDetailCellId)
    }
    
    func assignAssets(item : Any,type:AssetsDetailType){
        if item is BLAssetsItem{
            assetsItem = (item as! BLAssetsItem)
        }
        detailHeader.assignAssets(item: item,type: type)
        pageType = type
    }
    
    override func loadData(){
        DispatchQueue.global().async { [weak self] in
            if self?.pageType == .BTCType{
                //获取钱包信息
                if self?.balanceModel == nil{
                    self?.balanceModel = BLWalletViewModel.getWalletBalance()
                }
                DispatchQueue.main.async { [weak self] in
                    self?.detailHeader.assignBalance(obj: self?.balanceModel as Any)
                }
            }else if self?.pageType == .assetsType{
                if self?.assetsItem != nil{
//                    var model : BLWalletBalanceModel = BLWalletBalanceModel.init()
//                    model.confirmed_balance = self?.assetsItem?.balance
                    DispatchQueue.main.async { [weak self] in
                        self?.detailHeader.assignBalance(obj: self?.assetsItem as Any)
                    }
                }
            }else if self?.pageType == .channelBTCType{
                if self?.balanceModel != nil{
                    DispatchQueue.main.async { [weak self] in
                        self?.detailHeader.assignBalance(obj: self?.balanceModel as Any)
                    }
                }
                self?.getInvoiceQuerypayment()
            }
            
            self?.getChangeInfo(isInto: (self?.isPaymentInto)!, isLoadData: true)
        }
    }
    
    func getChangeInfo(isInto : Bool, isLoadData : Bool){
        isPaymentInto = isInto
        
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            DispatchQueue.main.async { [weak self] in
                self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                BLTools.showTost(tip: "LND正在同步中...", superView: (self?.view)!)
            }
            return
        }
        
        var jsonStr : String?
        if isInto{//转入
            if pageType == .BTCType{
                jsonStr = ApiGetNonZeroBalanceAddresses()
            }else if pageType == .assetsType{
                if assetsItem != nil && assetsItem?.asset_id != nil{
                    jsonStr = ApiAddrReceives(assetsItem?.asset_id)
                }
            }else if pageType == .channelBTCType{
            }
        }else{//转出
            if pageType == .BTCType{
                
            }else if pageType == .assetsType{
                if assetsItem != nil && assetsItem?.asset_id != nil{
                    jsonStr = ApiQueryAssetTransfers(assetsItem?.asset_id)
                }
            }else if pageType == .channelBTCType{
            }
        }
        if jsonStr != nil && jsonStr != ""{
            let status = BLTools.getResaultStatus(jsonStr: jsonStr!)
            if status == APISECCUSS{
                let jsobObj : NSDictionary = jsonStr!.mj_JSONObject() as! NSDictionary
                
                if pageType == .BTCType{
                    btcDetailModel = BLBTCDetailModel.mj_object(withKeyValues: jsobObj)
                }else if pageType == .assetsType{
                    assetsDetailModel = BLAssetsDetailModel.mj_object(withKeyValues: jsobObj)
                }else if pageType == .channelBTCType{
                    
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async { [weak self] in
                    BLTools.showTost(tip: status, superView: (self?.view)!)
                }
            }
        }else{
            if pageType == .BTCType{
                btcDetailModel = BLBTCDetailModel.init()
            }else if pageType == .assetsType{
                assetsDetailModel = BLAssetsDetailModel.init()
            }else if pageType == .channelBTCType{
            }
            
            DispatchQueue.main.async { [weak self] in
                if self?.pageType == .channelBTCType{//第一次加载，通道发票这里不reload
                    if !isLoadData{
                        self?.tableView.reloadData()
                    }
                }else{
                    self?.tableView.reloadData()
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            if self?.pageType == .BTCType{
                if self?.btcDetailModel == nil || self?.btcDetailModel?.datas == nil || (self?.btcDetailModel?.datas!.count)! <= 0 {
                    self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                }else{
                    self?.removeNoDataView()
                }
            }else if self?.pageType == .assetsType{
                if self?.assetsDetailModel == nil || self?.assetsDetailModel?.datas == nil || (self?.assetsDetailModel?.datas!.count)! <= 0 {
                    self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                }else{
                    self?.removeNoDataView()
                }
            }
        }
    }
    
    func getInvoiceQuerypayment(){
        BLWalletViewModel.invoiceQueryPayment(assetId: "00") { [weak self] model in
            self?.paymentModel = model
            self?.tableView.reloadData()
            self?.gifHeader.endRefreshing()
        } failed: { [weak self] error in
            self?.gifHeader.endRefreshing()
            BLTools.showTost(tip: "查询发票失败！", superView: (self?.view)!)
        }
    }
    
    lazy var detailHeader : BLAssetsDetailHeader = {
        var header = BLAssetsDetailHeader.init()
        header.delegate = self
        
        return header
    }()
    
    lazy var transferBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("转账", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.setImage(imagePic(name: "ic_walletDetail_transfer"), for: .normal)
        bt.backgroundColor = UIColorHex(hex: 0xFD8FB0, a: 0.1)
        bt.layer.cornerRadius = 10*SCALE
        bt.clipsToBounds = true
        bt.tag = 100
        bt.addTarget(self, action: #selector(deleteWalletAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var collectionBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("收款", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.setImage(imagePic(name: "ic_walletDetail_inPut"), for: .normal)
        bt.backgroundColor = UIColorHex(hex: 0x6DC0FC, a: 0.1)
        bt.layer.cornerRadius = 10*SCALE
        bt.clipsToBounds = true
        bt.tag = 101
        bt.addTarget(self, action: #selector(deleteWalletAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var allTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "全部"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var detailItemView : BLAssetsDetailItemView = {
        var view = BLAssetsDetailItemView.init()
        view.delegate = self
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageType == .BTCType{
            if btcDetailModel != nil && btcDetailModel?.datas != nil{
                return (btcDetailModel?.datas!.count)!
            }
        }else if pageType == .assetsType{
            if assetsDetailModel != nil && assetsDetailModel?.datas != nil{
                return (assetsDetailModel?.datas!.count)!
            }
        }else if pageType == .channelBTCType{
            if isPaymentInto{
                if paymentModel?.paymentsIn != nil{
                    return (paymentModel?.paymentsIn!.count)!
                }
            }else{
                if paymentModel?.paymentsOut != nil{
                    return (paymentModel?.paymentsOut!.count)!
                }
            }
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLAssetsDetailCell = tableView.dequeueReusableCell(withIdentifier: BLAssetsDetailCellId)! as! BLAssetsDetailCell
        if pageType == .BTCType{
            if btcDetailModel != nil && btcDetailModel?.datas != nil{
                if indexPath.row < (btcDetailModel?.datas!.count)!{
                    let item : BLBTCDetailItem = (btcDetailModel?.datas![indexPath.row])!
                    cell.assignAssets(item: item, type: "sats")
                }
            }
        }else if pageType == .assetsType{
            if assetsDetailModel != nil && assetsDetailModel?.datas != nil{
                if indexPath.row < (assetsDetailModel?.datas!.count)!{
                    let item : BLAssetsDetailItem = (assetsDetailModel?.datas![indexPath.row])!
                    cell.assignAssets(item: item, type: assetsItem?.name as Any)
                }
            }
        }else if pageType == .channelBTCType{
            if isPaymentInto{
                if paymentModel?.paymentsIn != nil {
                    if indexPath.row < (paymentModel?.paymentsIn?.count)!{
                        let item = paymentModel?.paymentsIn?[indexPath.row]
                        cell.assignAssets(item: item as Any, type: assetsItem?.name as Any)
                    }
                }
            }else{
                if paymentModel?.paymentsOut != nil {
                    if indexPath.row < (paymentModel?.paymentsOut?.count)!{
                        let item = paymentModel?.paymentsOut?[indexPath.row]
                        cell.assignAssets(item: item as Any, type: assetsItem?.name as Any)
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func highModelAcation(){
    }
    
    //DetailHeaderDelegate
    func assetsDetailAcation() {
        let vc : BLAssetsCoinDetailVC = BLAssetsCoinDetailVC.init()
        vc.assetsItem = assetsItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //DetailItemViewDelegate
    func itemSelectAcation(sender: UIButton) {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        if sender.tag == 100{//转入
            DispatchQueue.global().async { [weak self] in
                self?.getChangeInfo(isInto: true, isLoadData: false)
            }
        }else if sender.tag == 101{//转出
            DispatchQueue.global().async { [weak self] in
                self?.getChangeInfo(isInto: false, isLoadData: false)
            }
        }
    }
    
    @objc func deleteWalletAcation(sender : UIButton){
        if sender.tag == 100{//转账
            let transferVC : BLAssetsTransferVC = BLAssetsTransferVC.init()
            transferVC.hidesBottomBarWhenPushed = true
            transferVC.pageType = pageType
            transferVC.assetsItem = assetsItem
            self.navigationController?.pushViewController(transferVC, animated: true)
        }else{//收款
            let collectionVC : BLAssetsCollectionVC = BLAssetsCollectionVC.init()
            collectionVC.hidesBottomBarWhenPushed = true
            collectionVC.pageType = pageType
            collectionVC.assetsItem = assetsItem
            self.navigationController?.pushViewController(collectionVC, animated: true)
        }
    }
}
