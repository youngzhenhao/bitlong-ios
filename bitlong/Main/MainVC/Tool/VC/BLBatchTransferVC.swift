//
//  BLBatchTransferVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/3.
//

import UIKit

class BLBatchTransferVC: BLBaseVC,SelectDelegate,BatchTransferDelegate {
    
    var typeCell : BLBatchTransferTypeCell?
    var assetCell : BLBatchTransferTypeCell?
    var idCell : BLBatchTransferIDCell?
    var numCell : BLBatchTransferIDCell?
    var addrCell : BLBatchTransferAddrCell?
    var assetsModel: BLAssetsModel?
    var currentSellectIndex : NSInteger = -1
    var addrCount : NSInteger = 1
    var assetsType : AssetsDetailType = .assetsType
    var selectedItem : BLAssetsItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "批量转账"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }

    func initUI(){
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.transBt)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(transBt.mas_top)?.offset()(-20*SCALE)
        }
        
        transBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight-70*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        self.tableView.register(BLBatchTransferTypeCell.self, forCellReuseIdentifier: BLBatchTransferTypeCellId)
        self.tableView.register(BLBatchTransferIDCell.self, forCellReuseIdentifier: BLBatchTransferIDCellId)
        self.tableView.register(BLBatchTransferAddrCell.self, forCellReuseIdentifier: BLBatchTransferAddrCellId)
        self.tableView.register(BLBaseTableViewCell.self, forCellReuseIdentifier: "addCell")
    }
    
    override func loadData() {
        assetsModel = BLWalletViewModel.getAssetsModel()
        if assetsModel?.datas != nil && 0 < (assetsModel?.datas!.count)!{
            let item : BLAssetsItem = (assetsModel?.datas![0])!
            self.selectItem(obj: item)
        }
    }
    
    lazy var selectView : BLBatchTransferSelectView = {
        var view = BLBatchTransferSelectView.init()
        view.delegate = self
        view.layer.cornerRadius = 2*SCALE
        //设置阴影颜色
        view.layer.shadowColor = UIColor.lightGray.cgColor
        //设置透明度
        view.layer.shadowOpacity = 0.7
        //设置阴影半径
        view.layer.shadowRadius = 3*SCALE
        //设置阴影偏移量
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
         
        return view
    }()
    
    lazy var addBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_tool_addrAdd"), for: .normal)
        bt.addTarget(self, action: #selector(addAddrAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var typeList : NSArray = {
        var arr = ["资产转账","BTC转账"]
        
        return arr as NSArray
    }()
    
    lazy var addrDic : NSMutableDictionary = {
        var dic = NSMutableDictionary.init()
        
        return dic
    }()
    
    lazy var transBt : UIButton = {
        var bt : UIButton = UIButton.init()
        bt.setTitle("转账", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 22*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(transAcation), for: .touchUpInside)
        
        return bt
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4{
            return addrCount
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1{
            return 60*SCALE
        }else if indexPath.section == 2 || indexPath.section == 3{
            return 50*SCALE
        }else if indexPath.section == 4{
            return 70*SCALE
        }
        
        return 60*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1{
            let cell : BLBatchTransferTypeCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferTypeCellId)! as! BLBatchTransferTypeCell
            cell.titleLbl.text = indexPath.section == 0 ? "类型" : "资产"
            cell.setCellType(isDestruction: false)
            if indexPath.section == 0{
                cell.subTitleLbl.text = (typeList[0] as! String)
                cell.subTitleLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
                typeCell = cell
            }else{
                cell.subTitleLbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
                assetCell = cell
            }
            
            return cell
        }else if indexPath.section == 2 || indexPath.section == 3{
            let cell : BLBatchTransferIDCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferIDCellId)! as! BLBatchTransferIDCell
            cell.titleLbl.text = indexPath.section == 2 ? "ID" : "数量"
            cell.setCellType(isDestruction: false)
            if indexPath.section == 2{
                idCell = cell
            }else{
                numCell = cell
            }
            
            return cell
        }else if indexPath.section == 4{
            let cell : BLBatchTransferAddrCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferAddrCellId)! as! BLBatchTransferAddrCell
            cell.delegate = self
            cell.titleLbl.text = "地址"
            cell.setCellType(isDestruction: false)
            
            return cell
        }
        
        let cell : BLBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addCell")! as! BLBaseTableViewCell
        cell.contentView.addSubview(addBt)
        addBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-35*SCALE)
            make?.width.height().mas_equalTo()(24*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5{
            return 50*SCALE
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSellectIndex == indexPath.section{
            self.hideSelectList()
            return
        }
        
        currentSellectIndex = indexPath.section
        
        if indexPath.section == 0 || indexPath.section == 1{
            let cell : BLBatchTransferTypeCell = tableView.cellForRow(at: indexPath) as! BLBatchTransferTypeCell
            cell.layoutIfNeeded()
            self.showSelectList(frame: CGRect.init(x: CGRectGetMinX(cell.subTitleLbl.frame), y: TopHeight+CGRectGetMaxY(cell.frame), width: 200*SCALE, height: 0),section: indexPath.section)
        }else{
            self.hideSelectList()
        }
    }
    
    func showSelectList(frame : CGRect,section : NSInteger){
        if section == 0{
            selectView.assignData(list: typeList)
        }else{
            if assetsModel != nil && assetsModel?.datas != nil{
                let assets : NSArray = assetsModel!.datas! as NSArray
                selectView.assignData(list: assets)
            }
        }
        
        if selectView.superview == nil{
            self.view.addSubview(selectView)
        }
        selectView.frame = frame
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            var height : CGFloat = 0.0
            if section == 0{
                height = CGFloat((self?.typeList.count)!)*(40*SCALE)
            }else{
                if self?.assetsModel != nil && self?.assetsModel!.datas != nil && 0 < (self?.assetsModel!.datas!.count)!{
                    if (self?.assetsModel!.datas!.count)! <= 5{
                        height = CGFloat((self?.assetsModel!.datas!.count)!)*(40*SCALE)
                    }else{
                        height = 5*(40*SCALE)
                    }
                }
            }
            self?.selectView.frame = CGRect.init(x: frame.origin.x, y: frame.maxY, width: frame.width, height: height)
        }
    }
    
    func hideSelectList(){
        if selectView.superview != nil{
            selectView.removeFromSuperview()
        }
        
        currentSellectIndex = -1
    }
    
    //SelectDelegate
    func selectItem(obj: Any) {
        if obj is String{
            if typeCell != nil{
                typeCell?.subTitleLbl.text = (obj as! String)
            }
            
            if obj as! String == typeList.firstObject as! String{
                assetsType = .BTCType
            }else{
                assetsType = .assetsType
            }
        }else if obj is BLAssetsItem{
            selectedItem = (obj as! BLAssetsItem)
            if assetCell != nil{
                assetCell?.subTitleLbl.text = selectedItem!.name
            }
            if idCell != nil{
                idCell?.subTitleLbl.text = selectedItem!.asset_id
            }
            if numCell != nil{
                numCell?.subTitleLbl.text = selectedItem!.balance as? String
            }
        }
        
        self.hideSelectList()
    }
    
    //BatchTransferDelegate
    func tocuhAcation() {
        self.hideSelectList()
    }
    
    func didEndEditing(addr: String, amount: String) {
        addrDic.setObject(amount, forKey: addr as NSCopying)
    }

    func scanAcation(cell: Any) {
        addrCell = (cell as! BLBatchTransferAddrCell)
        let vc : BLQRScanVC = BLQRScanVC.init()
        vc.callBack = { [weak self] codeStr in
            self?.addrCell!.addrTextField.text = codeStr
            self?.addrCell!.amountTextField.isUserInteractionEnabled = true
            let addressType : AddressType = BLTools.addressType(address: codeStr)
            if addressType == .addressBTC{//比特币
                self?.addrCell!.amountTextField.text = "0"
                self?.addrDic.setObject("0", forKey: codeStr as NSCopying)
            }else if addressType == .addressAssets{//资产
                let jsonStr : String = ApiDecodeAddr(codeStr)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    let model : BLAssetAddressDecodeModel = BLWalletViewModel.getAssetAddressDecode(jsonStr: jsonStr)
                    if model.amount != nil{
                        if 0 < Int(model.amount!)!{
                            self?.addrCell!.amountTextField.text = model.amount
                            self?.addrCell!.amountTextField.isUserInteractionEnabled = false
                            self?.addrDic.setObject(model.amount as Any, forKey: codeStr as NSCopying)
                        }else{
                            self?.addrCell!.amountTextField.text = "0"
                            self?.addrDic.setObject("0", forKey: codeStr as NSCopying)
                        }
                    }else{
                        self?.addrCell!.amountTextField.text = "0"
                        self?.addrDic.setObject("0", forKey: codeStr as NSCopying)
                    }
                }else{
                    BLTools.showTost(tip: status, superView: (self?.view)!)
                }
            }else if addressType == .addressInvoice{//发票
                let jsonStr : String = ApiDecodePayReq(codeStr)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    let model : BLAssetAddressDecodeModel = BLWalletViewModel.getAssetAddressDecode(jsonStr: jsonStr)
                    if model.amount != nil{
                        
                    }
                }else{
                    BLTools.showTost(tip: "地址解析错误！", superView: (self?.view)!)
                }
            }else{
                BLTools.showTost(tip: "地址不存在！", superView: (self?.view)!)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addAddrAcation(){
        let indexPath : IndexPath = IndexPath.init(row: addrCount, section: 4)
        tableView.beginUpdates()
        addrCount += 1
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    @objc func transAcation(){
        //String returnData = BitlongApi.SendAssets(jsonAddrs, 0);资产
        //String returnData = BitlongApi.SendMany(json, 0);btc
        self.hideSelectList()
        if assetsType == .BTCType{//btc
            if typeCell == nil || typeCell?.subTitleLbl.text == nil{
                BLTools.showTost(tip: "请选择转账类型", superView: self.view)
                return
            }
            if selectedItem == nil{
                BLTools.showTost(tip: "请选择资产", superView: self.view)
                return
            }

            //{"address1":100,"address2":200}
            if 0 < addrDic.allKeys.count{
                let jsonStr = ApiSendMany(addrDic.mj_JSONString(), 0)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                }else{
                    BLTools.showTost(tip: status, superView: self.view)
                }
            }else{
                BLTools.showTost(tip: "请添加地址！", superView: self.view)
            }
        }else if assetsType == .assetsType{//资产
            //["addrs1","addrs2"]
            if 0 < addrDic.allKeys.count{
                let addrs : NSArray = addrDic.allKeys as NSArray
                let jsonStr = ApiSendAssets(addrs.mj_JSONString(), 0)
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                }else{
                    BLTools.showTost(tip: status, superView: self.view)
                }
            }else{
                BLTools.showTost(tip: "请添加地址！", superView: self.view)
            }
        }else{
            
        }
    }
}
