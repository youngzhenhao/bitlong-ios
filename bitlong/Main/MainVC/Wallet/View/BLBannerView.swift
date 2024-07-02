//
//  BLBannerView.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

class BLBannerView: BLBaseView,XRCarouselViewDelegate{

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(bannerView)
        bannerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.edges.equalTo()(self)
        }
    }

    lazy var bannerView : XRCarouselView = {
        var view = self.getBannerView()
        view.delegate = self
        
        return view
    }()
    
    //XRCarouselViewDelegate
    func carouselView(_ carouselView: XRCarouselView!, clickImageAt index: Int) {
        
    }
    
    func assignBanner(imageArr : NSArray?){
        if imageArr != nil && 0 < imageArr!.count{
            //设置图片数组及图片描述文字
            bannerView.imageArray = (imageArr as! [Any])
//            bannerView.describeArray = describeArray
        }
    }
}
