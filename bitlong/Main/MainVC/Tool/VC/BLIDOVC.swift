//
//  BLIDOVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/18.
//

import UIKit

class BLIDOVC: BLCastOnOutWellVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IDO"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func initUI(){
        self.view.addSubview(headerView)
        self.view.addSubview(categoryView)
        self.view.addSubview(listContainerView)
        headerView.showOfPageIDO()
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(headerView.frame.height)
        }
        
        categoryView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)?.offset()(40*SCALE)
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(40*SCALE)
            make?.right.mas_equalTo()(0)
        }
        
        listContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(categoryView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
        
        self.configCategoryViewImgTitles()
    }
    
    override func listContainerView(_ listContainerView: JXCategoryListCollectionContainerView!, initListFor index: Int) -> JXCategoryListCollectionContentViewDelegate! {
        let listVC : BLIDOListVC = BLIDOListVC.init()
        
        return listVC
    }

    //CastOnDelegate
    override func clickAcation(sender: UIButton) {
        if sender.tag == 100{//发行
            self.pushBaseVCStr(vcStr: "BLIDOReleaseVC", animated: true)
        }else if sender.tag == 101{//铸造
            self.pushBaseVCStr(vcStr: "BLIDOJoinVC", animated: true)
        }
    }
}
