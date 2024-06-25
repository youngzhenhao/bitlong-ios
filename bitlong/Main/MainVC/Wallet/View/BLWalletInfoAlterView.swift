//
//  BLWalletInfoAlterView.swift
//  bitlong
//
//  Created by slc on 2024/6/17.
//

import UIKit

class BLWalletInfoAlterView: BLBaseView,UITableViewDelegate,UITableViewDataSource {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(closeBt)
        containerView.addSubview(lineView)
        containerView.addSubview(tableView)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(SCREEN_HEIGHT/2.0+SafeAreaBottomHeight)
            make?.bottom.mas_equalTo()(0)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(15*SCALE)
            make?.left.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(-40*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
        }
        
        closeBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(50*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(1*SCALE)
        }
        
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
        
        tableView.register(BLWalletDetailCell.self, forCellReuseIdentifier: BLWalletDetailCellId)
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "钱包列表"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 18*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x383838, a: 0.8)
        
        return view
    }()
    
    lazy var closeBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_close"), for: .normal)
        bt.addTarget(self, action: #selector(closeAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var tableView : UITableView = {
        var table = self.getTableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        
        return table
    }()
    
    lazy var headerList : NSArray = {
        return ["比特币"]
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90*SCALE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLWalletDetailCell = tableView.dequeueReusableCell(withIdentifier: BLWalletDetailCellId)! as! BLWalletDetailCell
        cell.initWalletInfo(isFromHome: true)
        cell.assignWalletInfo()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView : UIView = UIView.init()
        let versionLbl : UILabel = UILabel.init()
        versionLbl.text = (headerList[section] as! String)
        versionLbl.textColor = UIColorHex(hex: 0x383838, a: 1)
        versionLbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        versionLbl.textAlignment = .left
        footerView.addSubview(versionLbl)
        versionLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.height.mas_equalTo()(16*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = touches.first?.view
        if view != containerView{
            self.closeAcation()
        }
    }
    
    @objc func closeAcation(){
        self.removeFromSuperview()
    }
}
