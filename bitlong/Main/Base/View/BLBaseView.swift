//
//  BLBaseView.swift
//  bitlong
//
//  Created by slc on 2024/4/29.
//

import UIKit

class BLBaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTableView() -> UITableView{
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.estimatedRowHeight = 0
        
        table.bounces = true
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none;
        
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        }
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        
        return table
    }
    
    func getBannerView() -> XRCarouselView{
        let view = XRCarouselView.init()
        //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
        view.placeholderImage = imagePic(name: "placeholder")
        //设置每张图片的停留时间，默认值为5s，最少为1s
        view.time = 5;
        //设置分页控件的图片,不设置则为系统默认
    //    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
        //设置分页控件的位置，默认为PositionBottomCenter
        view.pagePosition = .PositionBottomRight
        //设置滑动时gif停止播放
        view.gifPlayMode = .pauseWhenScroll
        //设置滑动样式
        view.changeMode = .default
        
        return view
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)  
   }

    deinit {
        NSSLog(msg: String.init(format: "视图\n-%@- had deinited！",NSStringFromClass(object_getClass(self)!)))
    }
}
