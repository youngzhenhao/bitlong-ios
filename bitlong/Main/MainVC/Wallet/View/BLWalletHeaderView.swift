//
//  BLWalletHeaderView.swift
//  bitlong
//
//  Created by slc on 2024/5/8.
//

import UIKit

@objc protocol HeaderDelegate : NSObjectProtocol {
    func walletInfoAcation()
    func scanClicked()
    func persionalClicked()
    func walletDetailsClicked()
    func noticeClicked(list : [BLNoticeListItem]?)
}

class BLWalletHeaderView: BLBaseView,LMJVerticalScrollTextDelegate {
    
    @objc weak var delegate : HeaderDelegate?
    var noticeModel : BLNoticeModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(bgImgView)
        self.addSubview(walletBt)
        self.addSubview(scanBt)
        self.addSubview(personalBt)
        self.addSubview(walletNamelbl)
        self.addSubview(detailBt)
        self.addSubview(allAssetslbl)
        self.addSubview(bannerView)
        self.addSubview(noticeContainerView)
        noticeContainerView.addSubview(hornImgView)
        noticeContainerView.addSubview(noticeLinelbl)
        noticeContainerView.addSubview(scrollTextView)
        
        bgImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_equalTo()(120*SCALE)
        }
        
        walletBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(15*SCALE)
            make?.top.mas_equalTo()(StatusBarHeight+10*SCALE)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        scanBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(personalBt.mas_left)?.offset()(-15*SCALE)
            make?.top.mas_equalTo()(walletBt.mas_top)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        personalBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-15*SCALE)
            make?.top.mas_equalTo()(walletBt.mas_top)
            make?.width.height().mas_equalTo()(24*SCALE)
        }
        
        walletNamelbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(18*SCALE)
            make?.top.mas_equalTo()(walletBt.mas_bottom)?.offset()(20*SCALE)
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
            make?.height.mas_equalTo()((SCREEN_WIDTH-30*SCALE)/2.727)
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
            make?.left.mas_equalTo()(44*SCALE)
            make?.top.mas_equalTo()(8*SCALE)
            make?.bottom.mas_equalTo()(-8*SCALE)
            make?.width.mas_equalTo()(0.5*SCALE)
        }
        
        scrollTextView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(60*SCALE)
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
    
    lazy var walletBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_home_wallet"), for: .normal)
        bt.addTarget(self, action: #selector(clickedAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var scanBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_home_scan"), for: .normal)
        bt.addTarget(self, action: #selector(clickedAcation(sender:)), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var personalBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_home_personal"), for: .normal)
        bt.addTarget(self, action: #selector(clickedAcation(sender:)), for: .touchUpInside)
        
        return bt
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
        bt.setTitle(NSLocalized(key: "walletDetails"), for: .normal)
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
        lbl.text = NSLocalized(key: "walletTotalAssets") + ":0 " + NSLocalized(key: "walletAssetsCompany")
        lbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        lbl.font = FONT_BOLD(s: 20*Float(SCALE))
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    lazy var bannerView : BLBannerView = {
        var view = BLBannerView.init()
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
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
        lbl.backgroundColor = UIColorHex(hex: 0xA985FF, a: 1.0)
        
        return lbl
    }()
    
    lazy var scrollTextView : LMJVerticalScrollText = {
        var scroll = LMJVerticalScrollText.init()
        scroll.textStayTime        = 1
        scroll.scrollAnimationTime = 1
        scroll.textColor           = MainThemeColor()
        scroll.textFont            = FONT_BOLD(s: 11)
        scroll.textAlignment       = .left
        scroll.touchEnable         = true
        scroll.delegate = self
        
        return scroll
    }()
    
    @objc func clickedAcation(sender : UIButton){
        if sender == walletBt{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.walletInfoAcation))) != nil{
                delegate?.walletInfoAcation()
            }
        }else if sender == scanBt{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.scanClicked))) != nil{
                delegate?.scanClicked()
            }
        }else if sender == personalBt{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.persionalClicked))) != nil{
                delegate?.persionalClicked()
            }
        }else if sender == detailBt{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.walletDetailsClicked))) != nil{
                delegate?.walletDetailsClicked()
            }
        }
    }
    
    //LMJVerticalScrollTextDelegate
    func verticalScrollText(_ scrollText: LMJVerticalScrollText!, click index: Int, content: String!) {
        if noticeModel != nil && noticeModel?.list != nil{
            if delegate != nil && (delegate?.responds(to: #selector(delegate?.noticeClicked(list:)))) != nil{
                delegate?.noticeClicked(list: noticeModel?.list)
            }
        }
    }
    
    func updateWalletInfo(){
        if let obj = userDefaults.object(forKey: WalletInfo){
            if obj is NSDictionary{
                walletNamelbl.text = (obj as! NSDictionary)[WalletName] as? String
                if let obj = (obj as! NSDictionary)[WalletBalance]{
                    let dic : NSDictionary = obj as! NSDictionary
                    allAssetslbl.text = String.init(format: "%@:%@ %@",NSLocalized(key: "walletTotalAssets"), (dic[TotalBalance] as? String)!, NSLocalized(key: "walletAssetsCompany"))
                }
            }
        }
    }
    
    func assignWalletInfo(balanceModel : BLWalletBalanceModel){
        if balanceModel.total_balance != nil{
            allAssetslbl.text = String.init(format: "%@:%@ %@",NSLocalized(key: "walletTotalAssets"), balanceModel.total_balance!, NSLocalized(key: "walletAssetsCompany"))
        }
    }

    func assignBanner(imageArr : NSArray?){
        bannerView.assignBanner(imageArr: imageArr)
        
        if imageArr != nil && 0 < imageArr!.count{
            bannerView.mas_updateConstraints { (make : MASConstraintMaker?) in
                make?.height.mas_equalTo()((SCREEN_WIDTH-30*SCALE)/2.727)
            }
        }else{
            bannerView.mas_updateConstraints { (make : MASConstraintMaker?) in
                make?.height.mas_equalTo()(0)
            }
        }
    }
    
    func assignNotice(model : BLNoticeModel?,testsArr : NSArray?){
        noticeModel = model
        if testsArr != nil && 0 < testsArr!.count{
            scrollTextView.stopToEmpty()
            scrollTextView.textDataArr = (testsArr as! [Any])
            scrollTextView.startScrollBottomToTopWithNoSpace()
        }
    }
}
