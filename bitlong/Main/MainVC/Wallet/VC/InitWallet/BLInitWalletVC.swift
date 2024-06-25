//
//  BLInitWalletVC.swift
//  bitlong
//
//  Created by slc on 2024/4/28.
//

import UIKit

class BLInitWalletVC: BLBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func initUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(titleLbl)
        self.view.addSubview(self.tableView)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(60)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(27)
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(24)
            make?.left.mas_equalTo()(24)
            make?.right.mas_equalTo()(-24)
            make?.bottom.mas_equalTo()(-96)
        }
        
        self.tableView.register(BLWalletCell.self, forCellReuseIdentifier: WalletCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 0.01
        }
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLWalletCell = tableView.dequeueReusableCell(withIdentifier: WalletCellId)! as! BLWalletCell
        if indexPath.section < list.count{
            let dic : NSDictionary = list[indexPath.section] as! NSDictionary
            cell.titleLbl.text = dic.allKeys.first as? String
            cell.subTitleLbl.text = dic[cell.titleLbl.text as Any] as? String
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{//创建钱包
            self.navigationController?.pushViewController(BLCreatWalletVC.init(), animated: true)
        }else if indexPath.section == 1{//导入钱包
        }else if indexPath.section == 2{//硬件钱包
        }else if indexPath.section == 3{//观察钱包
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "比特币生态钱包"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var list : NSArray = {
        var arr = NSArray.init(objects: ["创建钱包" : "使用新的钱包"],["导入钱包" : "使用我已有的钱包"],["硬件钱包" : "使用我的硬件钱包"],["观察钱包" : "观察钱包"])
        
        return arr
    }()
}
