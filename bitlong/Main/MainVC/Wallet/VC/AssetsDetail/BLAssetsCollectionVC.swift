//
//  BLAssetsCollectionVC.swift
//  bitlong
//
//  Created by slc on 2024/5/14.
//

import UIKit

class BLAssetsCollectionVC: BLBaseVC,CollectionDelegate,ItemClickAcationDelegate,HisListDelegate {
    
    var pageType : AssetsDetailType?
    var assetsItem : BLAssetsItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收款"
        self.view.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        
        if pageType == .BTCType{
            self.initBTCUI()
        }else if pageType == .assetsType{
            self.initAssetsUI()
            self.getQueryHisAddrs()
        }else if pageType == .channelBTCType{
            self.initAssetsUI()
            self.getInvoiceQueryInvoice()
        }
        
        self.startWebService()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func startWebService(){
        DispatchQueue.global().async {
            ApiLnurlPhoneWebService()
        }
        
//        let lnurlGetPortAvailable : String = ApiLnurlGetPortAvailable()
//        let lnurlGetNewId : String = ApiLnurlGetNewId()
//        let walletDic : NSDictionary = userDefaults.object(forKey: WalletInfo) as! NSDictionary
//        let walletName = walletDic[WalletName] as? String
//        let addressStr : String = ApiLnurlUploadUserInfo(lnurlGetNewId, walletName, "9090", lnurlGetPortAvailable)
//        NSSLog(msg: addressStr)
        
        let obj = userDefaults.value(forKeyPath: WalletAddress)
        if obj != nil && obj is String{
            collectionView.assignCollectionInfo(address: obj as! String)
        }
    }
    
