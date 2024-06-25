//
//  BLCreatCastOnVC.swift
//  bitlong
//
//  Created by slc on 2024/5/17.
//

import UIKit

class BLCreatCastOnVC: BLBaseVC,CreatCastOnDelegate,ConfirmDelegate {
    
    var queryIssuedItem : BLLaunchQueryIssuedItem?//公平发射发行信息
    var minitNum : Int64 = 1
    var mintModel : BLCastOnQueryMintModel?//查询是否可以进行铸造
    var mintNumberModel : BLCastOnQueryInventoryMintNumberModel?//可铸造分数

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "铸造"
        self.navgationRightBtn(picStr: "", title: "历史记录", titleColor: nil)
        
        self.initUI()
        self.loadData()
    }
    
    override func rightItemAcation() {
        self.pushBaseVCStr(vcStr: "BLCastOnHisVC", animated: true)
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight+15*SCALE)
            make?.left.right().bottom().mas_equalTo()(0)
        }
        
        self.tableView.register(BLCreatCastOnCell.self, forCellReuseIdentifier: BLCreatCastOnCellId)
    }
    
    override func loadData() {
        //获取公平发射发行信息
        if queryIssuedItem != nil && queryIssuedItem?.asset_id != nil{
            self.queryAsset(assetId: (queryIssuedItem?.asset_id)!)
        }
    }
    
    func queryAsset(assetId : String) {
        BLCastOnViewModel.getQueryAsset(assetId: assetId) { [weak self] item in
            //公平发射发行信息
            self?.queryIssuedItem = item
            //宇宙同步资产
            if self?.queryIssuedItem != nil && self?.queryIssuedItem?.asset_id != nil{
                let jsonStr : String = ApiSyncUniverse("132.232.109.84:8443", self?.queryIssuedItem?.asset_id)
                NSSLog(msg: String.init(format: "宇宙同步资产:%@",jsonStr))
            }
            //查询费率
            self?.getFairFaunchQueryMint()
            self?.tableView.reloadData()
        } failed: { [weak self] errorRespModel in
            BLTools.showTost(tip: errorRespModel.msg, superView: (self?.view)!)
        }
        
        //份数查询
        BLCastOnViewModel.getQueryInventoryMintNumber(assetId: assetId) { [weak self] model in
            self?.mintNumberModel = model
            if model.number != nil{
                self?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 9)], with: .fade)
            }
        } failed: { error in
        }
    }
    
    lazy var tipLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "注:*手续费从闪电网络钱包扣除"
        lbl.textColor = UIColorHex(hex: 0xEC3468, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var confirmView : BLCreatAssetsConfirmView = {
        var view = BLCreatAssetsConfirmView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.delegate = self
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 70*SCALE
        }
        return 35*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCreatCastOnCell = tableView.dequeueReusableCell(withIdentifier: BLCreatCastOnCellId)! as! BLCreatCastOnCell
        cell.delegate = self
        if indexPath.section == 0{
            cell.setCellType(type: .assetsID)
        }else if indexPath.section == 1{
            cell.setCellType(type: .assetsName)
        }else if indexPath.section == 2{
            cell.setCellType(type: .assetsNum)
        }else if indexPath.section == 3{
            cell.setCellType(type: .assetsReserve)
        }else if indexPath.section == 4{
            cell.setCellType(type: .assetsMintNum)
        }else if indexPath.section == 5{
            cell.setCellType(type: .assetsBegainDate)
        }else if indexPath.section == 6{
            cell.setCellType(type: .assetsEndDate)
        }else if indexPath.section == 7{
            cell.setCellType(type: .assetsHadCastOn)
        }else if indexPath.section == 8{
            cell.setCellType(type: .assetsHolder)
        }else if indexPath.section == 9{
            cell.setCellType(type: .assetsCopies)
        }
        
        if queryIssuedItem != nil{
            cell.assignQueryIssuedItem(item: queryIssuedItem!)
        }
        
        if indexPath.section == 9{
            if mintNumberModel != nil{
                cell.assignMintNumberModel(model: mintNumberModel!)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }
        
        return 10*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 9{
            return 78*SCALE + SafeAreaBottomHeight + 50*SCALE
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 9{
            let footerView : UIView = UIView.init()
            let bt : UIButton = UIButton.init()
            bt.setTitle("铸造", for: .normal)
            bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
            bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
            bt.layer.cornerRadius = 24*SCALE
            bt.clipsToBounds = true
            bt.addTarget(self, action: #selector(creatCastOn), for: .touchUpInside)
            footerView.addSubview(tipLbl)
            footerView.addSubview(bt)
            tipLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(15*SCALE)
                make?.left.mas_equalTo()(30*SCALE)
                make?.right.mas_equalTo()(-30*SCALE)
                make?.height.mas_equalTo()(13*SCALE)
            }
            
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.left.mas_equalTo()(24*SCALE)
                make?.top.mas_equalTo()(tipLbl.mas_bottom)?.offset()(30*SCALE)
                make?.bottom.mas_equalTo()(-SafeAreaBottomHeight - 20*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
            }
            
            return footerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //铸造
    @objc func creatCastOn(){
        //查询资产铸造费用
        let token = userDefaults.object(forKey: Token)
        if token is String{
            let jsonStr : String = ApiGetMintTransactionFee((token as! String), Int((queryIssuedItem?.ID)!)!, Int(minitNum))
            let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
            if status == APISECCUSS{
                let dic : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
                let data : NSNumber = dic["data"] as! NSNumber
                confirmView.assignTransactionFee(title: "资产铸造费用:", fee: data.stringValue)
                
                if confirmView.superview == nil{
                    self.view.addSubview(confirmView)
                    confirmView.mas_makeConstraints { (make : MASConstraintMaker?) in
                        make?.edges.equalTo()(self.view)
                    }
                    UIView.animate(withDuration: 0.3) { [weak self] in
                        self?.confirmView.alpha = 1.0
                    }
                }
            }else{
                BLTools.showTost(tip: status, superView: self.view)
            }
        }else{
            BLTools.showTost(tip: "token非法!", superView: self.view)
        }
    }
    
    //CreatCastOnDelegate
    func getQueryInfo(assetsId: String) {
        if queryIssuedItem != nil && queryIssuedItem?.asset_id != nil{
            if assetsId != queryIssuedItem?.asset_id{
                self.queryAsset(assetId: assetsId)
            }
        }else{
            queryIssuedItem = BLLaunchQueryIssuedItem.init()
            queryIssuedItem?.asset_id = assetsId
            self.queryAsset(assetId: assetsId)
        }
    }
    
    func minitNumSelected(num: Int64) {
        minitNum = num
        self.getFairFaunchQueryMint()
    }
    
    //ConfirmDelegate
    func confirmAcation() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        //开始铸造
        if queryIssuedItem == nil || queryIssuedItem?.ID == nil || queryIssuedItem?.asset_id == nil{
            BLTools.showTost(tip: "公平发射资产发行信息不存在", superView: self.view)
            return
        }
        if mintModel == nil || mintModel?.calculated_fee_rate_sat_per_kw == nil || mintModel?.inventory_amount == nil{
            BLTools.showTost(tip: "铸造费率信息不存在", superView: self.view)
            return
        }
        
        let jsonStr : NSString = ApiNewAddr(queryIssuedItem?.asset_id, Int(mintModel!.inventory_amount!)!) as NSString
        let status = BLTools.getResaultStatus(jsonStr: jsonStr as String)
        if status == APISECCUSS{
            let jsonObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
            var addressDecodeModel : BLAssetAddressDecodeModel?
            if let data = jsonObj["data"]{
                addressDecodeModel = BLAssetAddressDecodeModel.mj_object(withKeyValues: data)
            }
            if addressDecodeModel == nil || addressDecodeModel?.encoded == nil{
                BLTools.showTost(tip: "生成资产地址失败", superView: self.view)
                return
            }
            let param : NSDictionary = ["fair_launch_info_id": Int((queryIssuedItem?.ID)!) as Any,
                                        "minted_number": minitNum,
                                        "encoded_addr":addressDecodeModel?.encoded as Any,
                                        "minted_fee_rate_sat_per_kw":Int((mintModel?.calculated_fee_rate_sat_per_kw!)!)!]
            BLCastOnViewModel.fairFaunchMint(param: param) { [weak self] resObj in
                let success : Int = resObj["success"] as! Int
                if success == 1{
                    BLTools.showTost(tip: "铸造成功", superView: (self?.view)!)
                }else{
                    let error = resObj["error"]
                    BLTools.showTost(tip: (error ?? "铸造失败") as! String, superView: (self?.view)!)
                }
            } failed: { [weak self] error in
                BLTools.showTost(tip: error.msg, superView: (self?.view)!)
            }
        }else{
            BLTools.showTost(tip: status, superView: self.view)
        }
    }
    
    
    func getFairFaunchQueryMint(){
        if queryIssuedItem != nil && queryIssuedItem?.ID != nil{
            let param : NSDictionary = ["fair_launch_info_id" : Int64((queryIssuedItem?.ID)!) as Any, "minted_number" : minitNum]
            BLCastOnViewModel.fairFaunchQueryMint(param: param) { [weak self] resObj in
                let success : Int = resObj["success"] as! Int
                if success == 1{
                    if let data = resObj["data"]{
                        self?.mintModel = BLCastOnQueryMintModel.mj_object(withKeyValues: data)
                        if self?.mintModel!.calculated_fee_rate_sat_per_kw != nil{
                            self?.tipLbl.text = "注:*手续费从闪电网络钱包扣除" + " 费率:" + (self?.mintModel?.calculated_fee_rate_sat_per_kw!)!
                        }
                    }
                }else{
                    let error = resObj["error"]
                    BLTools.showTost(tip: (error ?? "查询是否可以进行铸造失败") as! String, superView: (self?.view)!)
                }
            } failed: { [weak self] error in
                BLTools.showTost(tip:error.msg, superView: (self?.view)!)
            }
        }
    }
}
