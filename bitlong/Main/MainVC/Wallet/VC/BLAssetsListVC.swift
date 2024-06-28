//
//  BLAssetsListVC.swift
//  bitlong
//
//  Created by slc on 2024/6/5.
//

import UIKit

class BLAssetsListVC: BLBaseVC {
    
    var walletBalanceModel: BLWalletBalanceModel?
    var assetsInfoList : NSMutableArray = NSMutableArray.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        self.getLocalData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.tableView.mj_header = self.gifHeader
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        self.tableView.register(BLCoinAssetsCell.self, forCellReuseIdentifier: BLCoinAssetsCellId)
    }
    
    func assignWalletBalanceModel(model : BLWalletBalanceModel){
        walletBalanceModel = model
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
    }
    
    func getLocalData(){
        let assetsObj = userDefaults.object(forKey: AssetsInfo)
        if assetsObj != nil && assetsObj is NSArray{
            assetsInfoList.removeAllObjects()
            let assetsList : NSArray = assetsObj as! NSArray
            assetsInfoList.addObjects(from: assetsList as! [Any])
        }
        
        let obj = BLTools.nSKeyedUnarchiverPath(path: KNSDocumentPath(name: Key_Assets))
        if obj is NSArray{
            self.filterAssets(assets: obj as! NSArray, isInsert: true)
        }
    }

    override func loadData() {
        self.getLocalData()
        
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        let assetsModel: BLAssetsModel = BLWalletViewModel.getAssetsModel()
        //获取资产列表
        if assetsModel.datas != nil && 0 < assetsModel.datas!.count{
            let assets : NSArray = assetsModel.datas! as NSArray
            self.filterAssets(assets: assets, isInsert: false)
        }
        
        self.gifHeader.endRefreshing()
    }
    
    func filterAssets(assets : NSArray,isInsert : Bool){
        if 0 < assetsInfoList.count{
            let localInfoList : NSArray = assetsInfoList
            for item in assets{
                autoreleasepool {
                    let assetsItem : BLAssetsItem = item as! BLAssetsItem
                    //这里需要和本地做一个去重
                    for obj in localInfoList{
                        autoreleasepool {
                            if obj is NSDictionary{
                                let dic : NSDictionary = obj as! NSDictionary
                                if dic[AssetsName] as! String == assetsItem.name!{
                                    assetsInfoList.remove(obj)
                                }
                            }else if obj is BLAssetsItem{
                                let item : BLAssetsItem = obj as! BLAssetsItem
                                if item.name == assetsItem.name!{
                                    assetsInfoList.remove(obj)
                                }
                            }
                        }
                    }
                    
                    if isInsert{
                        assetsInfoList.insert(assetsItem, at: 0)
                    }else{
                        assetsInfoList.add(assetsItem)
                    }
                }
            }
        }else{
            assetsInfoList = NSMutableArray.init(array: assets)
        }
        
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + assetsInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCoinAssetsCell = tableView.dequeueReusableCell(withIdentifier: BLCoinAssetsCellId)! as! BLCoinAssetsCell
        if indexPath.row == 0{
            cell.bottomLine.isHidden = true
        }else{
            cell.bottomLine.isHidden = false
        }
       
        if indexPath.row == 0{
            cell.assignBtc(model: walletBalanceModel as Any)
        }else{
            if indexPath.row - 1 < assetsInfoList.count{
                cell.assignAssets(assetsObj: assetsInfoList[indexPath.row - 1])
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
        var assetsItem : BLAssetsItem?
        if indexPath.row != 0{
            if indexPath.row - 1 < assetsInfoList.count{
                let obj = assetsInfoList[indexPath.row - 1]
                if obj is NSDictionary{
                    let dic : NSDictionary = obj as! NSDictionary
                    let item : BLAssetsItem = BLAssetsItem.init()
                    item.name = dic[AssetsName] as? String
                    item.balance = dic[AssetsNum] as? NSString
                    assetsItem = item
                }else if obj is BLAssetsItem{
                    assetsItem = (obj as! BLAssetsItem)
                }
            }
        }
        
        let assetsDetailVC : BLAssetsDetailVC = BLAssetsDetailVC.init()
        assetsDetailVC.assignAssets(item: assetsItem as Any, type: indexPath.row == 0 ? .BTCType : .assetsType)
        assetsDetailVC.hidesBottomBarWhenPushed = true
        self.pushBaseVC(vc: assetsDetailVC, animated: true)
    }
}
