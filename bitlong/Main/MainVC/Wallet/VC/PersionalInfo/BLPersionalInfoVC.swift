//
//  BLPersionalInfoVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

class BLPersionalInfoVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人资料"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    func initUI(){
        self.view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.tableView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().bottom().mas_equalTo()(0)
        }
        
        self.tableView.register(BLPersionalInfoCell.self, forCellReuseIdentifier: BLPersionalInfoCellId)
    }
    
    lazy var list : NSArray = {
        var arr = ["中继",["头像","名称","介绍"],"兴趣标签"]
        
        return arr as NSArray
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < list.count{
            let obj = list[section]
            if obj is NSArray{
                return (obj as! NSArray).count
            }
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLPersionalInfoCell = tableView.dequeueReusableCell(withIdentifier: BLPersionalInfoCellId)! as! BLPersionalInfoCell
        if indexPath.section < list.count{
            let obj = list[indexPath.section]
            if obj is String{
                cell.assignText(title: obj as! String, indexPath: indexPath)
            }else if obj is NSArray{
                let arr : NSArray = obj as! NSArray
                if indexPath.row < arr.count{
                    cell.assignText(title: arr[indexPath.row] as! String, indexPath: indexPath)
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 12*SCALE : 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12*SCALE
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
