//
//  BLAssetsSendHisVC.swift
//  bitlong
//
//  Created by slc on 2024/6/5.
//

import UIKit

class BLAssetsSendHisVC: BLBaseVC {
    
    let hisModel : BLAssetsSendHisModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发布历史记录"
        
        self.initUI()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
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
        self.tableView.register(BLAssetsSendHisCell.self, forCellReuseIdentifier: BLAssetsSendHisCellId)
    }
    
    override func loadData() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            let token = userDefaults.object(forKey: Token)
            if token is String{
                let jsonStr : String = ApiGetUserOwnIssuanceHistoryInfos((token as! String))
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
                if status == APISECCUSS{
                    self?.viewModel.getSendHisModel(jsonStr: jsonStr)
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async { [weak self] in
                        BLTools.showTost(tip: status, superView: (self?.view)!)
                    }
                }
            }else{
                DispatchQueue.main.async { [weak self] in
                    BLTools.showTost(tip: "token不存在", superView: (self?.view)!)
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                if self?.viewModel.sendHisModel == nil || self?.viewModel.sendHisModel?.datas == nil || (self?.viewModel.sendHisModel?.datas!.count)! <= 0{
                    self?.addNoDataView(superView: (self?.tableView)!, isBig: true)
                }else{
                    self?.removeNoDataView()
                }
            }
        }
    }
    
    lazy var hisHeaderView : BLAssetsSendHisHeaderView = {
        var view = BLAssetsSendHisHeaderView.init()
        
        return view
    }()
    
    lazy var viewModel : BLCastOnViewModel = {
        var model = BLCastOnViewModel.init()
        
        return model
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.sendHisModel != nil && viewModel.sendHisModel?.datas != nil{
            return (viewModel.sendHisModel?.datas!.count)!
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLAssetsSendHisCell = tableView.dequeueReusableCell(withIdentifier: BLAssetsSendHisCellId)! as! BLAssetsSendHisCell
        if viewModel.sendHisModel != nil && viewModel.sendHisModel?.datas != nil{
            if indexPath.row < (viewModel.sendHisModel?.datas!.count)!{
                let item : BLAssetsSendHisItem = (viewModel.sendHisModel?.datas![indexPath.row])!
                cell.assignHisItem(item: item)
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
