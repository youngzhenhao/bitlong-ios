//
//  BLCastOnHisVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/12.
//

import UIKit

class BLCastOnHisVC: BLBaseVC {
    
    var ownMintModel : BLLaunchQueryOwnMintModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "历史记录"
        
        self.initUI()
        self.loadData()
    }
    
    func initUI(){
        self.view.addSubview(hisHeaderView)
        self.view.addSubview(self.tableView)
        
        hisHeaderView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(35*SCALE)
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(hisHeaderView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
        }
        
        self.tableView.mj_header = self.gifHeader
        self.tableView.register(BLCastOnHisCell.self, forCellReuseIdentifier: BLCastOnHisCellId)
    }
    
    override func loadData() {
        BLCastOnViewModel.fairFaunchMintQueryOwnMint { [weak self] resObj in
            let success : Int = resObj["success"] as! Int
            if success == 1{
                self?.ownMintModel = BLLaunchQueryOwnMintModel.mj_object(withKeyValues: resObj)
                self?.tableView.reloadData()
                self?.mintReserved()
                
                if self?.ownMintModel!.datas == nil || (self?.ownMintModel!.datas!.count)! <= 0{
                    self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                }else{
                    self?.removeNoDataView()
                }
            }else{
                self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                
                let error = resObj["error"]
                BLTools.showTost(tip: (error ?? "查询是否可以进行铸造失败") as! String, superView: (self?.view)!)
            }
            
            self?.gifHeader.endRefreshing()
        } failed: { [weak self] error in
            if self?.ownMintModel == nil || self?.ownMintModel!.datas == nil || (self?.ownMintModel!.datas!.count)! <= 0{
                self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
            }else{
                self?.removeNoDataView()
            }
            
            BLTools.showTost(tip: error.msg, superView: (self?.view)!)
            self?.gifHeader.endRefreshing()
        }
    }
    
    func mintReserved(){
        if ownMintModel != nil && ownMintModel?.datas != nil && 0 < (ownMintModel?.datas!.count)!{
            for i in 0..<(ownMintModel?.datas?.count)!{
                let item : BLLaunchQueryOwnMintItem = (ownMintModel?.datas![i])!
                if item.state == "4"{//已发行  进行公平发射资产的发行保留部分取回
                    let param : NSDictionary = ["asset_id" : item.asset_id as Any,"encoded_addr" : item.encoded_addr as Any]
                    BLCastOnViewModel.fairFaunchMintReserved(param: param) { resObj in
                        let success : Int = resObj["success"] as! Int
                        if success == 1{
                            if resObj["data"] is NSDictionary{
                                let data : NSDictionary = resObj["data"] as! NSDictionary
                                let anchor_outpoint_txid : String = data["anchor_outpoint_txid"] as! String
                                print("anchor_outpoint_txid:%@",anchor_outpoint_txid)
                            }
                        }
                    } failed: { error in
                        print("error:%@",error.msg as Any)
                    }
                }
            }
        }
    }
    
    lazy var hisHeaderView : BLCastOnHisHeaderView = {
        var view = BLCastOnHisHeaderView.init()
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ownMintModel != nil && ownMintModel?.datas != nil{
            return (ownMintModel?.datas!.count)!
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCastOnHisCell = tableView.dequeueReusableCell(withIdentifier: BLCastOnHisCellId)! as! BLCastOnHisCell
        if ownMintModel != nil && ownMintModel?.datas != nil{
            if indexPath.row < (ownMintModel?.datas!.count)!{
                let item : BLLaunchQueryOwnMintItem = (ownMintModel?.datas![indexPath.row])!
                cell.assignQueryOwnMintItem(item: item)
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
}
