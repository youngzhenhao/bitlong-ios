//
//  BLChannelListVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/5.
//

import UIKit

class BLChannelListVC: BLBaseVC {
    
    var isFirstLoad : Bool = true
    var balanceModel : BLWalletBalanceModel = BLWalletBalanceModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.tableView.mj_header = self.gifHeader
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        self.tableView.register(BLCoinAssetsCell.self, forCellReuseIdentifier: BLCoinAssetsCellId)
    }
    
    func loadQueryBalance(){
        if isFirstLoad{
            isFirstLoad = false
            self.loadData()
        }
    }
    
    override func loadData() {
        BLWalletViewModel.invoiceQueryBalance { [weak self] resObj in
            let dic : NSDictionary = resObj
            if let balance = dic["balance"]{
                if balance is String{
                    self?.balanceModel.confirmed_balance = (balance as! NSString)
                }else if balance is Int{
                    let ba : Int = balance as! Int
                    self?.balanceModel.confirmed_balance = NSString.init(format: "%d", ba)
                }
            }
            
            self?.tableView.reloadData()
            self?.gifHeader.endRefreshing()
        } failed: { [weak self] respModel in
            self?.tableView.reloadData()
            self?.gifHeader.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCoinAssetsCell = tableView.dequeueReusableCell(withIdentifier: BLCoinAssetsCellId)! as! BLCoinAssetsCell
        cell.assignBtc(model: balanceModel)
        
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
        let assetsDetailVC : BLAssetsDetailVC = BLAssetsDetailVC.init()
        assetsDetailVC.assignAssets(item: "", type: .channelBTCType)
        assetsDetailVC.balanceModel = balanceModel
        assetsDetailVC.hidesBottomBarWhenPushed = true
        self.pushBaseVC(vc: assetsDetailVC, animated: true)
    }
}
