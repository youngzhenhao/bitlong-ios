//
//  BLTransactionDetailVC.swift
//  bitlong
//
//  Created by slc on 2024/5/20.
//

import UIKit

class BLTransactionDetailVC: BLBaseVC,JXCategoryListCollectionContainerViewDataSource,JXCategoryViewDelegate,JXCategoryListCollectionScrollViewDelegate,DetaiHeaderDelegate,TimeItemDelegate {

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
        self.view.addSubview(detaiHeaderView)
        self.view.addSubview(timeItemView)
        self.view.addSubview(chartsView)
        self.view.addSubview(categoryView)
        self.view.insertSubview(lineView, belowSubview: categoryView)
        self.view.addSubview(listContainerView)
        
        detaiHeaderView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(StatusBarHeight)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(detaiHeaderView.frame.height)
        }
        
        timeItemView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(detaiHeaderView.mas_bottom)?.offset()(20*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(26*SCALE)
        }
        
        chartsView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(timeItemView.mas_bottom)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(200*SCALE)
        }
        
        categoryView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(chartsView.mas_bottom)?.offset()(10*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(30*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(categoryView.mas_bottom)?.offset()(-2.25*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
        
        listContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(categoryView.mas_bottom)
            make?.left.right().bottom().mas_equalTo()(0)
        }
    
        self.configCategoryViewImgTitles()
    }

    lazy var detaiHeaderView : BLTransactionDetaiHeaderView = {
        var view = BLTransactionDetaiHeaderView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var timeItemView : BLTransactionTimeItemView = {
        var view = BLTransactionTimeItemView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var chartsView : BLTranscationChartsView = {
        var view = BLTranscationChartsView.init()
        
        return view
    }()
    
    lazy var categoryView : JXCategoryTitleImageView = {
        var view = JXCategoryTitleImageView.init()
        view.isContentScrollViewClickTransitionAnimationEnabled = false
        view.delegate = self
        view.indicators = [indicatorLineView];
        view.titleColor = UIColorHex(hex: 0x808080, a: 1.0)
        view.titleSelectedColor = UIColorHex(hex: 0x383838, a: 1.0)
        view.titleFont = FONT_NORMAL(s: 14 * Float(SCALE))
        view.titleSelectedFont = FONT_BOLD(s: 16 * Float(SCALE))
        view.isTitleLabelZoomEnabled = false
        view.titleLabelZoomScale = 1.3
        view.isTitleColorGradientEnabled = true
        view.isTitleLabelZoomScrollGradientEnabled = true
        view.isImageZoomEnabled = true
        view.imageSize = CGSizeMake(20*SCALE, 20*SCALE)
        view.imageZoomScale = 1.3;
        view.contentEdgeInsetLeft = 20*SCALE
        view.cellSpacing = 40*SCALE
        view.contentScrollView = listContainerView.collectionView
        
        return view
    }()
    
    lazy var indicatorLineView : JXCategoryIndicatorLineView = {
        var view = JXCategoryIndicatorLineView.init()
        view.indicatorColor = UIColorHex(hex: 0x7B71F2, a: 1.0)
        view.indicatorWidth = 26*SCALE
        view.indicatorHeight = 4*SCALE
        
        return view
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xE8E7E7, a: 1.0)
        
        return view
    }()
    
    lazy var listContainerView : JXCategoryListCollectionContainerView = {
        var view = JXCategoryListCollectionContainerView.init(dataSource: self)
        view!.delegate = self
        view?.collectionView.backgroundColor = .white
        
        return view!
    }()
    
    lazy var titleList : NSArray = {
        var arr = ["市场","交易","池子","我的挂单"]
        
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
        if index < titleList.count{
            let title : String = titleList[index] as! String
            if title == CategoryPageType.detailMarket.rawValue{
                return BLTranscationDetailMarketVC.init()
            }else if title == CategoryPageType.detailList.rawValue{
                return BLTranscationDetailListVC.init()
            }else if title == CategoryPageType.detailPool.rawValue{
                return BLTranscationDetailPoolVC.init()
            }else if title == CategoryPageType.detailMyOrder.rawValue{
                return BLTranscationDetailMyOrderVC.init()
            }
        }
        
        return BLBaseVC.init()
    }

    func number(ofListsInlistContainerView listContainerView: JXCategoryListCollectionContainerView!) -> Int {
        return titleList.count
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        currentIndex = index
    }
    
    func jxCategoryListCollectionScrollViewWillBeginDecelerating(_ scrollView: UIScrollView!) {
        
    }

    func jxCategoryListCollectionScrollViewDidEndDecelerating(_ scrollView: UIScrollView!) {

    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        
    }
    
    //DetaiHeaderDelegate
    func backAcation() {
        self.back()
    }

    //TimeItemDelegate
    func itemClickAcation(index: NSInteger) {
        if index == ChartTimeType.chartOneMin.rawValue{
            NSSLog(msg: "1分")
        }else if index == ChartTimeType.chartFiveMin.rawValue{
            NSSLog(msg: "5分")
        }else if index == ChartTimeType.chartThirtyMin.rawValue{
            NSSLog(msg: "30分")
        }else if index == ChartTimeType.chartOneHour.rawValue{
            NSSLog(msg: "1时")
        }else if index == ChartTimeType.chartFourHour.rawValue{
            NSSLog(msg: "4时")
        }else if index == ChartTimeType.chartOneDay.rawValue{
            NSSLog(msg: "1天")
        }else if index == ChartTimeType.chartOneWeek.rawValue{
            NSSLog(msg: "1周")
        }else if index == ChartTimeType.chartMore.rawValue{
            NSSLog(msg: "更多")
        }else if index == ChartTimeType.chartIndex.rawValue{
            NSSLog(msg: "指标")
        }
    }
}
