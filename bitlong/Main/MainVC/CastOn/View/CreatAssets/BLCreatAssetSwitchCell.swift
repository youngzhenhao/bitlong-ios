//
//  BLCreatAssetSwitchCell.swift
//  bitlong
//
//  Created by slc on 2024/5/23.
//

import UIKit

let BLCreatAssetTypeCellId        = "BLCreatAssetTypeCellId"
let BLCreatAssetLockoutTimeCellId = "BLCreatAssetLockoutTimeCellId"

class BLCreatAssetSwitchCell: BLCreatAssetsCell {

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
        self.contentView.addSubview(typeTitleLbl)
        self.contentView.addSubview(switchLblOne)
        self.contentView.addSubview(switchBtOne)
        self.contentView.addSubview(switchLblTwo)
        self.contentView.addSubview(switchBtTwo)
        
        typeTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(0)
            make?.height.mas_equalTo()(14*SCALE)
            make?.width.mas_equalTo()(100*SCALE)
            make?.centerY.mas_equalTo()(0)
        }

        switchBtTwo.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-70*SCALE)
            make?.width.height().mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        switchLblTwo.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(switchBtTwo.mas_left)?.offset()(-5*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.height.mas_equalTo()(19*SCALE)
            make?.width.mas_equalTo()(40*SCALE)
        }
        
        switchBtOne.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(switchLblTwo.mas_left)?.offset()(-20*SCALE)
            make?.width.height().mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        switchLblOne.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(switchBtOne.mas_left)?.offset()(-5*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.height.mas_equalTo()(19*SCALE)
            make?.width.mas_equalTo()(80*SCALE)
        }
    }
    
    override func setCellType(type : CreatAssetsCellType){
        super.setCellType(type: type)
        typeTitleLbl.textAlignment = .right
        self.updateConstraint()
        
        switch type {
        case .assetsType:
            typeTitleLbl.text = "类别"
            switchLblOne.text = "Tap20"
            switchLblTwo.text = "NFT"
            
            typeTitleLbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
            switchLblOne.textColor = UIColorHex(hex: 0x383838, a: 1.0)
            switchLblTwo.textColor = UIColorHex(hex: 0x383838, a: 1.0)
            switchBtOne.isUserInteractionEnabled = true
            switchBtTwo.isUserInteractionEnabled = true
            
            switchLblOne.font = FONT_NORMAL(s: 14*Float(SCALE))
            switchLblTwo.font = FONT_NORMAL(s: 14*Float(SCALE))
            self.switchAcation(sender: switchBtOne)
            break
        case .assetsLockoutTime:
            typeTitleLbl.text = "锁仓时间"
            switchLblOne.text = "相对时间"
            switchLblTwo.text = "绝对时间"
            
            typeTitleLbl.textColor = UIColorHex(hex: 0x383838, a: 0.5)
            switchLblOne.textColor = UIColorHex(hex: 0x383838, a: 0.5)
            switchLblTwo.textColor = UIColorHex(hex: 0x383838, a: 0.5)
            switchBtOne.isUserInteractionEnabled = false
            switchBtTwo.isUserInteractionEnabled = false
            
            switchLblOne.font = FONT_NORMAL(s: 12*Float(SCALE))
            switchLblTwo.font = FONT_NORMAL(s: 12*Float(SCALE))
            break
        default:
            break
        }
    }
    
    func setCellState(isHidden : Bool){
        typeTitleLbl.isHidden = isHidden
        switchLblOne.isHidden = isHidden
        switchBtOne.isHidden = isHidden
        switchLblTwo.isHidden = isHidden
        switchBtTwo.isHidden = isHidden
    }
    
    func updateConstraint() {
        switchBtTwo.mas_updateConstraints { (make : MASConstraintMaker?) in
            if cellType == .assetsLockoutTime{
                make?.right.mas_equalTo()(-50*SCALE)
            }else{
                make?.right.mas_equalTo()(-70*SCALE)
            }
        }
        
        switchLblTwo.mas_updateConstraints { (make : MASConstraintMaker?) in
            if cellType == .assetsLockoutTime{
                make?.width.mas_equalTo()(50*SCALE)
            }else{
                make?.width.mas_equalTo()(40*SCALE)
            }
        }
        
        switchBtOne.mas_updateConstraints { (make : MASConstraintMaker?) in
            if cellType == .assetsLockoutTime{
                make?.right.mas_equalTo()(switchLblTwo.mas_left)?.offset()(-50*SCALE)
            }else{
                make?.right.mas_equalTo()(switchLblTwo.mas_left)?.offset()(-20*SCALE)
            }
        }
    }
    
    lazy var switchLblOne : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var switchBtOne : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_switch_normal"), for: .normal)
        bt.setImage(imagePic(name: "ic_switch_selected"), for: .selected)
        bt.addTarget(self, action: #selector(switchAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var switchLblTwo : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    lazy var switchBtTwo : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_switch_normal"), for: .normal)
        bt.setImage(imagePic(name: "ic_switch_selected"), for: .selected)
        bt.addTarget(self, action: #selector(switchAcation), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func switchAcation(sender : UIButton){
        if sender == switchBtOne{
            if switchBtOne.isSelected{
                return
            }
            switchBtTwo.isSelected = false
        }else if sender == switchBtTwo{
            if switchBtTwo.isSelected{
                return
            }
            switchBtOne.isSelected = false
        }
        
        sender.isSelected = !sender.isSelected
        
        if cellType == .assetsType{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsType(index:)))) != nil{
                if switchBtOne.isSelected{
                    delegate?.setAssetsType!(index: 0)
                }else if switchBtTwo.isSelected{
                    delegate?.setAssetsType!(index: 1)
                }
            }
        }else if cellType == .assetsLockoutTime{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.setAssetsLockTimeType(index:)))) != nil{
                if switchBtOne.isSelected{
                    delegate?.setAssetsLockTimeType!(index: 0)
                }else if switchBtTwo.isSelected{
                    delegate?.setAssetsLockTimeType!(index: 1)
                }
            }
        }
    }
}
