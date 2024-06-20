//
//  BLChangePasswordVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/17.
//

import UIKit

class BLChangePasswordVC: BLBaseVC {
    
    var oldPasswordCell : BLChangePasswordCell?
    var newPasswordCell : BLChangePasswordCell?
    var callBack : ChangePasswordBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        
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
        self.view.addSubview(confirmBt)
        self.tableView.isScrollEnabled = false
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-200*SCALE)
        }
        
        confirmBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-100*SCALE)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        self.tableView.register(BLChangePasswordCell.self, forCellReuseIdentifier: BLChangePasswordCellId)
    }
    
    lazy var headerList : NSArray = {
        return ["原密码", "新密码"]
    }()
    
    lazy var confirmBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("确认修改", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 22*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(changePassWord), for: .touchUpInside)
        
        return bt
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLChangePasswordCell = tableView.dequeueReusableCell(withIdentifier: BLChangePasswordCellId)! as! BLChangePasswordCell
        cell.assignIndexPath(path: indexPath)
        if indexPath.section == 0{
            oldPasswordCell = cell
        }else{
            newPasswordCell = cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        let titleLbl : UILabel = UILabel.init()
        if section < headerList.count{
            titleLbl.text = (headerList[section] as! String)
        }
        titleLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        titleLbl.font = FONT_NORMAL(s: 16*Float(SCALE))
        titleLbl.textAlignment = .left
        view.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(16*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func changePassWord(){
        if oldPasswordCell == nil || oldPasswordCell?.textField.text == nil {
            BLTools.showTost(tip: "请输入原密码", superView: self.view)
            return
        }
        
        if newPasswordCell == nil || newPasswordCell?.textField.text == nil {
            BLTools.showTost(tip: "请输入新密码", superView: self.view)
            return
        }
        
        if (newPasswordCell?.textField.text!.count)! < 8 || 12 < (newPasswordCell?.textField.text!.count)!{
            BLTools.showTost(tip: "请输入8到12位数字与字母组合的密码", superView: self.view)
            return
        }
        
        let oldPassword : String = (oldPasswordCell?.textField.text)!
        let newPassword : String = (newPasswordCell?.textField.text)!
        
        //校验旧密码
        let obj = userDefaults.object(forKey: WalletInfo)
        if obj != nil && obj is NSDictionary{
            let dic : NSDictionary = obj as! NSDictionary
            if let password = dic[WalletPassWorld]{
                if oldPassword != password as! String{
                    BLTools.showTost(tip: "原密码错误", superView: self.view)
                    return
                }
            }
        }
        
        if !BLTools.checkRegular(regex: PasswordRegex, value: newPassword){
            BLTools.showTost(tip: "密码不合法，请输入8到12位数字与字母组合的密码", superView: self.view)
            return
        }
        
        BLTools.showTost(tip: "密码修改中，请勿重复操作！", superView: self.view)
        let flg : Bool = ApiChangePassword(oldPassword, newPassword)
        if flg{
            let obj = userDefaults.object(forKey: WalletInfo)
            if obj != nil && obj is NSDictionary{
                let dic : NSMutableDictionary = NSMutableDictionary.init(dictionary: obj as! NSDictionary)
                dic.setObject(newPassword, forKey: WalletPassWorld as NSCopying)
                userDefaults.synchronize()
                
                self.back()
            }
        }else{
            BLTools.showTost(tip: "密码修改失败", superView: self.view)
        }
    }
    
    override func back() {
        if callBack != nil{
            callBack!()
        }
        
        super.back()
    }
}
