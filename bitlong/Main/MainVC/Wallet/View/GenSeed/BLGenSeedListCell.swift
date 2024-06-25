//
//  BLGenSeedListCell.swift
//  bitlong
//
//  Created by slc on 2024/4/30.
//

import UIKit

let GenSeedListCellId = "GenSeedListCellId"

class BLGenSeedListCell: BLBaseTableViewCell,ItemSelectedDelegate {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initUI(){
        self.contentView.addSubview(collectionView)
        collectionView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.bottom.mas_equalTo()(-9*SCALE)
        }
    }

    lazy var collectionView : BLCommonCollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collection = BLCommonCollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.selectedDelegate = self
        collection.backgroundColor = .lightText
        collection.pageType = .getGenSeedType
        collection.layer.cornerRadius = 10*SCALE
        collection.clipsToBounds = true
        
        return collection
    }()
    
    func assign(genSeed : String){
        let list = genSeed.components(separatedBy: ",")
        if 0 < list.count{
            collectionView.assignDatas(datas: list as NSArray)
        }
    }
    
    //ItemSelectedDelegate
}
