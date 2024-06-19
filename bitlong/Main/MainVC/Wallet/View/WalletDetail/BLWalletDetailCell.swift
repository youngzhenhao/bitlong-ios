//
//  BLWalletDetailCell.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/11.
//

import UIKit

let BLWalletDetailCellId = "BLWalletDetailCellId"

@objc protocol WalletDetailCellDelegate : NSObjectProtocol {
    func walletDetailAcation(sender : UIButton,text : String)
    func creatQRAcation(addr : String)
}

class BLWalletDetailCell: BLBaseTableViewCell {
    
    weak var delegate : WalletDetailCellDelegate?
    var indexPath : IndexPath = IndexPath.init(row: 0, section: 0)
    
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
    
    func initWalletInfo(isFromHome : Bool){
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(subTitleLbl)
        if isFromHome{
            containerView.addSubview(iconImgView)
            containerView.addSubview(copyBt)
            containerView.addSubview(btcLbl)
            
            containerView.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
            titleLbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
            subTitleLbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        }else{
            self.contentView.addSubview(iconImgView)
            self.contentView.addSubview(copyBt)
            self.contentView.addSubview(editBt)
        }
        
        iconImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            if isFromHome{
                make?.left.mas_equalTo()(10*SCALE)
                make?.width.height().mas_equalTo()(40*SCALE)
                make?.centerY.mas_equalTo()(0)
            }else{
                make?.top.left().mas_equalTo()(20*SCALE)
                make?.width.height().mas_equalTo()(50*SCALE)
            }
        }
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            if isFromHome{
                make?.top.bottom().mas_equalTo()(0)
                make?.left.mas_equalTo()(10*SCALE)
                make?.right.mas_equalTo()(-10*SCALE)
            }else{
                make?.top.mas_equalTo()(iconImgView.mas_top)
                make?.left.mas_equalTo()(iconImgView.mas_right)?.offset()(8*SCALE)
                make?.right.mas_equalTo()(-56*SCALE)
                make?.bottom.mas_equalTo()(iconImgView.mas_bottom)?.offset()(-5*SCALE)
            }
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            if isFromHome{
                make?.top.mas_equalTo()(iconImgView.mas_top)
                make?.left.mas_equalTo()(iconImgView.mas_right)?.offset()(10*SCALE)
                make?.right.mas_equalTo()(-80*SCALE)
            }else{
                make?.top.left().right().mas_equalTo()(0)
            }
            make?.height.mas_equalTo()(20*SCALE)
        }
        
        subTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            if isFromHome{
                make?.bottom.mas_equalTo()(iconImgView.mas_bottom)
                make?.width.mas_equalTo()((SCREEN_WIDTH-20*SCALE)/2.0)
            }else{
                make?.bottom.right().mas_equalTo()(0)
            }
            make?.left.mas_equalTo()(titleLbl.mas_left)
            make?.height.mas_equalTo()(15*SCALE)
        }
        
        if editBt.superview != nil{
            editBt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.right.mas_equalTo()(-20*SCALE)
                make?.width.height().mas_equalTo()(18*SCALE)
                make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
            }
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            if isFromHome{
                make?.left.mas_equalTo()(subTitleLbl.mas_right)?.offset()(10*SCALE)
            }else{
                make?.right.mas_equalTo()(-20*SCALE)
            }
            make?.centerY.mas_equalTo()(subTitleLbl.mas_centerY)
            make?.width.height().mas_equalTo()(18*SCALE)
        }
        
        if btcLbl.superview != nil{
            btcLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.right.mas_equalTo()(-10*SCALE)
                make?.size.mas_equalTo()(btcLbl.frame.size)
                make?.centerY.mas_equalTo()(0)
            }
        }
    }
    
    func initNormal(){
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(subTitleLbl)
        self.contentView.addSubview(nextImgView)
        self.contentView.addSubview(copyBt)
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(24*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-46*SCALE)
        }
        
        subTitleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(titleLbl.mas_right)?.offset()(10*SCALE)
            make?.right.mas_equalTo()(-46*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
        }
        
        nextImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(6*SCALE)
            make?.height.mas_equalTo()(12*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.right.mas_equalTo()(-20*SCALE)
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.height().mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(titleLbl.mas_centerY)
            make?.right.mas_equalTo()(-20*SCALE)
        }
    }
    
    lazy var iconImgView : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_bit"))
        view.contentMode = .scaleAspectFit
    
        return view
    }()
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapCreatQRAcation))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_BOLD(s: 15*Float(SCALE))
        lbl.textAlignment = .left
    
        return lbl
    }()
    
    lazy var subTitleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 15*Float(SCALE))
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingMiddle
    
        return lbl
    }()
    
    lazy var copyBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_copy"), for: .normal)
        bt.tag = 100
        bt.addTarget(self, action: #selector(clickAcation(sender:)), for: .touchUpInside)
    
        return bt
    }()
    
    lazy var editBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_edit"), for: .normal)
        bt.tag = 101
        bt.addTarget(self, action: #selector(clickAcation(sender:)), for: .touchUpInside)
    
        return bt
    }()
    
    lazy var btcLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "BTC"
        lbl.textColor = UIColorHex(hex: 0xFCC538, a: 1.0)
        lbl.font = FONT_BOLD(s: 16*Float(SCALE))
        lbl.sizeToFit()
      
        return lbl
    }()

    lazy var nextImgView : UIImageView = {
        var view = UIImageView.init(image: imagePic(name: "ic_next_gray"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    @objc func clickAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.walletDetailAcation(sender:text:)))) != nil{
            delegate?.walletDetailAcation(sender: sender, text: subTitleLbl.text!)
        }
    }
    
    func assignWalletInfo(){
        let obj = userDefaults.object(forKey: WalletInfo)
        if obj != nil && obj is NSDictionary{
            let walletDic : NSDictionary = obj as! NSDictionary
            titleLbl.text = walletDic[WalletName] as? String
        }else{
            titleLbl.text = "--"
        }
        
        let address = userDefaults.value(forKey: WalletAddress)
        if address != nil && address is String{
            subTitleLbl.text = address as? String
        }else{
            subTitleLbl.text = "--"
        }
    }
    
    func assignNormalInfo(title : String, path : IndexPath){
        indexPath = path
        titleLbl.text = title
        titleLbl.sizeToFit()
        titleLbl.mas_remakeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(24*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.width.mas_equalTo()(titleLbl.frame.width)
            make?.centerY.mas_equalTo()(0)
        }
        
        if path.section == 3{
            subTitleLbl.isHidden = false
            nextImgView.isHidden = true
            copyBt.isHidden = false
            
            subTitleLbl.text = ApiGetNPublicKey()
        }else{
            subTitleLbl.isHidden = true
            nextImgView.isHidden = false
            copyBt.isHidden = true
        }
    }
    
    @objc func tapCreatQRAcation(){
        //生成二维码
        if subTitleLbl.text != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.creatQRAcation(addr:)))) != nil{
                delegate?.creatQRAcation(addr: subTitleLbl.text!)
            }
        }
    }
}
