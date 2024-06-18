//
//  BLCommonCollectionView.swift
//  bitlong
//
//  Created by Slc on 2024/4/29.
//

import UIKit
 
@objc protocol ItemSelectedDelegate : NSObjectProtocol {
}

enum PageType{
    case getGenSeedType
}

class BLCommonCollectionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @objc weak var selectedDelegate : ItemSelectedDelegate?
    var pageType : PageType?
    
    var listDatas : NSArray = NSArray.init()
    
    var currentItem : NSInteger = -1
    var contentItemSize : NSInteger = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self
        
        if #available(iOS 10, *) {
            self.isPrefetchingEnabled = false;
        }
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never;
        }
    
        self.register(BLGenSeedItemCollectionCell.self, forCellWithReuseIdentifier: GenSeedItemCollectionCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if pageType == .getGenSeedType{
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BLGenSeedItemCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenSeedItemCollectionCellId, for: indexPath) as! BLGenSeedItemCollectionCell
        if pageType == .getGenSeedType{
            if indexPath.item < listDatas.count{
                cell.assign(text: listDatas[indexPath.item] as! String, index: indexPath.item)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if listDatas.count <= indexPath.item{
            return
        }
        
        currentItem = indexPath.item
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right:0)
    }
    
    //设定指定区内Cell的最小间距，也可以直接设置UICollectionViewFlowLayout的minimumInteritemSpacing属性
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    //设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if pageType == .getGenSeedType{
            return CGSize.init(width: (SCREEN_WIDTH - 32*SCALE)/4.0, height: (SCREEN_WIDTH - 32*SCALE)/1.02/6.0)
        }
        
        return CGSize.init(width: 0, height: 0)
    }
    
    func assignDatas(datas:NSArray){
        if listDatas == datas{
            return
        }

        listDatas = datas
        self.reloadData()
    }
    
    func setSelectedIndex(index : NSInteger){
        self.collectionView(self, didSelectItemAt: IndexPath.init(item: index, section: 0))
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollToScrollStop : Bool = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        if scrollToScrollStop {
            self.scrollViewDidEndScroll(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let dragToDragStop : Bool = scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
            if dragToDragStop {
                self.scrollViewDidEndScroll(scrollView: scrollView)
            }
        }
    }
    
    func scrollViewDidEndScroll(scrollView : UIScrollView){
        if(contentItemSize == 0 && 0 < listDatas.count){
            contentItemSize = Int(scrollView.contentSize.width) / listDatas.count
        }
    }
    
    func `deinit`(){
        print("视图-%@- had deinited！",NSStringFromClass(object_getClass(self)!))
    }
}
