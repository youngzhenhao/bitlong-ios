//
//  BLCollectionHisListView.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

@objc protocol HisListDelegate : NSObjectProtocol {
    func hisListClicked(hisItem : Any)
}

class BLCollectionHisListView: BLBaseView,UITabBarDelegate,UITableViewDataSource, UITableViewDelegate {

    var hisModel : BLCollectionHisModel?
    var hisInvoicesModel : BLInvoicesModel?
    var coinType : String?
    var pageType : AssetsDetailType?
    weak var delegate : HisListDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        self.addSubview(headerView)
        self.addSubview(tableView)
        
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)
            make?.left.right().bottom().mas_equalTo()(0)
        }
    }
    
    lazy var tableView : UITableView = {
        var table = self.getTableView()
        table.delegate = self
        table.dataSource = self
        table.register(BLCollectionHisListCell.self, forCellReuseIdentifier: BLCollectionHisListCellID)
        
        return table
    }()
    
    lazy var headerView : BLCollectionHisHeaderView = {
        var view = BLCollectionHisHeaderView.init()
        
        return view
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageType == .assetsType{
            if hisModel != nil && hisModel?.datas != nil{
                return (hisModel?.datas!.count)!
            }
        }else if pageType == .channelBTCType{
            if hisInvoicesModel != nil && hisInvoicesModel?.invoices != nil{
                return (hisInvoicesModel?.invoices!.count)!
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*SCALE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCollectionHisListCell = tableView.dequeueReusableCell(withIdentifier: BLCollectionHisListCellID)! as! BLCollectionHisListCell

        if pageType == .assetsType{
            if hisModel != nil && hisModel?.datas != nil{
                if indexPath.row < (hisModel?.datas!.count)!{
                    let hisItem : BLCollectionHisItem = (hisModel?.datas![indexPath.row])!
                    cell.assignHisItem(coinType: coinType ?? "sats", hisObj: hisItem)
                }
            }
        }else if pageType == .channelBTCType{
            if hisInvoicesModel != nil && hisInvoicesModel?.invoices != nil{
                if indexPath.row < (hisInvoicesModel?.invoices!.count)!{
                    let hisItem : BLInvoicesHisItem = (hisInvoicesModel?.invoices![indexPath.row])!
                    cell.assignHisItem(coinType: coinType ?? "sats", hisObj: hisItem)
                }
            }
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pageType == .assetsType{
            if hisModel != nil && hisModel?.datas != nil{
                if indexPath.row < (hisModel?.datas!.count)!{
                    let hisItem : BLCollectionHisItem = (hisModel?.datas![indexPath.row])!
                    if delegate != nil && (delegate?.responds(to: #selector(delegate?.hisListClicked(hisItem:)))) != nil{
                        delegate?.hisListClicked(hisItem: hisItem)
                    }
                }
            }
        }else{
            if hisInvoicesModel != nil && hisInvoicesModel?.invoices != nil{
                if indexPath.row < (hisInvoicesModel?.invoices!.count)!{
                    let hisItem : BLInvoicesHisItem = (hisInvoicesModel?.invoices![indexPath.row])!
                    if delegate != nil && (delegate?.responds(to: #selector(delegate?.hisListClicked(hisItem:)))) != nil{
                        delegate?.hisListClicked(hisItem: hisItem)
                    }
                }
            }
        }
    }
    
    func assignHisModel(type : String, model : Any){
        coinType = type
        if model is BLCollectionHisModel{
            hisModel = (model as! BLCollectionHisModel)
        }else if model is BLInvoicesModel{
            hisInvoicesModel = (model as! BLInvoicesModel)
        }
       
        self.tableView.reloadData()
    }
}
