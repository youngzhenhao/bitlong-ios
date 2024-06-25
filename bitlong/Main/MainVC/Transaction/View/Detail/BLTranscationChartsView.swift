//
//  BLTranscationChartsView.swift
//  bitlong
//
//  Created by slc on 2024/5/21.
//

import UIKit

class BLTranscationChartsView: BLBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColorHex(hex: 0x000000, a: 1.0)
    }
}
