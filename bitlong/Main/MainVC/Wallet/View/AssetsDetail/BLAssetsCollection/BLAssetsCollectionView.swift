//
//  BLAssetsCollectionView.swift
//  bitlong
//
//  Created by slc on 2024/5/31.
//

import UIKit

class BLAssetsCollectionView: BLBaseView,UITableViewDelegate,UITableViewDataSource {
    
    var coinName : String?
    var invoiceCoinTypeCell : BLCollectionInvoiceCell?
    var invoiceAmountCell : BLCollectionInvoiceCell?
    var invoiceDescriptCell : BLCollectionInvoiceCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initInvoiceUI(){
        self.addSubview(tableView)
        tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(28*SCALE)
            make?.left.right().bottom().mas_equalTo()(0)
        }
    }
    
    lazy var tableView : UITableView = {
        var table = self.getTableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.register(BLCollectionInvoiceCell.self, forCellReuseIdentifier: BLCollectionInvoiceCellId)
        
        return table
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 90*SCALE
        }
        return 40*SCALE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BLCollectionInvoiceCell = tableView.dequeueReusableCell(withIdentifier: BLCollectionInvoiceCellId)! as! BLCollectionInvoiceCell
        if indexPath.section == 0{
            cell.assignCoinTypeView()
            if coinName != nil{
                cell.assignAssetsItem(obj: coinName)
            }
            
            invoiceCoinTypeCell = cell
        }else if indexPath.section == 1{
            cell.assignAmountView()
            if coinName != nil{
                cell.satsLbl.text = coinName
            }
            
            invoiceAmountCell = cell
        }else{
            cell.assignPostscriptView()
            
            invoiceDescriptCell = cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }
        
        return 16*SCALE
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func assignAssetsItem(obj : Any){
        if obj is BLAssetsItem{
            let item = (obj as! BLAssetsItem)
            coinName = item.name
        }else if obj is String{
            coinName = (obj as! String)
        }
        
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
    }
    
    func amount() -> NSInteger{
        if invoiceAmountCell != nil{
            let amout = invoiceAmountCell?.textField.text
            if amout != nil && 0 < amout!.count{
                let amoutStr : NSString = amout! as NSString
                return amoutStr.integerValue
            }
        }
        
        return 0
    }
    
    func postscript() -> String{
        if invoiceDescriptCell != nil{
            let postscript = invoiceDescriptCell?.textView.text
            if postscript != nil{
                return postscript!
            }
        }
        
        return ""
    }
}


@objc protocol ItemClickAcationDelegate : NSObjectProtocol {
    func itemClickAcation(sender : UIButton)
}

class BLAssetsCollectionItemView: BLBaseView {
    
    @objc weak var delegate : ItemClickAcationDelegate?
    let width : CGFloat = (SCREEN_WIDTH - 32*SCALE)/3.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(backView)
        self.addSubview(invoiceBt)
        self.addSubview(LNRULBt)
        self.addSubview(lightingAddrBt)
        
        backView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
            make?.height.mas_equalTo()(58*SCALE)
        }
        
        invoiceBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.left.mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        LNRULBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.centerX.mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        lightingAddrBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(0)
            make?.width.mas_equalTo()(width)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        backView.layoutIfNeeded()
        invoiceBt.layoutIfNeeded()
        lightingAddrBt.layoutIfNeeded()
        let leftRightPath : UIBezierPath = UIBezierPath.init(roundedRect: backView.bounds, byRoundingCorners:[.topLeft,.topRight], cornerRadii:CGSize.init(width: 12 * SCALE, height: 12 * SCALE))
        self.setCornerRadius(view: backView, path: leftRightPath)
        let leftPath : UIBezierPath = UIBezierPath.init(roundedRect: invoiceBt.bounds, byRoundingCorners:[.topLeft], cornerRadii:CGSize.init(width: 12 * SCALE, height: 12 * SCALE))
        self.setCornerRadius(view: invoiceBt, path: leftPath)
        let rightPath : UIBezierPath = UIBezierPath.init(roundedRect: lightingAddrBt.bounds, byRoundingCorners:[.topRight], cornerRadii:CGSize.init(width: 12 * SCALE, height: 12 * SCALE))
        self.setCornerRadius(view: lightingAddrBt, path: rightPath)
    }
    
    func setCornerRadius(view : UIView,path : UIBezierPath){
        let cornerRadiusLayer : CAShapeLayer = CAShapeLayer.init()
        cornerRadiusLayer.frame = view.bounds
        cornerRadiusLayer.path = path.cgPath
        view.layer.mask = cornerRadiusLayer
    }
    
    lazy var backView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var invoiceBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "collectionInvoice"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        bt.tag = 100
        bt.isSelected = true
        bt.titleLabel?.numberOfLines = 0
        bt.addTarget(self, action: #selector(itemClickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var LNRULBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "collectionLNRUL"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        bt.tag = 101
        bt.titleLabel?.numberOfLines = 0
        bt.addTarget(self, action: #selector(itemClickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var lightingAddrBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle(NSLocalized(key: "collectionLightingAddress"), for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
        bt.tag = 102
        bt.titleLabel?.numberOfLines = 0
        bt.addTarget(self, action: #selector(itemClickAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func itemClickAcation(sender : UIButton){
        if sender.isSelected{
            return
        }
        sender.isSelected = !sender.isSelected
        sender.titleLabel?.font = FONT_BOLD(s: 16*Float(SCALE))
        sender.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        
        if sender == invoiceBt{
            LNRULBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            LNRULBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            LNRULBt.isSelected = false
            lightingAddrBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            lightingAddrBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            lightingAddrBt.isSelected = false
        }else if sender == LNRULBt{
            invoiceBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            invoiceBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            invoiceBt.isSelected = false
            lightingAddrBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            lightingAddrBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            lightingAddrBt.isSelected = false
        }else if sender == lightingAddrBt{
            invoiceBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            invoiceBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            invoiceBt.isSelected = false
            LNRULBt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
            LNRULBt.backgroundColor = UIColorHex(hex: 0xF2F2F2, a: 1.0)
            LNRULBt.isSelected = false
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backView.mas_remakeConstraints { (make : MASConstraintMaker?) in
                make?.top.bottom().mas_equalTo()(0)
                make?.width.mas_equalTo()(self?.width)
                make?.centerX.mas_equalTo()(sender.mas_centerX)
            }
            
            self?.backView.layoutIfNeeded()
        }
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.itemClickAcation(sender:)))) != nil{
            delegate?.itemClickAcation(sender: sender)
        }
    }
}
