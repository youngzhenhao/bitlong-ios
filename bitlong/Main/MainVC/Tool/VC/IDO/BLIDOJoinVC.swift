//
//  BLIDOJoinVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/19.
//

import UIKit

class BLIDOJoinVC: BLBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "参与"
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }

    func initUI(){
        
    }
}
