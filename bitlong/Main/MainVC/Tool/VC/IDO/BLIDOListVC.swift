//
//  BLIDOListVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/18.
//

import UIKit

class BLIDOListVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: true)
    }

    func initUI(){
        self.addNoDataView(superView: self.view, isBig: true)
    }
}

