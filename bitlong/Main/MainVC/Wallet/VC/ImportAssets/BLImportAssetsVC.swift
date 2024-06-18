//
//  BLImportAssetsVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/3.
//

import UIKit

class BLImportAssetsVC: BLBaseVC,ImportAssetsDelegate {
    
    var assetsIDCell  : BLImportAssetsIDCell?
    var universeAddressCell : BLImportUniverseAddressCell?
    var assetsDetailCell : BLImportAssetsDetailCell?
    var coinDetailModel : BLAssetsCoinDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "导入资产"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    func initUI(){
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().bottom().mas_equalTo()(0)
        }
        
        self.tableView.register(BLImportAssetsIDCell.self, forCellReuseIdentifier: BLImportAssetsIDCellId)
        self.tableView.register(BLImportUniverseAddressCell.self, forCellReuseIdentifier: BLImportUniverseAddressCellId)
        self.tableView.register(BLImportAssetsDetailCell.self, forCellReuseIdentifier: BLImportAssetsDetailCellId)
    }
    
    lazy var headerList : NSArray = {
        var arr = ["资产id","宇宙地址"]
        
        return arr as NSArray
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerList.count+1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 90*SCALE
        }else if indexPath.section == 1{
            return 50*SCALE
        }
        return 255*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : BLImportAssetsIDCell = tableView.dequeueReusableCell(withIdentifier: BLImportAssetsIDCellId)! as! BLImportAssetsIDCell
            cell.delegate = self
            assetsIDCell = cell
            
            return cell
        }else if indexPath.section == 1{
            let cell : BLImportUniverseAddressCell = tableView.dequeueReusableCell(withIdentifier: BLImportUniverseAddressCellId)! as! BLImportUniverseAddressCell
            universeAddressCell = cell
            
            return cell
        }
        
        let cell : BLImportAssetsDetailCell = tableView.dequeueReusableCell(withIdentifier: BLImportAssetsDetailCellId)! as! BLImportAssetsDetailCell
        assetsDetailCell = cell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < headerList.count{
            return 60*SCALE
        }else{
            return 30*SCALE
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == headerList.count{
            return 60*SCALE
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < headerList.count{
            let view : UIView = UIView.init()
            let titleLbl : UILabel = UILabel.init()
            titleLbl.text = (headerList[section] as! String)
            titleLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
            titleLbl.font = FONT_BOLD(s: 18*Float(SCALE))
            titleLbl.textAlignment = .left
            view.addSubview(titleLbl)
            titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.left.mas_equalTo()(20*SCALE)
                make?.bottom.mas_equalTo()(-10*SCALE)
                make?.height.mas_equalTo()(20*SCALE)
                make?.right.mas_equalTo()(-20*SCALE)
            }
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == headerList.count{
            let view : UIView = UIView.init()
            let bt = UIButton.init()
            bt.setTitle("确认", for: .normal)
            bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_NORMAL(s: 18*Float(SCALE))
            bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
            bt.layer.cornerRadius = 24*SCALE
            bt.clipsToBounds = true
            bt.addTarget(self, action: #selector(confirmAcation), for: .touchUpInside)
            view.addSubview(bt)
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(10*SCALE)
                make?.bottom.mas_equalTo()(0)
                make?.left.mas_equalTo()(20*SCALE)
                make?.right.mas_equalTo()(-20*SCALE)
            }
            
            return view
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //ImportAssetsDelegate
    func scanAcation(){
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        let vc : BLQRScanVC = BLQRScanVC.init()
        vc.callBack = { [weak self] codeStr in
            if self?.assetsIDCell != nil{
                self?.assetsIDCell?.assignAddr(addr: codeStr)
            }
            
            if self?.universeAddressCell != nil{
                let universeAddr : String = (self?.universeAddressCell?.addrLbl.text)!
                let jsonStr : String = ApiSyncUniverse(universeAddr, codeStr)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    let jsonStr : String = ApiGetAssetInfo(codeStr)
                    let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                    if status == APISECCUSS{
                        self?.coinDetailModel = BLWalletViewModel.getCoinDetailModel(jsonStr: jsonStr)
                        if self?.assetsDetailCell != nil{
                            self?.assetsDetailCell?.assignCoinDetailModel(model: (self?.coinDetailModel)!)
                        }
                    }else{
                        BLTools.showTost(tip: status, superView: (self?.view)!)
                    }
                }else{
                    BLTools.showTost(tip: status, superView: (self?.view)!)
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func confirmAcation(){
        if coinDetailModel != nil{
            let assetsList : NSMutableArray?
            let obj = BLTools.nSKeyedUnarchiverPath(path: KNSDocumentPath(name: Key_Assets))
            if obj is NSArray{
                assetsList = NSMutableArray.init(array: obj as! NSArray)
                for i in 0..<assetsList!.count{
                    let obj = assetsList![i]
                    if obj is BLAssetsItem{
                        let item : BLAssetsItem = obj as! BLAssetsItem
                        if item.asset_id == coinDetailModel?.assetId{
                            BLTools.showTost(tip: "数据已导入", superView: self.view)
                            return
                        }
                    }
                }
            }else{
                assetsList = NSMutableArray.init()
            }
            
            let item : BLAssetsItem = BLAssetsItem.init()
            item.genesis_point = coinDetailModel?.point
            item.name = coinDetailModel?.name
            item.asset_id = coinDetailModel?.assetId
            item.asset_type = coinDetailModel?.assetType
            item.balance = "0"
            assetsList!.add(item)
            let flg : Bool = BLTools.nSKeyedArchiver(archData: assetsList as Any, secureCoding: true, path: KNSDocumentPath(name: Key_Assets))
            if flg{
                BLTools.showTost(tip: "数据已导入", superView: self.view)
            }else{
                BLTools.showTost(tip: "数据导入失败", superView: self.view)
            }
        }else{
            BLTools.showTost(tip: "未查询到信息", superView: self.view)
        }
    }
}
