//
//  BLNoticeListVC.swift
//  bitlong
//
//  Created by slc on 2024/6/28.
//

import UIKit

class BLNoticeListVC: BLBaseVC {
    
    var list: [BLNoticeListItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "公告"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBar(isHidden: false)
    }
    
    func initUI(){
        self.view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.tableView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
        
        self.tableView.register(BLNoticeListCell.self, forCellReuseIdentifier: BLNoticeListCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if list != nil{
            return list!.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLNoticeListCell = tableView.dequeueReusableCell(withIdentifier: BLNoticeListCellId)! as! BLNoticeListCell
        if list != nil && indexPath.section < list!.count{
            let item : BLNoticeListItem = list![indexPath.section]
            cell.assign(item: item, index: indexPath.section+1)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10*SCALE
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
        if list != nil && indexPath.section < list!.count{
            let item : BLNoticeListItem = list![indexPath.section]
            BLRout.setValue(obj: item, key: "listItem")
            self.pushBaseVCStr(vcStr: "BLNoticeContentVC", animated: true)
        }
    }
}
