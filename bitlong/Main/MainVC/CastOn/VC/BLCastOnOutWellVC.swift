//
//  BLCastOnOutWellVC.swift
//  bitlong
//
//  Created by slc on 2024/5/13.
//

import UIKit

class BLCastOnOutWellVC: BLBaseVC,CastOnDelegate,JXCategoryListCollectionContainerViewDataSource,JXCategoryViewDelegate,JXCategoryListCollectionScrollViewDelegate {
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: true)
    }
    
    func initUI(){
        self.view.addSubview(headerView)
        self.view.addSubview(categoryView)
        self.view.addSubview(listContainerView)
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(headerView.frame.height)
        }
        BLTools.topColorChange(view: headerView, colorBegin: UIColorHex(hex: 0xD3CFFC, a: 1.0), colorEnd: UIColorHex(hex: 0xD3CFFC, a: 0.0), direction: 0)
        
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
    
    lazy var headerView : BLCastOnHeaderView = {
        var view = BLCastOnHeaderView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var categoryView : JXCategoryTitleImageView = {
        var view = JXCategoryTitleImageView.init()
        view.backgroundColor = UIColorHex(hex: 0xFAFAFA, a: 1.0)
        view.isContentScrollViewClickTransitionAnimationEnabled = false
        view.delegate = self
        view.titleColor = UIColorHex(hex: 0x383838, a: 1.0)
        view.titleSelectedColor = UIColorHex(hex: 0x383838, a: 1.0)
        view.titleFont = FONT_NORMAL(s: 14 * Float(SCALE))
        view.titleSelectedFont = FONT_BOLD(s: 18 * Float(SCALE))
        view.isTitleLabelZoomEnabled = false
        view.titleLabelZoomScale = 1.3
        view.isTitleColorGradientEnabled = true
        view.isTitleLabelZoomScrollGradientEnabled = true
        view.isImageZoomEnabled = true
        view.imageSize = CGSizeMake(20*SCALE, 20*SCALE)
        view.imageZoomScale = 1.3;
        view.contentEdgeInsetLeft = 20*SCALE
        view.cellSpacing = 20*SCALE
        view.contentScrollView = listContainerView.collectionView
        
        return view
    }()
    
    lazy var listContainerView : JXCategoryListCollectionContainerView = {
        var view = JXCategoryListCollectionContainerView.init(dataSource: self)
        view!.delegate = self
        view?.collectionView.backgroundColor = .white
        
        return view!
    }()
    
    lazy var titleList : NSArray = {
        var arr = ["我的关注","热门榜","铸造中","已结束"]
        
        return arr as NSArray
    }()
    
    func configCategoryViewImgTitles(){
        let titles : NSMutableArray = NSMutableArray.init()
        let noramlImages : NSMutableArray = NSMutableArray.init()
        let selectedImages : NSMutableArray = NSMutableArray.init()
        let imageTypes : NSMutableArray = NSMutableArray.init()
        let imageSize : NSMutableArray = NSMutableArray.init()
        
        for i in 0..<titleList.count{
            let title : String = titleList[i] as! String
            autoreleasepool {
                titles.add(title)
                imageTypes.add(JXCategoryTitleImageType.onlyTitle.rawValue)
                noramlImages.add("")
                selectedImages.add("")
                imageSize.add(CGSize.init(width: 114*SCALE, height: 56 * SCALE))
            }
        }
        
        categoryView.titles = (titles as! [String])
        categoryView.imageNames = (noramlImages as! [String])
        categoryView.selectedImageNames = (selectedImages as! [String])
        categoryView.imageTypes = (imageTypes as! [NSNumber])
        categoryView.imageSizes = (imageSize as! [NSValue])
        
        self.updateCategoryView()
    }
    
    func updateCategoryView(){
        categoryView.reloadData()
        listContainerView.reloadData()
        self.setIndexValue(index: 0)
    }
    
    func setIndexValue(index : NSInteger){
        categoryView.selectItem(at: index)
    }
    
    
    func listContainerView(_ listContainerView: JXCategoryListCollectionContainerView!, initListFor index: Int) -> JXCategoryListCollectionContentViewDelegate! {
        let listVC : BLCastOnListVC = BLCastOnListVC.init()
        
        return listVC
    }
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListCollectionContainerView!) -> Int {
        return titleList.count
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        if currentIndex == index{
            return
        }
        currentIndex = index
    }
    
    func jxCategoryListCollectionScrollViewWillBeginDecelerating(_ scrollView: UIScrollView!) {
        
    }
    
    func jxCategoryListCollectionScrollViewDidEndDecelerating(_ scrollView: UIScrollView!) {
        NSSLog(msg: "调用滚动完成")
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        
    }
    
    //CastOnDelegate
    func clickAcation(sender: UIButton) {
        if sender.tag == 100{//发行
            let creatAssetsVC : BLCreatAssetsVC = BLCreatAssetsVC.init()
            creatAssetsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(creatAssetsVC, animated: true)
        }else if sender.tag == 101{//铸造
            let creatCastOnVC : BLCreatCastOnVC = BLCreatCastOnVC.init()
            creatCastOnVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(creatCastOnVC, animated: true)
        }
    }
}

