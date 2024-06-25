//
//  BLWalletHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/8.
//

import UIKit

@objc protocol HeaderDelegate : NSObjectProtocol {
    func walletAcation()
    func clickedAcation(sender : UIButton)
}

class BLWalletHeaderView: BLBaseView {
    
    @objc weak var delegate : HeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(bgImgView)
        self.addSubview(walletImgView)
        self.addSubview(scanImgView)
        self.addSubview(personalImgView)
        self.addSubview(walletNamelbl)
        self.addSubview(detailBt)
        self.addSubview(allAssetslbl)
        self.addSubview(bannerView)
        self.addSubview(noticeContainerView)
        noticeContainerView.addSubview(hornImgView)
        noticeContainerView.addSubview(noticeLinelbl)
        noticeContainerView.addSubview(noticeTitlelbl)
        
        bgImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_equalTo()(120*SCALE)
        }
        
        walletImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.top.mas_equalTo()(StatusBarHeight+10*SCALE)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        scanImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(personalImgView.mas_left)?.offset()(-15*SCALE)
            make?.top.mas_equalTo()(walletImgView.mas_top)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        personalImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(walletImgView.mas_top)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        walletNamelbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(18*SCALE)
            make?.top.mas_equalTo()(walletImgView.mas_bottom)?.offset()(20*SCALE)
            make?.height.mas_equalTo()(24*SCALE)
            make?.width.mas_equalTo()(SCREEN_WIDTH/2.0)
        }
        
        detailBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.centerY.mas_equalTo()(walletNamelbl.mas_centerY)
            make?.height.mas_equalTo()(18*SCALE)
            make?.width.mas_equalTo()(detailBt.frame.width)
        }
        
        allAssetslbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(walletNamelbl.mas_left)
            make?.top.mas_equalTo()(walletNamelbl.mas_bottom)?.offset()(13*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
        }
        
        bannerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(allAssetslbl.mas_bottom)?.offset()(10*SCALE)
            make?.height.mas_equalTo()((SCREEN_WIDTH-30*SCALE)/2.73)
        }
        
        noticeContainerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(bannerView.mas_bottom)?.offset()(8*SCALE)
            make?.height.mas_equalTo()((SCREEN_WIDTH-30*SCALE)/11.9)
        }
        
        hornImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(12*SCALE)
            make?.width.height().mas_equalTo()(16*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        noticeLinelbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(hornImgView.mas_right)?.offset()(16*SCALE)
            make?.top.mas_equalTo()(8*SCALE)
            make?.bottom.mas_equalTo()(-8*SCALE)
            make?.width.mas_equalTo()(0.5*SCALE)
        }
        
        noticeTitlelbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(noticeLinelbl.mas_right)?.offset()(16*SCALE)
            make?.right.mas_equalTo()(-16*SCALE)
            make?.centerY.mas_equalTo()(0)
            make?.height.mas_equalTo()(18*SCALE)
        }
        
        self.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.bottom.mas_equalTo()(noticeContainerView.mas_bottom)
        }
    }
    
    lazy var bgImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_bg"))
        imgView.contentMode = .scaleAspectFill
        
        return imgView
    }()
    
    lazy var walletImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_wallet"))
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(walletAcation))
        imgView.addGestureRecognizer(tap)
        
        return imgView
    }()
    
    lazy var scanImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_scan"))
        imgView.contentMode = .scaleAspectFill
        
        return imgView
    }()
    
    lazy var personalImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_personal"))
        imgView.contentMode = .scaleAspectFill
        
        return imgView
    }()
    
    lazy var walletNamelbl : UILabel = {
        var lbl : UILabel = UILabel.init()
        lbl.text = "--"
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_BOLD(s: 24*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var detailBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("详情", for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 13*Float(SCALE))
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.setImage(imagePic(name: "ic_next_white"), for: .normal)
        bt.addTarget(self, action: #selector(clickedAcation(sender:)), for: .touchUpInside)
        bt.sizeToFit()
        bt.iconInRight(with: 0)
        
        return bt
    }()

    lazy var allAssetslbl : UILabel = {
        var lbl : UILabel = UILabel.init()
        lbl.text = "总资产:0 sats"
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_BOLD(s: 20*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var bannerView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_banner"))
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    lazy var noticeContainerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xEBF4FF, a: 1.0)
        view.layer.cornerRadius = 15*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var hornImgView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_home_horn"))
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    lazy var noticeLinelbl : UILabel = {
        var lbl : UILabel = UILabel.init()
        lbl.text = "|"
        lbl.textColor = UIColorHex(hex: 0xA985FF, a: 1.0)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var noticeTitlelbl : UILabel = {
        var lbl : UILabel = UILabel.init()
        lbl.text = "这是一条公告~"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 13*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    @objc func clickedAcation(sender : UIButton){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.clickedAcation(sender:)))) != nil{
            delegate?.clickedAcation(sender: sender)
        }
    }
    
    @objc func walletAcation(){
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.walletAcation))) != nil{
            delegate?.walletAcation()
        }
    }
    
    func updateWalletInfo(){
        if let obj = userDefaults.object(forKey: WalletInfo){
            if obj is NSDictionary{
                walletNamelbl.text = (obj as! NSDictionary)[WalletName] as? String
                if let obj = (obj as! NSDictionary)[WalletBalance]{
                    let dic : NSDictionary = obj as! NSDictionary
                    allAssetslbl.text = String.init(format: "总资产:%@ sats", (dic[TotalBalance] as? String)!)
                }
            }
        }
    }
    
    func assignWalletInfo(balanceModel : BLWalletBalanceModel){
        if balanceModel.total_balance != nil{
            allAssetslbl.text = String.init(format: "总资产:%@ sats", balanceModel.total_balance!)
        }
    }
}
