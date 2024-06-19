//
//  BLCreatAssetsCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/7.
//

import UIKit
 
let BLCreatAssetsCellId = "BLCreatAssetsCellId"

@objc protocol CreatAssetsDelegate : NSObjectProtocol {
    @objc optional func getLogoPicAcation()
    @objc optional func setAssetsName(name : String)
    @objc optional func setAssetsType(index : NSInteger)
    @objc optional func setAssetsNum(num : NSInteger)
    @objc optional func setAssetsReserve(reserve : NSInteger)
    @objc optional func setAssetsMintNum(num : NSInteger)
    @objc optional func setAssetsBegainDate(date : Date)
    @objc optional func setAssetsEndDate(date : Date)
    @objc optional func setAssetsUnLockDate(date : Date)
    @objc optional func setAssetsLockTimeType(index : NSInteger)
    @objc optional func setAssetsDescription(description : String)
}

class BLCreatAssetsCell: BLBaseTableViewCell {
    
    @objc weak var delegate : CreatAssetsDelegate?
    var cellType : CreatAssetsCellType?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.cornerRadius = 6*SCALE
        view.layer.borderColor = UIColorHex(hex: 0x665AF0, a: 1.0).cgColor
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = true
        view.tag = 101
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(containerTapAcation))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var typeTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 14*Float(SCALE))
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    func setCellType(type : CreatAssetsCellType){
        cellType = type
    }
    
    func setAttributed(text : NSString) -> NSMutableAttributedString{
        let range : NSRange = text.range(of: "*")
        let att : NSMutableAttributedString = NSMutableAttributedString.init(string: text as String)
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColorHex(hex: 0xEC3468, a: 1.0), range: range)
        
        return att
    }
    
    @objc func containerTapAcation(){
    }
}
