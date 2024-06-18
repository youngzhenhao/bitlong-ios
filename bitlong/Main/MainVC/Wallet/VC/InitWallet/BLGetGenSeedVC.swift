//
//  BLGetGenSeedVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/30.
//

import UIKit

typealias CreatWalletBlock = () ->(Void)

class BLGetGenSeedVC: BLBaseVC {
    
    var genSeed : String?
    var creatWalletBlock : CreatWalletBlock?
    var walletInfo : NSDictionary?
    var pageType : GenSeedPageType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pageType == .exportGenSeed{
            self.title = "助记词"
        }
        
        self.initUI()
        self.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        if pageType == .backupsGenSeed{
            self.view.addSubview(backBt)
            
            backBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(6*SCALE)
                make?.left.mas_equalTo()(16*SCALE)
                make?.width.height().mas_equalTo()(32*SCALE)
            }
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            if pageType == .backupsGenSeed{
                make?.top.mas_equalTo()(backBt.mas_bottom)?.offset()(14*SCALE)
            }else{
                make?.top.mas_equalTo()(TopHeight)
            }
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
        }
        
        self.tableView.register(BLGenSeedNoticeCell.self, forCellReuseIdentifier: GenSeedNoticeCellId)
        self.tableView.register(BLGenSeedListCell.self, forCellReuseIdentifier: GenSeedListCellId)
    }
    
    override func loadData() {
        if genSeed == nil || genSeed!.count <= 0{
            if pageType == .backupsGenSeed{
                self.getGenSeed()
            }else{
                let obj = userDefaults.object(forKey: GenSeed)
                if obj != nil && obj is String{
                    genSeed = obj as? String
                    self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
                }
            }
        }
    }
    
    func getGenSeed(){
        DispatchQueue.global().async { [weak self] in
            self?.genSeed = ApiGenSeed()
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 2, section: 0)
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    lazy var backBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_back_black"), for: .normal)
        bt.addTarget(self, action: #selector(backAcation), for: .touchUpInside)
        
        return bt
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return BLTools.textHeight(text: pageType == .backupsGenSeed ? genSeedTitle : "导出助记词", font: UIFont.boldSystemFont(ofSize: 14*SCALE), width: SCREEN_WIDTH - 48*SCALE)+9*SCALE
        }else if indexPath.row == 1{
            if pageType == .backupsGenSeed{
                return BLTools.textHeight(text: genSeedSubTitle, font: UIFont.systemFont(ofSize: 13*SCALE), width: SCREEN_WIDTH - 48*SCALE)+9*SCALE
            }else{
                return 0.0
            }
        }else if indexPath.row == 2{
            if genSeed != nil && 0 < genSeed!.count{
                return (SCREEN_WIDTH-32*SCALE)/1.02+9*SCALE
            }
            
            return 0.01
        }else if indexPath.row == 3{
            return BLTools.textHeight(text: genSeedWarnTitle, font: UIFont.systemFont(ofSize: 13*SCALE), width: SCREEN_WIDTH - 48*SCALE)+9*SCALE
        }else if indexPath.row == 4{
            return BLTools.textHeight(text: genSeedWarnSubTitle, font: UIFont.systemFont(ofSize: 13*SCALE), width: SCREEN_WIDTH - 48*SCALE)+9*SCALE
        }
        
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4{
            let cell : BLGenSeedNoticeCell = tableView.dequeueReusableCell(withIdentifier: GenSeedNoticeCellId, for: indexPath) as! BLGenSeedNoticeCell
            if indexPath.row == 0{
                cell.titleLbl.text = genSeedTitle
                cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 14*SCALE)
            }else if indexPath.row == 1{
                cell.titleLbl.text = genSeedSubTitle
                cell.titleLbl.font = UIFont.systemFont(ofSize: 13*SCALE)
            }else if indexPath.row == 3{
                cell.titleLbl.text = genSeedWarnTitle
                cell.titleLbl.font = UIFont.systemFont(ofSize: 13*SCALE)
            }else if indexPath.row == 4{
                cell.titleLbl.text = genSeedWarnSubTitle
                cell.titleLbl.font = UIFont.systemFont(ofSize: 13*SCALE)
            }
            
            return cell
        }
        
        let cell : BLGenSeedListCell = tableView.dequeueReusableCell(withIdentifier: GenSeedListCellId)! as! BLGenSeedListCell
        if genSeed != nil{
            cell.assign(genSeed: genSeed!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if pageType == .backupsGenSeed{
            return 225*SCALE
        }
        
        return 90*SCALE
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView.init()
        if pageType == .backupsGenSeed{
            let manualBackupBt : UIButton = self.getButton(title: manualBackupTitle, titleColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 14*SCALE), backColor: .brown, radius: 22*SCALE)
            manualBackupBt.tag = 100
            let cloudBackupBt : UIButton = self.getButton(title: cloudBackupTitle, titleColor: .white, titleFont: UIFont.systemFont(ofSize: 13*SCALE), backColor: .blue, radius: 22*SCALE)
            cloudBackupBt.tag = 101
            let laterBackupBt : UIButton = self.getButton(title: laterBackupTitle, titleColor: .white, titleFont: UIFont.systemFont(ofSize: 13*SCALE), backColor: .purple, radius: 22*SCALE)
            laterBackupBt.tag = 102
            
            view.addSubview(manualBackupBt)
            view.addSubview(cloudBackupBt)
            view.addSubview(laterBackupBt)
            manualBackupBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(24*SCALE)
                make?.left.mas_equalTo()(24*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
                make?.height.mas_equalTo()(50*SCALE)
            }
            cloudBackupBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(manualBackupBt.mas_bottom)?.offset()(17*SCALE)
                make?.left.mas_equalTo()(24*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
                make?.height.mas_equalTo()(50*SCALE)
            }
            laterBackupBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(cloudBackupBt.mas_bottom)?.offset()(17*SCALE)
                make?.left.mas_equalTo()(24*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
                make?.height.mas_equalTo()(50*SCALE)
            }
        }else{
            let exportBt : UIButton = self.getButton(title: "导出助记词", titleColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 14*SCALE), backColor: UIColorHex(hex: 0x665AF0, a: 1.0), radius: 22*SCALE)
            exportBt.tag = 103
            view.addSubview(exportBt)
            exportBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(24*SCALE)
                make?.left.mas_equalTo()(24*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
                make?.height.mas_equalTo()(50*SCALE)
            }
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func backAcation(){
        self.dismiss(animated: true)
    }

    override func buttonAcation(sender: UIButton) {
        switch sender.tag {
        case 100://手动备份
            if genSeed != nil && 0 < genSeed!.count{
                userDefaults.setValue(genSeed, forKey: GenSeed)
                userDefaults.synchronize()
                
                if walletInfo != nil{
                    BLTools.showTost(tip: "钱包正在创建中，请稍作等待~", superView: self.view)
                    DispatchQueue.global().async { [weak self] in
                        let passWorld : String = self?.walletInfo!.object(forKey: PalletPassWorld) as! String
                        let isCreatSuccess : Bool = ApiInitWallet(self?.genSeed, passWorld)
                        if isCreatSuccess{
                            userDefaults.set(self?.walletInfo, forKey: WalletInfo)
                            userDefaults.synchronize()
                            
                            DispatchQueue.main.async { [weak self] in
                                self?.dismiss(animated: false)
                                if self?.creatWalletBlock != nil {
                                    self?.creatWalletBlock!()
                                }
                            }
                            print("钱包创建成功!")
                        }else{
                            print("钱包创建失败!")
                        }
                    }
                }else{
                    BLTools.showTost(tip: "钱包输入信息非法！无法创建！", superView: self.view)
                }
            }
           
            break
        case 101://云备份
            break
        case 102://稍后备份
            break
        case 103://导出助记词
            BLTools.pasteGeneral(string: genSeed as Any)
            break
        default:
            break
        }
    }
    
    override func `deinit`() {
        super.`deinit`()
    }
}
