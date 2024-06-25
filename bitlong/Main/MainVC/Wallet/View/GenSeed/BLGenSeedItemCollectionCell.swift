//
//  BLGenSeedItemCollectionCell.swift
//  bitlong
//
//  Created by slc on 2024/4/30.
//

import UIKit

let GenSeedItemCollectionCellId = "GenSeedItemCollectionCellId"

class BLGenSeedItemCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(tagLbl)
        self.addSubview(titleLbl)
        tagLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(8*SCALE)
            make?.width.height().mas_equalTo()(16*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(tagLbl.mas_bottom)?.offset()(6*SCALE)
            make?.bottom.mas_equalTo()(-8*SCALE)
            make?.left.right().mas_equalTo()(0)
        }
    }
    
    lazy var tagLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.backgroundColor = .lightGray
        lbl.layer.cornerRadius = 8*SCALE
        lbl.clipsToBounds = true
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 10*SCALE)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16*SCALE)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    func assign(text : String,index : NSInteger){
        tagLbl.text = String.init(format: "%ld",index+1)
        titleLbl.text = text
    }
}
