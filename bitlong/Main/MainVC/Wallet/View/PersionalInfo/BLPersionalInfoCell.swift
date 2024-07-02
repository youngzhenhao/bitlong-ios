//
//  BLPersionalInfoCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/7/1.
//

import UIKit

let BLPersionalInfoCellId = "BLPersionalInfoCellId"

class BLPersionalInfoCell: BLBaseTableViewCell {
    
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
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(nextImgView)
        self.contentView.addSubview(lineView)
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(24*SCALE)
            make?.height.mas_equalTo()(18*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.width.mas_equalTo()(150*SCALE)
        }
        
        nextImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(6*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(0)
            make?.left.mas_equalTo()(24*SCALE)
            make?.height.mas_equalTo()(1*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
        }
    }
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var nextImgView : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_next_gray"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xE5E5E5, a: 1.0)
        
        return view
    }()
    
    func assignText(title : String,indexPath : IndexPath){
        titleLbl.text = title
        if indexPath.section == 1{
            lineView.isHidden = indexPath.row == 0
        }else{
            lineView.isHidden = true
        }
    }
}
