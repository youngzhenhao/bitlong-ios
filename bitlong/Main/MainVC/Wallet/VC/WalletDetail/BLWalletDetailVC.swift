//
//  BLWalletDetailVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/11.
//

import UIKit

class BLWalletDetailVC: BLBaseVC,WalletDetailCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "钱包详情"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }
    
    func initUI(){
        self.view.backgroundColor = UIColorHex(hex: 0xF8F8F8, a: 1.0)
        self.tableView.backgroundColor = self.view.backgroundColor
        self.tableView.isScrollEnabled = false
        self.view.addSubview(self.tableView)
        self.view.addSubview(deleteWalletBt)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(456*SCALE)
        }
        
        deleteWalletBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-50*SCALE)
            make?.left.mas_equalTo()(24*SCALE)
            make?.right.mas_equalTo()(-24*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        self.tableView.register(BLWalletDetailCell.self, forCellReuseIdentifier: BLWalletDetailCellId)
    }
    
    lazy var deleteWalletBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("删除钱包", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s:18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 0.1)
        bt.addTarget(self, action: #selector(deleteWalletAcation), for: .touchUpInside)
        bt.layer.cornerRadius = 24*SCALE
        bt.clipsToBounds = true
        
        
        return bt
    }()
    
    lazy var walletItemList : NSArray = {
        var list = ["导出助记词",["修改密码","重置密码"],"Nostr地址"]
        
        return list as NSArray
    }()
    
    lazy var invoiceQRView : BLCollectionInvoiceQRView = {
        var view = BLCollectionInvoiceQRView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.callBack = {
            view.removeFromSuperview()
        }
        
        return view
    }()
    
    lazy var walletNameView : BLChangeWalletNameView = {
        var view = BLChangeWalletNameView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.callBack = { [weak self] name in
            let obj = userDefaults.object(forKey: WalletInfo)
            if obj != nil && obj is NSDictionary{
                let walletDic : NSMutableDictionary = NSMutableDictionary.init(dictionary: (obj as! NSDictionary))
                walletDic[WalletName] = name
                userDefaults.setValue(walletDic, forKey: WalletInfo)
                
                self?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
            }
        }
        
        return view
    }()
    
    lazy var tipView : BLChangePasswordTipView = {
        var view = BLChangePasswordTipView.init()
        view.isNeedToChange = false
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.updateView(isChange: false)
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1+walletItemList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 90*SCALE
        }
        
        return 70*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLWalletDetailCell = tableView.dequeueReusableCell(withIdentifier: BLWalletDetailCellId)! as! BLWalletDetailCell
        cell.delegate = self
        if indexPath.section == 0{
            cell.initWalletInfo(isFromHome: false)
            cell.assignWalletInfo()
        }else{
            cell.initNormal()
            
            if indexPath.section-1 < walletItemList.count{
                let obj = walletItemList[indexPath.section-1]
                if obj is String{
                    cell.assignNormalInfo(title: obj as! String, path: indexPath)
                }else if obj is NSArray{
                    let list : NSArray = obj as! NSArray
                    if indexPath.row < list.count{
                        let obj = list[indexPath.row]
                        cell.assignNormalInfo(title: obj as! String, path: indexPath)
                    }else{
                        cell.assignNormalInfo(title: "--", path: indexPath)
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3{
            return 54*SCALE
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3{
            let footerView : UIView = UIView.init()
            let versionLbl : UILabel = UILabel.init()
            versionLbl.text = String.init(format: "当前版本:%@", BLTools.getAppVersion())
            versionLbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
            versionLbl.font = FONT_NORMAL(s: 13*Float(SCALE))
            versionLbl.textAlignment = .center
            footerView.addSubview(versionLbl)
            versionLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.height.mas_equalTo()(16*SCALE)
                make?.left.mas_equalTo()(16*SCALE)
                make?.right.mas_equalTo()(-16*SCALE)
                make?.centerY.mas_equalTo()(0)
            }
            
            return footerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{//导出助记词
            let genSeedVC : BLGetGenSeedVC = BLGetGenSeedVC.init()
            genSeedVC.pageType = .exportGenSeed
            self.pushBaseVC(vc: genSeedVC, animated: true)
        }else if indexPath.section == 2{
            if indexPath.row == 0{//修改密码
                if tipView.superview == nil{
                    appDelegate.window.addSubview(tipView)
                    tipView.mas_makeConstraints { (make : MASConstraintMaker?) in
                        make?.top.left().right().bottom().mas_equalTo()(0)
                    }
                }
            }else if indexPath.row == 1{//重置密码
                
            }
        }else if indexPath.section == 3{//Nostr地址
            
        }
    }

    @objc func deleteWalletAcation(){
    }
    
    //WalletDetailCellDelegate
    func walletDetailAcation(sender: UIButton, text: String) {
        if sender.tag == 100{
            BLTools.pasteGeneral(string: text)
        }else if sender.tag == 101{//编辑钱包信息
            if walletNameView.superview == nil{
                self.view.addSubview(walletNameView)
                walletNameView.mas_makeConstraints { (make : MASConstraintMaker?) in
                    make?.top.left().right().bottom().mas_equalTo()(0)
                }
            }
        }
    }
    
    func creatQRAcation(addr: String) {
        self.view.addSubview(invoiceQRView)
        invoiceQRView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
        let hisItem : BLCollectionHisItem = BLCollectionHisItem.init()
        hisItem.encoded = addr
        invoiceQRView.assignHisItem(obj: hisItem, title: "比特币地址")
    }
}
