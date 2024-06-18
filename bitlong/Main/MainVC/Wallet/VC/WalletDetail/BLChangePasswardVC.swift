//
//  BLChangePasswardVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/17.
//

import UIKit

class BLChangePasswardVC: BLBaseVC {
    
    var oldPasswardCell : BLChangePasswardCell?
    var newPasswardCell : BLChangePasswardCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        
        self.initUI()
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
        
        self.tableView.register(BLChangePasswardCell.self, forCellReuseIdentifier: BLChangePasswardCellId)
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
        let cell : BLChangePasswardCell = tableView.dequeueReusableCell(withIdentifier: BLChangePasswardCellId)! as! BLChangePasswardCell
        cell.assignIndexPath(path: indexPath)
        if indexPath.section == 0{
            oldPasswardCell = cell
        }else{
            newPasswardCell = cell
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
        if oldPasswardCell == nil || oldPasswardCell?.textField.text == nil {
            BLTools.showTost(tip: "请输入原密码", superView: self.view)
            return
        }
        
        if newPasswardCell == nil || newPasswardCell?.textField.text == nil {
            BLTools.showTost(tip: "请输入新密码", superView: self.view)
            return
        }
        
        if (newPasswardCell?.textField.text!.count)! < 8 || 12 < (newPasswardCell?.textField.text!.count)!{
            BLTools.showTost(tip: "请输入8到12位数字与字母组合的密码", superView: self.view)
            return
        }
        
        //校验旧密码
        let obj = userDefaults.object(forKey: WalletInfo)
        if obj != nil && obj is NSDictionary{
            let dic : NSDictionary = obj as! NSDictionary
            if let passward = dic[PalletPassWorld]{
                if (newPasswardCell?.textField.text)! != passward as! String{
                    BLTools.showTost(tip: "原密码错误", superView: self.view)
                    return
                }
            }
        }
        
        if !BLTools.checkRegular(regex: PasswardRegex, value: (newPasswardCell?.textField.text)!){
            BLTools.showTost(tip: "密码不合法，请输入8到12位数字与字母组合的密码", superView: self.view)
            return
        }
        
        if ApiChangePassword(oldPasswardCell?.textField.text, newPasswardCell?.textField.text){
            BLTools.showTost(tip: "密码修改成功", superView: self.view)
            self.back()
        }else{
            BLTools.showTost(tip: "密码修改失败", superView: self.view)
        }
    }
}
