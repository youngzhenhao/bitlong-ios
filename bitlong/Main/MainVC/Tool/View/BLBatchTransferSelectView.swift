//
//  BLBatchTransferSelectView.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/3.
//

import UIKit

@objc protocol SelectDelegate : NSObjectProtocol {
    func selectItem(obj : Any)
}

class BLBatchTransferSelectView: BLBaseView,UITableViewDelegate,UITableViewDataSource {
    
    var datas : NSArray = NSArray.init()
    weak var delegate : SelectDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(tableView)
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().bottom().mas_equalTo()(0)
        }
    }
    
    lazy var tableView : UITableView = {
        var table = self.getTableView()
        table.delegate = self
        table.dataSource = self
        table.register(BLBatchTransferSelectCell.self, forCellReuseIdentifier: BLBatchTransferSelectCellId)
        
        return table
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*SCALE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLBatchTransferSelectCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferSelectCellId)! as! BLBatchTransferSelectCell
        cell.assignData(obj: datas[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.selectItem(obj:)))) != nil{
            delegate?.selectItem(obj: datas[indexPath.row])
        }
    }
    
    func assignData(list : NSArray){
        datas = list
        self.tableView.reloadData()
    }
}
