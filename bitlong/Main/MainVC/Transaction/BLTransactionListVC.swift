//
//  BLTransactionListVC.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

class BLTransactionListVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    func initUI(){
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        
        tableView.register(BLTransactionListCell.self, forCellReuseIdentifier: BLTransactionListCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLTransactionListCell = tableView.dequeueReusableCell(withIdentifier: BLTransactionListCellId)! as! BLTransactionListCell
        
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
        self.pushBaseVCStr(vcStr: "BLTransactionDetailVC", animated: true)
    }
}
