//
//  BLAssetsCoinDetailVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/4.
//

import UIKit

class BLAssetsCoinDetailVC: BLBaseVC,CoinDetailViewDelegate {
    
    var coinDetailModel : BLAssetsCoinDetailModel?
    var assetsItem : BLAssetsItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "代币详情"
        
        self.initUI()
        self.loadData()
    }
    
    func initUI(){
        self.view.addSubview(coinDetailView)
        coinDetailView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(coinDetailView.frame.height)
        }
    }
    
    override func loadData() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        if assetsItem != nil{
            let jsonStr : String = ApiGetAssetInfo(assetsItem?.asset_id)
            let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
            if status == APISECCUSS{
                let coinDetailModel : BLAssetsCoinDetailModel = BLWalletViewModel.getCoinDetailModel(jsonStr: jsonStr)
                coinDetailView.assignCoinDetailModel(model: coinDetailModel)
            }else{
                BLTools.showTost(tip: status, superView: self.view)
            }
        }
    }
    
    lazy var coinDetailView : BLAssetsCoinDetailView = {
        var view = BLAssetsCoinDetailView.init()
        view.delegate = self
        
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
    
    //CoinDetailViewDelegate
    func showAssetQR(qrStr: String) {
        self.view.addSubview(invoiceQRView)
        invoiceQRView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        let hisItem : BLCollectionHisItem = BLCollectionHisItem.init()
        hisItem.encoded = qrStr
        invoiceQRView.assignHisItem(obj: hisItem, title: "资产二维码")
    }
}
