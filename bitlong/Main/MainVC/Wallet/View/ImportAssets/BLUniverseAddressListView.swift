//
//  BLUniverseAddressListView.swift
//  bitlong
//
//  Created by slc on 2024/6/25.
//

import UIKit

@objc protocol AddressSelectDelegate : NSObjectProtocol{
    func addressSelect(addr : String)
}

class BLUniverseAddressListView: BLBaseView,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate : AddressSelectDelegate?

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
        table.isScrollEnabled = false
        table.register(BLUniverseAddressListCell.self, forCellReuseIdentifier: BLUniverseAddressListCellId)
        
        return table
    }()
    
    lazy var hostList : NSArray = {
        var arr = [["hostname" : "202.79.173.41:8443"],   //香港服务器（主网）
                   ["hostname" : "44.230.212.183:10029"], //公共宇宙（主网）
                   ["hostname" : "52.88.202.111:10029"],  //公共宇宙（测试链）
                   ["hostname" : "132.232.109.84:8443"],  //成都宇宙（私链）
                   ["hostname" : "132.232.109.84:8444"]   //成都宇宙（主网）
        ]
        
        return arr as NSArray
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*SCALE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLUniverseAddressListCell = tableView.dequeueReusableCell(withIdentifier: BLUniverseAddressListCellId)! as! BLUniverseAddressListCell
        if indexPath.row < hostList.count{
            let dic : NSDictionary = hostList[indexPath.row] as! NSDictionary
            cell.assignAddress(addr: (dic["hostname"] as! String))
        }
        
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
        if indexPath.row < hostList.count{
            let dic : NSDictionary = hostList[indexPath.row] as! NSDictionary
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.addressSelect(addr:)))) != nil{
                delegate?.addressSelect(addr: dic["hostname"] as! String)
            }
        }
    }
}
