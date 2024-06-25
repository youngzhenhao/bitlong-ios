//
//  BLWalletCell.swift
//  bitlong
//
//  Created by slc on 2024/4/28.
//

import UIKit

let WalletCellId = "WalletCellId"

class BLWalletCell: BLBaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        self.contentView.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(subTitleLbl)
        self.contentView.addSubview(nextImg)
        
        titleLbl.mas_makeConstraints {(make :  MASConstraintMaker?) in
            make?.left.mas_equalTo()(23)
            make?.top.mas_equalTo()(20)
            make?.height.mas_equalTo()(18)
            make?.right.mas_equalTo()(-100)
        }
        
        subTitleLbl.mas_makeConstraints {(make :  MASConstraintMaker?) in
            make?.left.mas_equalTo()(23)
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(8)
            make?.height.mas_equalTo()(16)
            make?.right.mas_equalTo()(-100)
        }
        
        nextImg.mas_makeConstraints {(make :  MASConstraintMaker?) in
            make?.right.mas_equalTo()(-26)
            make?.width.mas_equalTo()(6)
            make?.height.mas_equalTo()(12)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = .blue
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var subTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var nextImg : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_next_gray"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
}