    /*
     btc
     */
    func initBTCUI(){
        self.view.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        self.view.addSubview(collectionView)
        collectionView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight+5*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()(viewHeight)
        }
    }
    
    lazy var collectionView : BLCollectionView = {
        var view = BLCollectionView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        view.delegate = self
        
        return view
    }()
    
    //CollectionDelegate
    func itemClickAcation(sender: UIButton, address: String) {
        if sender.tag == 100{//切换地址
            let BTCAddresVC : BLCollectionBTCAddresVC = BLCollectionBTCAddresVC.init()
            BTCAddresVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BTCAddresVC, animated: true)
            BTCAddresVC.callBack = { [weak self] address in
                self?.collectionView.assignCollectionInfo(address: address)
            }
        }else if sender.tag == 101{//分享
            
        }else if sender.tag == 102{//复制
            BLTools.pasteGeneral(string: address)
        }
    }
    
    /*
     资产
     */
    func initAssetsUI(){
        self.view.addSubview(collectionItemView)
        self.view.addSubview(assetsCollectionView)
        self.view.addSubview(creatBt)
        self.view.addSubview(hisListLbl)
        self.view.addSubview(hisListView)
        collectionItemView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight + 10*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()(58*SCALE)
        }
        
        assetsCollectionView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(collectionItemView.mas_bottom)
            make?.height.mas_equalTo()(244*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
        }
        
        creatBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(assetsCollectionView.mas_bottom)?.offset()(20*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        hisListLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(creatBt.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
        }
        
        hisListView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(hisListLbl.mas_bottom)?.offset()(5*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.bottom.mas_equalTo()(-10*SCALE)
        }
        
        assetsCollectionView.initInvoiceUI()
        if assetsItem != nil{
            assetsCollectionView.assignAssetsItem(obj: assetsItem as Any)
        }else{
            assetsCollectionView.assignAssetsItem(obj: "BTC" as Any)
        }
        
        assetsCollectionView.layoutIfNeeded()
        self.setCornerRadius(view: assetsCollectionView)
    }
    
    func setCornerRadius(view : UIView){
        let cornerRadiusPath : UIBezierPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners:[.bottomLeft,.bottomRight], cornerRadii:CGSize.init(width: 12 * SCALE, height: 12 * SCALE))
        let cornerRadiusLayer : CAShapeLayer = CAShapeLayer.init()
        cornerRadiusLayer.frame = view.bounds
        cornerRadiusLayer.path = cornerRadiusPath.cgPath
        view.layer.mask = cornerRadiusLayer
    }
    
    lazy var collectionItemView : BLAssetsCollectionItemView = {
        var view = BLAssetsCollectionItemView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var assetsCollectionView : BLAssetsCollectionView = {
        var view = BLAssetsCollectionView.init()
        
        return view
    }()
    
    lazy var creatBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("创建", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x2A82E4, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        bt.layer.cornerRadius = 24*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(creatAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var hisListLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "历史记录"
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()

    lazy var hisListView : BLCollectionHisListView = {
        var view = BLCollectionHisListView.init()
        view.layer.cornerRadius = 12*SCALE
        view.clipsToBounds = true
        view.delegate = self
        view.pageType = pageType
        
        return view
    }()
    
    lazy var invoiceQRView : BLCollectionInvoiceQRView = {
        var view = BLCollectionInvoiceQRView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.callBack = {
            view.removeFromSuperview()
        }
        
        return view
    }()
    
    //ItemClickAcationDelegate
    func itemClickAcation(sender: UIButton) {
        if sender.tag == 100{//发票
            if pageType == .assetsType{
                
            }else if pageType == .channelBTCType{
                
            }
        }else if sender.tag == 101{//LNRUL
            if pageType == .assetsType{
                
            }else if pageType == .channelBTCType{
                
            }
        }else if sender.tag == 102{//闪电地址
            if pageType == .assetsType{
                
            }else if pageType == .channelBTCType{
                
            }
        }
    }
    
    //HisListDelegate
    func hisListClicked(hisItem: Any) {
        self.view.addSubview(invoiceQRView)
        invoiceQRView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        invoiceQRView.assignHisItem(obj: hisItem, title: pageType == .assetsType ? "资产发票二维码" : "发票二维码")
    }
    
    @objc func creatAcation(){
        let amount : NSInteger = assetsCollectionView.amount()
        
        if pageType == .assetsType{
            if assetsItem == nil || assetsItem?.asset_id == nil{
                BLTools.showTost(tip: "资产id不能为空", superView: self.view)
                return
            }
            if amount <= 0 {
                BLTools.showTost(tip: "金额不合法", superView: self.view)
                return
            }
            
            let jsonStr : String = ApiNewAddr(assetsItem?.asset_id, amount)
            let status = BLTools.getResaultStatus(jsonStr: jsonStr)
            if status == APISECCUSS{
                //暂时存储时间
                self.creatInvoiceTime(key: (assetsItem?.asset_id)!)
                
                self.getQueryHisAddrs()
            }else{
                BLTools.showTost(tip: status, superView: self.view)
            }
        }else if pageType == .channelBTCType{
            if amount <= 0 {
                BLTools.showTost(tip: "金额不合法", superView: self.view)
                return
            }
            
            let postscript : String = assetsCollectionView.postscript()
            let param : NSDictionary = ["amount" : amount, "memo" : postscript]
            BLWalletViewModel.invoiceInvoiceApply(param: param) { [weak self] respObj in
                NSSLog(msg: String.init(format: "respObj:%@",respObj))
                //暂时存储时间
                let dic : NSDictionary = respObj
                if dic["invoice"] != nil{
                    self?.creatInvoiceTime(key: dic["invoice"] as! String)
                }
                self?.getInvoiceQueryInvoice()
            } failed: { error in
                NSSLog(msg: String.init(format: "error:%@",error))
            }
        }
    }
    
    func creatInvoiceTime(key : String){
        let obj = userDefaults.object(forKey: AssetsInvoiceCreatTime)
        var creatTimeDic : NSMutableDictionary = NSMutableDictionary.init()
        if obj != nil && obj is NSDictionary{
            creatTimeDic = NSMutableDictionary.init(dictionary: obj as! NSDictionary)
        }
        let md5Str : NSString  = (key as NSString).fromMD5()! as NSString
        creatTimeDic.setValue(BLTools.getFormater(date: nil, formatStr: "yyyy-MM-dd HH:mm:ss"), forKey: md5Str as String)
        userDefaults.set(creatTimeDic, forKey: AssetsInvoiceCreatTime)
        userDefaults.synchronize()
    }
    
    //获取发票历史
    func getQueryHisAddrs(){
        let jsonStr : String = ApiQueryAddrs(assetsItem?.asset_id)
        let hisModel : BLCollectionHisModel = BLWalletViewModel.getQueryHisAddrs(jsonStr: jsonStr)
        hisListView.assignHisModel(type: (assetsItem?.name)!, model: hisModel)
        
        if hisModel.datas == nil || hisModel.datas!.count <= 0{
            self.addNoDataView(superView: hisListView.tableView, isBig: false)
        }else{
            self.removeNoDataView()
        }
    }
    
    //查询发票
    func getInvoiceQueryInvoice(){
        BLWalletViewModel.invoiceQueryInvoice(assetId: "00") { [weak self] dic in
            let invoicesModel : BLInvoicesModel = BLInvoicesModel.mj_object(withKeyValues: dic)
            self?.hisListView.assignHisModel(type: "sats", model: invoicesModel)
            
            self?.tableView.reloadData()
            
            if invoicesModel.invoices == nil || invoicesModel.invoices!.count <= 0{
                self?.addNoDataView(superView: (self?.hisListView.tableView)!, isBig: false)
            }else{
                self?.removeNoDataView()
            }
        } failed: { [weak self] respModel in
            BLTools.showTost(tip: "查询发票失败", superView: (self?.view)!)
            
            self?.addNoDataView(superView: (self?.hisListView.tableView)!, isBig: false)
        }
    }
}
