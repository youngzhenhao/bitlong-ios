//
//  BLToolVC.swift
//  bitlong
//
//  Created by slc on 2024/5/6.
//

import UIKit

class BLToolVC: BLBaseVC,ToolItemClickDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initUI(){
        self.view.addSubview(itemsView)
        itemsView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(itemsView.frame.height)
        }
    }
    
    lazy var itemsView : BLToolItemsView = {
        var view = BLToolItemsView.init()
        view.delegate = self
        
        return view
    }()
    
    //ToolItemClickDelegate
    func itemsClicked(sender: UIButton) {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        switch sender.tag {
        case 100://浏览器
            break
        case 101://锁仓
            self.pushBaseVCStr(vcStr: "BLLockPositionVC", animated: true)
            break
        case 102://多签
            break
        case 103://批量转账
            self.pushBaseVCStr(vcStr: "BLBatchTransferVC", animated: true)
            break
        case 104://多条件支出
            break
        case 105://销毁
            self.pushBaseVCStr(vcStr: "BLDestructionVC", animated: true)
            break
        case 106://IDO
            self.pushBaseVCStr(vcStr: "BLIDOVC", animated: true)
            break
        default:
            break
        }
    }
}
