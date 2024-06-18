//
//  BLCollectionBTCAddresVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/15.
//

import UIKit

typealias addressBlock = (_ address : String) ->()

class BLCollectionBTCAddresVC: BLBaseVC {
    
    var btcDetailModel : BLBTCDetailModel?
    var callBack : addressBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BTC地址选择"
        
        self.initUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData()
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.view.addSubview(addAddressBt)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight+5*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-140*SCALE)
        }
        
        addAddressBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(24*SCALE)
            make?.right.mas_equalTo()(-24*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
            make?.bottom.mas_equalTo()(-45*SCALE)
        }
        
        self.tableView.mj_header = self.gifHeader
        self.tableView.register(BLCollectionBTCAddresCell.self, forCellReuseIdentifier: BLCollectionBTCAddresCellId)
    }
    
    override func loadData() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            ApiUpdateAllAddressesByGNZBA()
            //获取地址列表
            let jsonStr : String = ApiQueryAllAddr()
            let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
            self?.btcDetailModel = BLBTCDetailModel.mj_object(withKeyValues: jsobObj)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.gifHeader.endRefreshing()
                
                if self?.btcDetailModel!.datas == nil || (self?.btcDetailModel!.datas!.count)! <= 0{
                    self?.addNoDataView(superView: (self?.view)!, isBig: true)
                }else{
                    self?.removeNoDataView()
                }
            }
        }
    }
    
    lazy var addAddressBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("添加地址", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 24*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(addAddressAcation), for: .touchUpInside)
        
        return bt
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btcDetailModel != nil && btcDetailModel?.datas != nil{
            return (btcDetailModel?.datas!.count)!
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCollectionBTCAddresCell = tableView.dequeueReusableCell(withIdentifier: BLCollectionBTCAddresCellId)! as! BLCollectionBTCAddresCell
        if btcDetailModel != nil && btcDetailModel?.datas != nil{
            if indexPath.row < (btcDetailModel?.datas!.count)!{
                let item : BLBTCDetailItem = (btcDetailModel?.datas![indexPath.row])!
                cell.assignAssets(item: item,index: indexPath.row)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10*SCALE
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : BLCollectionBTCAddresCell = tableView.cellForRow(at: indexPath) as! BLCollectionBTCAddresCell
        if cell.addressLbl.text != nil && 0 < cell.addressLbl.text!.count{
            if callBack != nil{
                callBack!(cell.addressLbl.text!)
            }
            
            self.back()
        }
    }
    
    @objc func addAddressAcation(){
        self.pushBaseVCStr(vcStr: "BLCollectionAddAddressVC", animated: true)
    }
    
    override func `deinit`() {
        super.`deinit`()
    }
}
