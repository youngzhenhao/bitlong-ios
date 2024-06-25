//
//  BLTranscationDetailMarketVC.swift
//  bitlong
//
//  Created by slc on 2024/5/21.
//

import UIKit

class BLTranscationDetailMarketVC: BLBaseVC,DetailMarketDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initUI(){
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        
        tableView.register(BLTranscationDetailMarketCell.self, forCellReuseIdentifier: BLTranscationDetailMarketCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLTranscationDetailMarketCell = tableView.dequeueReusableCell(withIdentifier: BLTranscationDetailMarketCellId)! as! BLTranscationDetailMarketCell
        cell.delegate = self
        cell.lineViewHidden(isHidden: indexPath.row == 0)
        
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
    
    //DetailMarketDelegate
    func buyAcation() {
        
    }
}
