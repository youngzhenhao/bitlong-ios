//
//  BLTranscationDetailListVC.swift
//  bitlong
//
//  Created by slc on 2024/5/21.
//

import UIKit

class BLTranscationDetailListVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }

    func initUI(){
        self.view.addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
        
        tableHeaderView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(0)
            make?.width.mas_equalTo()(SCREEN_WIDTH)
            make?.height.mas_equalTo()(52*SCALE)
        }
        
        tableView.register(BLTranscationDetailListCell.self, forCellReuseIdentifier: BLTranscationDetailListCellId)
    }
    
    var tableHeaderView : BLTranscationListHeaderView = {
        var view = BLTranscationListHeaderView.init()
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLTranscationDetailListCell = tableView.dequeueReusableCell(withIdentifier: BLTranscationDetailListCellId)! as! BLTranscationDetailListCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 52*SCALE
        }
        
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
