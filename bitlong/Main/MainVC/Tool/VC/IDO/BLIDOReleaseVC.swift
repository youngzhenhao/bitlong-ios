//
//  BLIDOReleaseVC.swift
//  bitlong
//
//  Created by slc on 2024/6/19.
//

import UIKit

class BLIDOReleaseVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "发布"
        self.navgationRightBtn(picStr: "", title: "历史记录", titleColor: nil)
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }

    func initUI(){
        
    }
}
