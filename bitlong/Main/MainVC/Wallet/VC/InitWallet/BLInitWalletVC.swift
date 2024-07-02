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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBar(isHidden: true)
    }

    func initUI(){
        self.view.backgroundColor = .white
        self.tableView.isScrollEnabled = false
        self.view.addSubview(headerView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(bottomView)
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(headerView.frame.height)
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)?.offset()(24*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-58*SCALE)
        }
        
        bottomView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.right().bottom().mas_equalTo()(0)
            make?.height.mas_equalTo()(58*SCALE)
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
        return 68*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 0.01
        }
        
        return 10*SCALE
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
            self.pushBaseVCStr(vcStr: "BLCreatWalletVC", animated: true)
        }else if indexPath.section == 1{//导入钱包
        }else if indexPath.section == 2{//硬件钱包
        }else if indexPath.section == 3{//观察钱包
        }
    }
    
    lazy var headerView : BLHeaderView = {
        var view = BLHeaderView.init()

        return view
    }()
    
    lazy var bottomView : BLBottomView = {
        var view = BLBottomView.init()

        return view
    }()

    
    lazy var list : NSArray = {
        var arr = NSArray.init(objects: 
                                [NSLocalized(key: "creatWalletTitle") : NSLocalized(key: "creatWalletSubTitle")],
                                [NSLocalized(key: "ImportWalletTitle") : NSLocalized(key: "ImportWalletSubTitle")],
                                [NSLocalized(key: "HardwareWalletTitle") : NSLocalized(key: "HardwareWalletSubTitle")],
                                [NSLocalized(key: "ObservingWalletTitle") : NSLocalized(key: "ObservingWalletSubTitle")])
        
        return arr
    }()
}
