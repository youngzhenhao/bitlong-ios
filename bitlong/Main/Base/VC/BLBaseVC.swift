//
//  BLBaseVC.swift
//  bitlong
//
//  Created by slc on 2024/4/28.
//

import UIKit

class BLBaseVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,JXCategoryListCollectionContentViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setNavTitlNormal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBar(isHidden: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func listView() -> UIView! {
        return self.view
    }
    
    func listDidAppear() {
    }
    
    func listDidDisappear() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func setNavigationBar(isHidden : Bool){
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    
    func setNavTitlNormal(){
        self.navgationLeftBtn(picStr: "ic_back_black")
        let bgColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        self.setNavTitleColor(titleColor: UIColorHex(hex: 0x383838, a: 1.0), bgColor: bgColor, bgImage: nil)
    }
    
    @objc lazy var tableView : UITableView = {
        var table = UITableView.init(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.estimatedRowHeight = 0
        
        table.bounces = true
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none;
        
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        }
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getButton(title : String,titleColor : UIColor,titleFont : UIFont,backColor : UIColor, radius : CGFloat) -> UIButton {
        let bt : UIButton = UIButton.init()
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(titleColor, for: .normal)
        bt.titleLabel?.font = titleFont
        bt.backgroundColor = backColor
        if 0 < radius {
            bt.layer.cornerRadius = radius
            bt.clipsToBounds = true
        }
        
        bt.addTarget(self, action: #selector(buttonAcation(sender:)), for: .touchUpInside)
        
        return bt
    }
    
    @objc func buttonAcation(sender : UIButton){
        
    }
    
    func setNavTitleColor(titleColor : UIColor, bgColor : UIColor?, bgImage : UIImage?){
        var nav : UINavigationController?
        if self.navigationController != nil{
            nav = self.navigationController
        }else{
            nav = BLTools.getCurrentVC().navigationController
        }
        if nav == nil{
            nav = UINavigationController.init(rootViewController: BLTools.getCurrentVC())
        }
        
        let attrs : NSMutableDictionary = NSMutableDictionary.init()
        attrs[NSAttributedString.Key.font] = FONT_BOLD(s: 17*Float(SCALE))
        attrs[NSAttributedString.Key.foregroundColor] = titleColor
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            if bgColor != nil{
                appearance.backgroundColor = bgColor
            }
            if bgImage != nil{
                appearance.backgroundImage = bgImage
            }
            // 去掉半透明效果
            appearance.backgroundEffect = nil
            // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = attrs as! [NSAttributedString.Key : Any]
            // 带scroll滑动的页面
            nav!.navigationBar.scrollEdgeAppearance = appearance
            // 常规页面
            nav!.navigationBar.standardAppearance = appearance
        }else{
            nav!.navigationBar.setBackgroundImage(bgImage, for: .default)
            nav!.navigationBar.titleTextAttributes = (attrs as! [NSAttributedString.Key : Any])
        }
    }
    
    @objc func navgationLeftBtn(picStr : String){
        let leftButton : UIButton = UIButton.init()
        let normalImage : UIImage?
        if picStr.count <= 0{
            normalImage = imagePic(name: "ic_back_black")
        }else{
            normalImage = imagePic(name: picStr)
        }
        leftButton.setImage(normalImage, for: .normal)
        leftButton.isExclusiveTouch = true
        leftButton.adjustsImageWhenHighlighted = false
        leftButton.widthAnchor.constraint(equalToConstant: 24 * SCALE).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 24 * SCALE).isActive = true
        leftButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        let leftBarItem : UIBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.setLeftBarButton(leftBarItem, animated: true)
    }
     
    @objc func navgationRightBtn(picStr : String, title : String, titleColor : UIColor?){
        let rightButton : UIButton = UIButton.init()
        if 0 < picStr.count{
            rightButton.setImage(imagePic(name: picStr), for: .normal)
        }else if 0 < title.count{
            rightButton.setTitle(title, for: .normal)
            if titleColor != nil{
                rightButton.setTitleColor(titleColor, for: .normal)
            }else{
                rightButton.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
            }
            rightButton.titleLabel?.font = FONT_NORMAL(s: 12*Float(SCALE))
        }
        rightButton.isExclusiveTouch = true
        rightButton.adjustsImageWhenHighlighted = false
//        rightButton.widthAnchor.constraint(equalToConstant: 24 * SCALE).isActive = true
//        rightButton.heightAnchor.constraint(equalToConstant: 24 * SCALE).isActive = true
        rightButton.addTarget(self, action: #selector(rightItemAcation), for: .touchUpInside)
        let rightBarItem : UIBarButtonItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    
    @objc func addNavBarView(title : String,tColor : UIColor,tFont : UIFont,bColor : UIColor?,bImg : UIImage?,leftButton : UIButton?,rightButton : UIButton?) -> UIView{
        // 移除所有子视图
        navBarView.removeAllSubviews()
        
        let bgImgView : UIImageView = UIImageView.init(frame: navBarView.frame)
        navBarView.addSubview(bgImgView)
        if bColor != nil{
            bgImgView.backgroundColor = bColor
        }
        
        if bImg != nil {
            bgImgView.image = bImg
        }
        
        let navBarWidth : CGFloat = CGRectGetWidth(navBarView.frame)
        let navBarHeight : CGFloat = CGRectGetHeight(navBarView.frame)
        let deviceHeight : CGFloat = isipad() ? 44*SCALE : 22*SCALE
        let deviceWidth : CGFloat = isipad() ? 160*SCALE : 80*SCALE
        let topSpecing : CGFloat = navBarHeight - StatusBarHeight - deviceHeight
        let titleLbl : UILabel = UILabel.init(frame: CGRect(x: (navBarWidth - deviceWidth)/2, y: StatusBarHeight + topSpecing/2, width: deviceWidth, height: deviceHeight))
        titleLbl.text = title
        titleLbl.textAlignment = .center
        titleLbl.textColor = tColor
        titleLbl.font = tFont
        navBarView.addSubview(titleLbl)
        
        let deviceSpceing : CGFloat = isipad() ? 30*SCALE : 15*SCALE
        if leftButton != nil{
            navBarView.addSubview(leftButton!)
            leftButton?.frame = CGRect.init(x: deviceSpceing, y: StatusBarHeight + (navBarHeight - StatusBarHeight)/2 - CGRectGetHeight(leftButton!.frame)/2, width: CGRectGetWidth(leftButton!.frame), height: CGRectGetHeight(leftButton!.frame))
            leftButton?.addTarget(self, action: #selector(back), for: .touchUpInside)
        }

        if rightButton != nil{
            navBarView.addSubview(rightButton!)
            rightButton?.frame = CGRect.init(x: navBarWidth - deviceSpceing - CGRectGetWidth(rightButton!.frame), y: StatusBarHeight + (navBarHeight - StatusBarHeight)/2 - CGRectGetHeight(rightButton!.frame)/2, width: CGRectGetWidth(rightButton!.frame), height: CGRectGetHeight(rightButton!.frame))
            rightButton?.addTarget(self, action: #selector(rightItemAcation), for: .touchUpInside)
        }
        
        self.view.addSubview(navBarView)
        
        return navBarView
    }
    
    lazy var navBarView : UIView = {
        var view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: TopHeight))
        
        return view
    }()
    
    lazy var noDataView : UIImageView = {
        var imgView = UIImageView.init(image: imagePic(name: "ic_noData_img"))
        
        return imgView
    }()
    
    lazy var gifHeader : MJRefreshGifHeader = {
        var header = MJRefreshGifHeader.init(refreshingTarget: self, refreshingAction: #selector(loadData))
        header.lastUpdatedTimeLabel?.isHidden = true
        header.setTitle("下拉刷新~", for: .idle)
        header.setTitle("松开刷新~", for: .pulling)
        header.setTitle("正在刷新中..", for: .refreshing)
        // 设置字体大小
        header.stateLabel?.font = FONT_NORMAL(s: 12*Float(SCALE))
        // 设置字体颜色
        header.stateLabel?.textColor = UIColorHex(hex: 0x666666, a: 1.0)
        
        return header
    }()
    
    
    lazy var gifFooter : MJRefreshAutoGifFooter = {
        var footer = MJRefreshAutoGifFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        footer.setTitle("下拉刷新~", for: .idle)
        footer.setTitle("松开刷新~", for: .pulling)
        footer.setTitle("正在刷新中..", for: .refreshing)
        footer.setTitle("到底啦~", for: .noMoreData)
        // 设置字体大小
        footer.stateLabel?.font = FONT_NORMAL(s: 12*Float(SCALE))
        // 设置字体颜色
        footer.stateLabel?.textColor = UIColorHex(hex: 0x666666, a: 1.0)
        
        return footer
    }()
    
    @objc func loadData(){
        
    }
    
    @objc func loadMoreData(){
        
    }
    
    func pushBaseVC(vc : UIViewController,animated : Bool){
        if BLTools.getCurrentVC() != vc{
            var nav : UINavigationController?
            if self.navigationController != nil{
                nav = self.navigationController
            }else{
                nav = BLTools.getCurrentVC().navigationController
            }
            if nav == nil{
                nav = UINavigationController.init(rootViewController: BLTools.getCurrentVC())
            }
            
            vc.hidesBottomBarWhenPushed = true
            nav?.pushViewController(vc, animated: animated)
        }
    }
    
    func pushBaseVCStr(vcStr : String,animated : Bool){
        if vcStr.count <= 0{
            BLTools.showTost(tip: "页面错误", superView: appDelegate.window)
            return
        }
        
        var classStr : String = vcStr
        if NSClassFromString(vcStr) == nil{//兼容swift
            classStr = String.init(format: "bitlong.%@", vcStr)
            if NSClassFromString(classStr) == nil{
                BLTools.showTost(tip: "页面错误", superView: appDelegate.window)
                return
            }
        }
        
        if !(BLTools.getCurrentVC() .isKind(of: NSClassFromString(classStr)!)){
            var nav : UINavigationController?
            if self.navigationController != nil{
                nav = self.navigationController
            }else{
                nav = BLTools.getCurrentVC().navigationController
            }
            if nav == nil{
                nav = UINavigationController.init(rootViewController: BLTools.getCurrentVC())
            }
            
            let vc : UIViewController = BLRout.routVC(pageStr: classStr)
            vc.hidesBottomBarWhenPushed = true
            nav?.pushViewController(vc, animated: animated)
        }
    }
    
    @objc func back(){
        var nav : UINavigationController?
        if self.navigationController != nil{
            nav = self.navigationController
        }else{
            nav = BLTools.getCurrentVC().navigationController
        }
        if nav == nil{
            nav = UINavigationController.init(rootViewController: BLTools.getCurrentVC())
        }
        
        nav?.popViewController(animated: true)
    }
    
    @objc func rightItemAcation(){
        
    }
    
    func addNoDataView(superView : UIView, isBig : Bool){
        let height : CGFloat = (isBig ? 150*SCALE : 80*SCALE)
        if noDataView.superview == nil{
            superView.addSubview(noDataView)
            noDataView.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.width.mas_equalTo()(height*0.958)
                make?.height.mas_equalTo()(height)
                make?.center.mas_equalTo()(0)
            }
        }
    }
    
    func removeNoDataView(){
        noDataView.removeFromSuperview()
    }
    
    func dealErrorMsg(jsonStr : NSString){
        let _ : NSString = ""
    }
    
    deinit {
        NSSLog(msg: String.init(format: "deinit\n控制器-%@- had deinited！",NSStringFromClass(object_getClass(self)!)))
    }
}


