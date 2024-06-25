//
//  BLDestructionVC.swift
//  bitlong
//
//  Created by slc on 2024/6/14.
//

import UIKit

class BLDestructionVC: BLBaseVC,SelectDelegate,BatchTransferDelegate {
    var destructionNum : Int64 = 0
    var currentSellectIndex : NSInteger = -1
    var assetsModel: BLAssetsModel?
    var selectedItem : BLAssetsItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "销毁"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.view.addSubview(destructBt)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(destructBt.mas_top)?.offset()(-20*SCALE)
        }
        
        destructBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight-70*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(40*SCALE)
        }
        
        self.tableView.isScrollEnabled = false
        self.tableView.register(BLBatchTransferTypeCell.self, forCellReuseIdentifier: BLBatchTransferTypeCellId)
        self.tableView.register(BLBatchTransferIDCell.self, forCellReuseIdentifier: BLBatchTransferIDCellId)
        self.tableView.register(BLDestructionNumCell.self, forCellReuseIdentifier: BLDestructionNumCellId)
    }
    
    override func loadData() {
        assetsModel = BLWalletViewModel.getAssetsModel()
        if assetsModel?.datas != nil && 0 < (assetsModel?.datas!.count)!{
            let item : BLAssetsItem = (assetsModel?.datas![0])!
            self.selectItem(obj: item)
        }
    }
    
    lazy var destructBt : UIButton = {
        var bt : UIButton = UIButton.init()
        bt.setTitle("确认", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 22*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(destructAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var selectView : BLBatchTransferSelectView = {
        var view = BLBatchTransferSelectView.init()
        view.delegate = self
        view.layer.cornerRadius = 2*SCALE
        //设置阴影颜色
        view.layer.shadowColor = UIColor.lightGray.cgColor
        //设置透明度
        view.layer.shadowOpacity = 0.7
        //设置阴影半径
        view.layer.shadowRadius = 3*SCALE
        //设置阴影偏移量
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)
         
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*SCALE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : BLBatchTransferTypeCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferTypeCellId)! as! BLBatchTransferTypeCell
            cell.titleLbl.text = "资产"
            cell.subTitleLbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
            cell.setCellType(isDestruction: true)
            if selectedItem != nil{
                cell.subTitleLbl.text = selectedItem?.name
            }
            
            return cell
        }else if indexPath.section == 1 || indexPath.section == 2{
            let cell : BLBatchTransferIDCell = tableView.dequeueReusableCell(withIdentifier: BLBatchTransferIDCellId)! as! BLBatchTransferIDCell
            cell.titleLbl.text = indexPath.section == 1 ? "ID" : "余额"
            if selectedItem != nil{
                if indexPath.section == 1{
                    cell.subTitleLbl.text = selectedItem!.asset_id
                }else{
                    cell.subTitleLbl.text = selectedItem!.balance as? String
                }
            }
            cell.setCellType(isDestruction: true)
            
            return cell
        }else{
            let cell : BLDestructionNumCell = tableView.dequeueReusableCell(withIdentifier: BLDestructionNumCellId)! as! BLDestructionNumCell
            cell.titleLbl.text = "销毁数量"
            cell.setCellType(isDestruction: true)
            cell.delegate = self
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSellectIndex == indexPath.section{
            self.hideSelectList()
            return
        }
        currentSellectIndex = indexPath.section
        
        if indexPath.section == 0{
            let cell : BLBatchTransferTypeCell = tableView.cellForRow(at: indexPath) as! BLBatchTransferTypeCell
            cell.layoutIfNeeded()
            self.showSelectList(frame: CGRect.init(x: CGRectGetMinX(cell.subTitleLbl.frame), y: TopHeight+CGRectGetMaxY(cell.frame), width: 200*SCALE, height: 0),section: indexPath.section)
        }else{
            self.hideSelectList()
        }
    }
    
    func showSelectList(frame : CGRect,section : NSInteger){
        if assetsModel != nil && assetsModel?.datas != nil{
            let assets : NSArray = assetsModel!.datas! as NSArray
            selectView.assignData(list: assets)
        }
        
        if selectView.superview == nil{
            self.view.addSubview(selectView)
        }
        selectView.frame = frame
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            var height : CGFloat = 0.0
            if self?.assetsModel != nil && self?.assetsModel!.datas != nil && 0 < (self?.assetsModel!.datas!.count)!{
                if (self?.assetsModel!.datas!.count)! <= 5{
                    height = CGFloat((self?.assetsModel!.datas!.count)!)*(40*SCALE)
                }else{
                    height = 5*(40*SCALE)
                }
            }
            self?.selectView.frame = CGRect.init(x: frame.origin.x, y: frame.maxY, width: frame.width, height: height)
        }
    }
    
    func hideSelectList(){
        if selectView.superview != nil{
            selectView.removeFromSuperview()
        }
        currentSellectIndex = -1
    }
    
    //BatchTransferDelegate
    func tocuhAcation() {
        self.hideSelectList()
    }
    
    func didEndEditing(obj: String, cell: Any) {
        destructionNum = Int64(obj)!
    }
    
    //SelectDelegate
    func selectItem(obj: Any) {
        selectedItem = (obj as! BLAssetsItem)
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0),
                                       IndexPath.init(row: 0, section: 1),
                                       IndexPath.init(row: 0, section: 2)], with: .fade)
        
        self.hideSelectList()
    }
    
    @objc func destructAcation(){
        self.hideSelectList()
        
        if selectedItem == nil || selectedItem?.asset_id == nil{
            BLTools.showTost(tip: "请选择资产", superView: self.view)
            return
        }
        
        if destructionNum <= 0{
            BLTools.showTost(tip: "请输入数量", superView: self.view)
            return
        }
        
        let jsonStr : String = ApiBurnAsset(selectedItem?.asset_id, destructionNum)
        let status : String = BLTools.getResaultStatus(jsonStr: jsonStr)
        //"{\"success\":true,\"error\":\"\",\"code\":200,\"data\":\"3d77d3cd75bed414d777c90e05af34488a905ee1977c3308aeb8988027d18ffb\"}"
        if status == APISECCUSS{
            BLTools.showTost(tip: "销毁成功", superView: self.view)
        }else{
            BLTools.showTost(tip: status, superView: self.view)
        }
    }
}
