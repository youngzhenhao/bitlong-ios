//
//  BLCollectionAddAddressVC.swift
//  bitlong
//
//  Created by slc on 2024/5/28.
//

import UIKit

class BLCollectionAddAddressVC: BLBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalized(key: "addressMangerNavTitle")
        self.navgationRightBtn(picStr:"", title: NSLocalized(key: "addressMangerNavRightTitle"), titleColor: nil)
   
        self.initUI()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initUI(){
        self.view.addSubview(headerView)
        self.view.addSubview(self.tableView)
        
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(headerView.frame.height)
        }
        
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
        }
        self.tableView.register(BLAddAddressCell.self, forCellReuseIdentifier: BLAddAddressCellId)
    }
    
    override func loadData() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        viewModel.getAddress()
        self.tableView.reloadData()
    }
    
    lazy var headerView : BLAddAddressHeaderView = {
        var view = BLAddAddressHeaderView.init()
        
        return view
    }()
    
    lazy var viewModel : BLWalletViewModel = {
        var model = BLWalletViewModel.init()
        
        return model
    }()
    
    lazy var headerList : NSArray = {
        var arr = [NSLocalized(key: "addressMangerRootAddress"),
                   NSLocalized(key: "addressMangerIsolationAddress"),
                   NSLocalized(key: "addressMangerNestingAddress")]
        
        return arr as NSArray
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 56*SCALE + (viewModel.P2TRModel?.height())!
        }else if indexPath.section == 1{
            return 56*SCALE + (viewModel.P2WKHModel?.height())!
        }else if indexPath.section == 2{
            return 56*SCALE + (viewModel.NP2WKHModel?.height())!
        }
        
        return 70*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLAddAddressCell = tableView.dequeueReusableCell(withIdentifier: BLAddAddressCellId)! as! BLAddAddressCell
        if indexPath.section == 0{
            cell.assignAddressModel(model: viewModel.P2TRModel)
        }else if indexPath.section == 1{
            cell.assignAddressModel(model: viewModel.P2WKHModel)
        }else if indexPath.section == 2{
            cell.assignAddressModel(model: viewModel.NP2WKHModel)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView.init()
        let titleLbl : UILabel = UILabel.init()
        if section < headerList.count{
            titleLbl.text = (headerList[section] as! String)
        }
        titleLbl.textColor = UIColorHex(hex: 0x000000, a: 1.0)
        titleLbl.font = FONT_BOLD(s: 14*Float(SCALE))
        titleLbl.textAlignment = .left
        view.addSubview(titleLbl)
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(16*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.bottom.mas_equalTo()(-12*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : BLAddAddressCell = tableView.cellForRow(at: indexPath)! as! BLAddAddressCell
        if cell.addressaModel != nil{
            let balance : Int32 = (cell.addressaModel?.balance!.intValue)!
            let jsonStr : String = ((ApiStoreAddr(cell.addressaModel?.name, cell.addressaModel?.address, Int(balance), cell.addressaModel?.address_type, cell.addressaModel?.derivation_path, cell.addressaModel?.is_internal == "0" ? false : true) as NSString) as String)
            let status : String = BLTools.getResaultStatus(jsonStr: jsonStr as String)
            if status == APISECCUSS{
                self.back()
                BLTools.showTost(tip: NSLocalized(key: "collectionAddressAddSeccuse"), superView: appDelegate.window)
            }else{
                BLTools.showTost(tip: status, superView: appDelegate.window)
            }
        }
    }
    
    override func rightItemAcation() {
        self.loadData()
    }
}
