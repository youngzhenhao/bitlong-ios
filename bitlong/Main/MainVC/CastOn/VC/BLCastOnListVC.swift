//
//  BLCastOnListVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/15.
//

import UIKit

class BLCastOnListVC: BLBaseVC {
    var queryIssuedModel : BLLaunchQueryIssuedModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        self.loadData()
    }

    func initUI(){
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.tableView.mj_header = self.gifHeader
        headerView.layoutIfNeeded()
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)
            make?.left.right().bottom().mas_equalTo()(0)
        }
        
        tableView.register(BLCastOnListCell.self, forCellReuseIdentifier: BLCastOnListCellID)
    }
    
    override func loadData() {
        BLCastOnViewModel.getFairFaunchQueryIssued { [weak self] model in
            self?.queryIssuedModel =  model
            self?.gifHeader.endRefreshing()
            self?.tableView.reloadData()
            
            if model.datas == nil || model.datas!.count <= 0{
                self?.addNoDataView(superView: (self?.view)!, isBig: true)
            }else{
                self?.removeNoDataView()
            }
        } failed: { [weak self] error in
            if self?.queryIssuedModel == nil || self?.queryIssuedModel!.datas == nil || (self?.queryIssuedModel!.datas!.count)! <= 0{
                self?.addNoDataView(superView: (self?.view)!, isBig: true)
            }else{
                self?.removeNoDataView()
            }
            
            BLTools.showTost(tip: error.msg, superView: (self?.view)!)
            self?.gifHeader.endRefreshing()
        }
    }
    
    lazy var headerView : BLCastOnListHeaderView = {
        var view = BLCastOnListHeaderView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if queryIssuedModel != nil && queryIssuedModel?.datas != nil{
            return (queryIssuedModel?.datas!.count)!
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCastOnListCell = tableView.dequeueReusableCell(withIdentifier: BLCastOnListCellID)! as! BLCastOnListCell
        if queryIssuedModel != nil && queryIssuedModel?.datas != nil{
            if indexPath.row < (queryIssuedModel?.datas!.count)!{
                cell.assignLaunchQuery(item: (queryIssuedModel?.datas![indexPath.row])!)
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
        if queryIssuedModel != nil && queryIssuedModel?.datas != nil{
            if indexPath.row < (queryIssuedModel?.datas!.count)!{
                let item : BLLaunchQueryIssuedItem = (queryIssuedModel?.datas![indexPath.row])!
                let vc : BLCreatCastOnVC = BLCreatCastOnVC.init()
                vc.queryIssuedItem = item
                self.pushBaseVC(vc: vc, animated: true)
            }
        }
    }
}
