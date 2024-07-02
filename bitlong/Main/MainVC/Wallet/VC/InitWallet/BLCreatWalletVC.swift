//
//  BLCreatWalletVC.swift
//  bitlong
//
//  Created by slc on 2024/4/29.
//

import UIKit

class BLCreatWalletVC: BLBaseVC {
    
    var nameField : UITextField?,passWorldField : UITextField?,passWorldAgainField : UITextField?,passWorldNotiField : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalized(key: "creatWalletNavTitle")
        self.setNavTitleColor(titleColor: UIColorHex(hex: 0x383838, a: 1.0), bgColor: UIColorHex(hex: 0xFAFAFA, a: 1.0), bgImage: nil)
        
        self.initUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setNavigationBar(isHidden: false)
    }
    
    func initUI(){
        self.view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        self.tableView.backgroundColor = self.view.backgroundColor
        self.tableView.isScrollEnabled = false
        self.view.addSubview(self.tableView)
        self.view.addSubview(creatBt)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.mas_equalTo()(24)
            make?.right.mas_equalTo()(-24)
            make?.bottom.mas_equalTo()(-160)
        }
        
        creatBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(24)
            make?.right.mas_equalTo()(-24)
            make?.height.mas_equalTo()(50)
            make?.bottom.mas_equalTo()(-90)
        }
        
        self.tableView.register(BLCreatWalletCell.self, forCellReuseIdentifier: CreatWalletCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46+12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCreatWalletCell = tableView.dequeueReusableCell(withIdentifier: CreatWalletCellId)! as! BLCreatWalletCell
        cell.contentView.backgroundColor = self.view.backgroundColor
        if indexPath.section == 0{
            cell.walletCellType(type: .walletName)
            nameField = cell.textField
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                cell.walletCellType(type: .walletPassWorld)
                passWorldField = cell.textField
            }else{
                cell.walletCellType(type: .walletPassWorldAgain)
                passWorldAgainField = cell.textField
            }
        }else if indexPath.section == 2{
            cell.walletCellType(type: .walletPassWorldNoti)
            passWorldNotiField = cell.textField
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView.init()
        let titleLbl : UILabel = UILabel.init()
        if(section < headerList.count){
            titleLbl.text = (headerList[section] as! String)
        }
        titleLbl.textColor = .black
        titleLbl.textAlignment = .left
        titleLbl.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
            make?.height.mas_equalTo()(15)
            make?.right.mas_equalTo()(-24)
        }
        
        return view
    }
    
    lazy var creatBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "creatWalletConfirm"), for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = .blue
        bt.layer.cornerRadius = 24*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(creatWalletAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var headerList : NSArray = {
        var array = NSArray.init(objects: NSLocalized(key: "creatWalletName"),
                                 NSLocalized(key: "creatWalletPassword"),
                                 NSLocalized(key: "creatWalletPasswordTips"))
        
        return array
    }()

    @objc func creatWalletAcation(){
        if (nameField?.text?.count)! <= 0{
            BLTools.showTost(tip: NSLocalized(key: "creatWalletNameWarn"), superView: self.view)
            return
        }
        if (passWorldField?.text?.count)! < 8{
            if (passWorldField?.text?.count)! <= 0{
                BLTools.showTost(tip: NSLocalized(key: "creatWalletPasswordWarn"), superView: self.view)
                return
            }
            BLTools.showTost(tip: NSLocalized(key: "creatWalletPasswordLimitWarn"), superView: self.view)
            return
        }
 
        if passWorldField?.text != passWorldAgainField?.text{
            BLTools.showTost(tip: NSLocalized(key: "creatWalletPasswordErrorWarn"), superView: self.view)
            return
        }
        
        let genSeedVC : BLGetGenSeedVC = BLGetGenSeedVC.init()
        let walletInfo : NSMutableDictionary = NSMutableDictionary.init()
        walletInfo.setObject(nameField?.text as Any, forKey: WalletName as NSCopying)
        walletInfo.setObject(passWorldField?.text as Any, forKey: WalletPassWorld as NSCopying)
        walletInfo.setObject(passWorldNotiField?.text as Any, forKey: WalletPassWorldNotice as NSCopying)
        genSeedVC.pageType = .backupsGenSeed
        genSeedVC.walletInfo = walletInfo
        genSeedVC.creatWalletBlock = {
            self.navigationController?.popViewController(animated: false)
            appDelegate.initMainTabBarVC()
        }
        self.present(genSeedVC, animated: true)
    }
}
