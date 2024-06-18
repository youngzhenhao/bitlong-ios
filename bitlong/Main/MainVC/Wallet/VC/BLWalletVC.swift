//
//  BLWalletVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/6.
//

import UIKit

class BLWalletVC : BLBaseVC,HeaderDelegate,SegmentDelegate {
    var walletBalanceModel: BLWalletBalanceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        BLLoginManger.shared.login { token in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        headerView.updateWalletInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initUI(){
        self.view.addSubview(headerView)
        self.view.addSubview(segmentView)
        self.view.addSubview(scrollerView)
        
        headerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.left().right().mas_equalTo()(0)
            make?.height.mas_greaterThanOrEqualTo()(headerView.frame.height)
        }
        
        segmentView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(headerView.mas_bottom)?.offset()(8*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(50*SCALE)
        }
        
        scrollerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(segmentView.mas_bottom)?.offset()(0)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-TabBarHeight)
        }
        scrollerView.layoutIfNeeded()
        scrollerView.contentSize = CGSize.init(width: SCREEN_WIDTH*3, height: scrollerView.frame.height)
        
        scrollerView.addSubview(assetsListVC.view)
        scrollerView.addSubview(nftListVC.view)
        scrollerView.addSubview(channelListVC.view)

        assetsListVC.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: scrollerView.frame.height)
        nftListVC.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: scrollerView.frame.height)
        channelListVC.view.frame = CGRect(x: SCREEN_WIDTH*2, y: 0, width: SCREEN_WIDTH, height: scrollerView.frame.height)
    }
    
    override func loadData() {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        //获取钱包地址
        var address = userDefaults.value(forKey: WalletAddress)
        if address == nil{
            address = ApiGetNewAddress()
            userDefaults.setValue(address, forKey: WalletAddress)
            userDefaults.synchronize()
        }
//            print("WalletAddress:%@",address as Any);
        
        //获取钱包信息
        walletBalanceModel = BLWalletViewModel.getWalletBalance()
        headerView.assignWalletInfo(balanceModel:walletBalanceModel!)
        assetsListVC.assignWalletBalanceModel(model: walletBalanceModel!)
        assetsListVC.loadData()
        
        if let obj = userDefaults.object(forKey: WalletInfo){
            if obj is NSDictionary{
                let dic : NSMutableDictionary = NSMutableDictionary.init(dictionary: obj as! NSDictionary)
                let balanceDic : NSDictionary = [TotalBalance : walletBalanceModel?.total_balance ?? "0",
                                                 ConfirmedBalance : walletBalanceModel?.confirmed_balance ?? "0",
                                                 UnconfirmedBalance : walletBalanceModel?.unconfirmed_balance ?? "0",
                                                 LockedBalance : walletBalanceModel?.locked_balance ?? "0"]
                dic.setValue(balanceDic, forKey: WalletBalance)
                userDefaults.setValue(dic, forKey: WalletInfo)
                userDefaults.synchronize()
            }
        }
    }
    
    lazy var headerView : BLWalletHeaderView = {
        var view = BLWalletHeaderView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var segmentView : BLSegmentView = {
        var view = BLSegmentView.init()
        view.delegate = self
        
        return view
    }()
    
    lazy var scrollerView : UIScrollView = {
        var view = UIScrollView.init()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.delegate = self
        
        return view
    }()
    
    lazy var walletInfoView : BLWalletInfoView = {
        var view = BLWalletInfoView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        
        return view
    }()

    lazy var assetsListVC : BLAssetsListVC = {
        var vc = BLAssetsListVC.init()
        
        return vc
    }()
    
    lazy var nftListVC : BLNFTListVC = {
        var vc = BLNFTListVC.init()
        
        return vc
    }()
    
    lazy var channelListVC : BLChannelListVC = {
        var vc = BLChannelListVC.init()
        
        return vc
    }()
    
    //HeaderDelegate
    func clickedAcation(sender: UIButton) {
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: "LND正在同步中...", superView: self.view)
            return
        }
        
        let walletDetailVC : BLWalletDetailVC = BLWalletDetailVC.init()
        walletDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(walletDetailVC, animated: true)
    }
    
    func walletAcation() {
        if walletInfoView.superview == nil{
            appDelegate.window.addSubview(walletInfoView)
            walletInfoView.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.left().right().bottom().mas_equalTo()(0)
            }
        }
    }
    
    //SegmentDelegate
    func segmentAcation(sender: UIButton) {
        switch sender.tag {
        case 100://资产
            scrollerView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            break
        case 101://NFT
            scrollerView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH, y: 0), animated: false)
            break
        case 102://通道
            scrollerView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH*2, y: 0), animated: false)
            channelListVC.loadQueryBalance()
            break
        case 103:
            self.pushBaseVCStr(vcStr: "BLImportAssetsVC", animated: true)
            break
        default:
            break
        }
    }
    
    //UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x : CGFloat = scrollView.contentOffset.x
        let index : Int = Int(x/SCREEN_WIDTH)
        segmentView.setSelectedIndex(index: index)
        
        if index == 2{
            channelListVC.loadQueryBalance()
        }
    }
    
    override func `deinit`() {
        super.`deinit`()
    }
}
