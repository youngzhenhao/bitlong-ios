//
//  BLBaseView.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/29.
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)  
   }

    deinit {
        NSSLog(msg: String.init(format: "视图\n-%@- had deinited！",NSStringFromClass(object_getClass(self)!)))
    }
}
