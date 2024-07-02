//
//  BLCreatAssetsVC.swift
//  bitlong
//
//  Created by slc on 2024/5/7.
//

import UIKit

class BLCreatAssetsVC: BLBaseVC,CreatAssetsDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,ConfirmDelegate {
    
    var assetsImgData : Data?,assetsName = "",assetsTypeIndex = -1,assetsNum = 0,assetsReserve = 0,assetsMintNum = 0,assetsBegainDate = "",assetsEndDate = "",assetsLockTimeIndex = -1,assetsDescription = ""
    var logoImgView : UIImageView?
    var isNeedHideCell : Bool = false//项目方预留100需要隐藏下方cell项
    var rateModel : BLCreatAssetsRateModel?//费率
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalized(key: "castOnCreatNavTitle")
        self.navgationRightBtn(picStr: "", title: NSLocalized(key: "castOnCreatNavRightTitle"), titleColor: nil)
        
        self.initUI()
        self.getFeeQueryRate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func initUI(){
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
        
        self.tableView.register(BLCreatAssetLogoCell.self, forCellReuseIdentifier: BLCreatAssetLogoCellId)
        self.tableView.register(BLCreatAssetFieldCell.self, forCellReuseIdentifier: BLCreatAssetNameCellId)
        self.tableView.register(BLCreatAssetFieldCell.self, forCellReuseIdentifier: BLCreatAssetNumCellId)
        self.tableView.register(BLCreatAssetFieldCell.self, forCellReuseIdentifier: BLCreatAssetReserveCellId)
        self.tableView.register(BLCreatAssetFieldCell.self, forCellReuseIdentifier: BLCreatAssetMintNumCellId)
        self.tableView.register(BLCreatAssetDateCell.self, forCellReuseIdentifier: BLCreatAssetBegainDateCellId)
        self.tableView.register(BLCreatAssetDateCell.self, forCellReuseIdentifier: BLCreatAssetEndDateCellId)
        self.tableView.register(BLCreatAssetSwitchCell.self, forCellReuseIdentifier: BLCreatAssetTypeCellId)
        self.tableView.register(BLCreatAssetSwitchCell.self, forCellReuseIdentifier: BLCreatAssetLockoutTimeCellId)
        self.tableView.register(BLCreatAssetTextInputCell.self, forCellReuseIdentifier: BLCreatAssetTextInputCellId)
    }
    
    func getFeeQueryRate(){
        BLCastOnViewModel.getFeeQueryRate { [weak self] model in
            self?.rateModel = model
            
            if model.sat_per_b != nil{
                self?.tipLbl.text = NSLocalized(key: "castOnCreatIntroduceTips") + NSLocalized(key: "castOnCreatIntroduceRate") + model.sat_per_b!
            }
        } failed: { error in
        }
    }
    
    lazy var tipLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = NSLocalized(key: "castOnCreatIntroduceTips")
        lbl.textColor = UIColorHex(hex: 0xEC3468, a: 1.0)
        lbl.font = FONT_NORMAL(s: 12*Float(SCALE))
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var confirmView : BLCreatAssetsConfirmView = {
        var view = BLCreatAssetsConfirmView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        view.delegate = self
        
        return view
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return (SCREEN_WIDTH - 120*SCALE)/1.9 + 30*SCALE
        }else{
            if indexPath.section <= 4 {
                return 40*SCALE
            }else{
                if isNeedHideCell{
                    if indexPath.section == 9{
                        return (SCREEN_WIDTH - 80*SCALE)/2.2
                    }
                    
                    return 0.01
                }else{
                    if indexPath.section == 9{
                        return (SCREEN_WIDTH - 80*SCALE)/2.2
                    }
                    
                    return 40*SCALE
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : BLCreatAssetLogoCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetLogoCellId)! as! BLCreatAssetLogoCell
            cell.delegate = self
            logoImgView = cell.logoImgView
            cell.setCellType(type: .assetsLogo)
            
            return cell
        }else if indexPath.section == 1{
            let cell : BLCreatAssetFieldCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetNameCellId)! as! BLCreatAssetFieldCell
            cell.delegate = self
            cell.setCellType(type: .assetsName)
            
            return cell
        }else if indexPath.section == 2{
            let cell : BLCreatAssetSwitchCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetTypeCellId)! as! BLCreatAssetSwitchCell
            cell.delegate = self
            cell.setCellType(type: .assetsType)
            
            return cell
        }else if indexPath.section == 3{
            let cell : BLCreatAssetFieldCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetNumCellId)! as! BLCreatAssetFieldCell
            cell.delegate = self
            cell.setCellType(type: .assetsNum)
            
            return cell
        }else if indexPath.section == 4{
            let cell : BLCreatAssetFieldCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetReserveCellId)! as! BLCreatAssetFieldCell
            cell.delegate = self
            cell.setCellType(type: .assetsReserve)
            cell.setCellState(isHidden: false)
            
            return cell
        }else if indexPath.section == 5{
            let cell : BLCreatAssetFieldCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetMintNumCellId)! as! BLCreatAssetFieldCell
            cell.delegate = self
            cell.setCellType(type: .assetsMintNum)
            cell.setCellState(isHidden: isNeedHideCell)
            
            return cell
        }else if indexPath.section == 6{
            let cell : BLCreatAssetDateCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetBegainDateCellId)! as! BLCreatAssetDateCell
            cell.delegate = self
            cell.setCellType(type: .assetsBegainDate)
            cell.setCellState(isHidden: isNeedHideCell)
            
            return cell
        }else if indexPath.section == 7{
            let cell : BLCreatAssetDateCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetEndDateCellId)! as! BLCreatAssetDateCell
            cell.delegate = self
            cell.setCellType(type: .assetsEndDate)
            cell.setCellState(isHidden: isNeedHideCell)
            
            return cell
        }else if indexPath.section == 8{
            let cell : BLCreatAssetSwitchCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetLockoutTimeCellId)! as! BLCreatAssetSwitchCell
            cell.delegate = self
            cell.setCellType(type: .assetsLockoutTime)
            cell.setCellState(isHidden: isNeedHideCell)
            
            return cell
        }else{
            let cell : BLCreatAssetTextInputCell = tableView.dequeueReusableCell(withIdentifier: BLCreatAssetTextInputCellId)! as! BLCreatAssetTextInputCell
            cell.delegate = self
            cell.setCellType(type: .assetsDescription)

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }else if section == 1{
            return 16*SCALE
        }else if section == 9{
            return 22*SCALE
        }
        
        if 4 < section && section != 9{
            return isNeedHideCell ? 0.01 : 10*SCALE
        }
        
        return 10*SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 9{
            return 78*SCALE + SafeAreaBottomHeight + 50*SCALE
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 9{
            let footerView : UIView = UIView.init()
            let bt : UIButton = UIButton.init()
            bt.setTitle(NSLocalized(key: "castOnCreatIssue"), for: .normal)
            bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
            bt.titleLabel?.font = FONT_BOLD(s: 18*Float(SCALE))
            bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
            bt.layer.cornerRadius = 24*SCALE
            bt.clipsToBounds = true
            bt.addTarget(self, action: #selector(creatAssets), for: .touchUpInside)
            footerView.addSubview(tipLbl)
            footerView.addSubview(bt)
            
            tipLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.top.mas_equalTo()(13*SCALE)
                make?.left.mas_equalTo()(30*SCALE)
                make?.right.mas_equalTo()(-30*SCALE)
                make?.height.mas_equalTo()(30*SCALE)
            }
            
            bt.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.left.mas_equalTo()(24*SCALE)
                make?.top.mas_equalTo()(tipLbl.mas_bottom)?.offset()(25*SCALE)
                make?.bottom.mas_equalTo()(-SafeAreaBottomHeight - 15*SCALE)
                make?.right.mas_equalTo()(-24*SCALE)
            }
            
            return footerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func rightItemAcation() {
        self.pushBaseVCStr(vcStr: "BLAssetsSendHisVC", animated: true)
    }
    
    //CreatAssetsDelegate
    //获取logo
    func getLogoPicAcation() {
        actionSheet()
    }
    //名称
    func setAssetsName(name: String) {
        assetsName = name
    }
    //类别
    func setAssetsType(index: NSInteger) {
        assetsTypeIndex = index
    }
    //总量
    func setAssetsNum(num: NSInteger) {
        assetsNum = num
    }
    //项目方预留
    func setAssetsReserve(reserve: NSInteger) {
        assetsReserve = reserve
        
        if reserve == 100{
            if !isNeedHideCell{
                isNeedHideCell = true
                
                self.tableView.reloadData()
            }
        }else{
            if isNeedHideCell{
                isNeedHideCell = false
                
                self.tableView.reloadData()
            }
        }
    }
    //单份mint数量
    func setAssetsMintNum(num: NSInteger) {
        assetsMintNum = num
    }
    //开始日期
    func setAssetsBegainDate(date: Date) {
        assetsBegainDate = BLTools.getCurrentTimeStrWithData(timeData: date as NSDate)
    }
    //结束日期
    func setAssetsEndDate(date: Date) {
        assetsEndDate = BLTools.getCurrentTimeStrWithData(timeData: date as NSDate)
    }
    //锁仓时间
    func setAssetsLockTimeType(index: NSInteger) {
        assetsLockTimeIndex = index
    }
    //介绍
    func setAssetsDescription(description: String) {
        assetsDescription = description
    }
    
    //创建资产
    @objc func creatAssets(){
        let litstatus : LitStatus = BLTools.getLitStatus()
        if litstatus != .SERVER_ACTIVE{
            BLTools.showTost(tip: NSLocalized(key: "serverStatusSynchronizing"), superView: self.view)
            return
        }
        
        if assetsImgData == nil{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatLogoNil"), superView: self.view)
            return
        }
        if assetsName.count <= 0{
            BLTools.showTost(tip:  NSLocalized(key: "castOnCreatNameNil"), superView: self.view)
            return
        }
        if assetsTypeIndex < 0{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatTypeNil"), superView: self.view)
            return
        }
        if assetsNum <= 0{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatNumWrongful"), superView: self.view)
            return
        }
        if assetsReserve < 0 || 100 < assetsReserve{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatReserveWrongful"), superView: self.view)
            return
        }
        
        if assetsReserve < 100{
            if assetsMintNum <= 0{
                BLTools.showTost(tip: NSLocalized(key: "castOnCreatMinitNumWrongful"), superView: self.view)
                return
            }
            if assetsBegainDate.count <= 0{
                BLTools.showTost(tip: NSLocalized(key: "castOnCreatBeignDateNil"), superView: self.view)
                return
            }
            if assetsEndDate.count <= 0{
                BLTools.showTost(tip: NSLocalized(key: "castOnCreatEndDateNil"), superView: self.view)
                return
            }
//            if assetsLockTimeIndex < 0{
//                BLTools.showTost(tip: NSLocalized(key: "castOnCreatLocakTimeNil"), superView: self.view)
//                return
//            }
        }
        
        if 100 < assetsDescription.count{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatIntroduceLimit"), superView: self.view)
            return
        }
        
        if assetsReserve == 100{
            let meta : ApiMeta = ApiNewMeta(assetsDescription)!
            var myBool : ObjCBool = true
            guard ((try? meta.loadImage(byByte: assetsImgData, ret0_: &myBool)) != nil)else{
                BLTools.showTost(tip: "Image data is nil", superView: self.view)
                
                return
            }

            ApiMintAsset(assetsName, assetsTypeIndex == 1, meta, assetsNum, false)
            ApiFinalizeBatch(0)
        
            self.saveLocalDatas()
//            let listAssetsStr : String = ApiListAssets(false, false, false)
        }else{
            self.getFeeQueryRate()
            
            let token = userDefaults.object(forKey: Token)
            if token is String{
                let jsonStr : NSString = ApiGetIssuanceTransactionFee((token as! String)) as NSString
                let status : String = BLTools.getResaultStatus(jsonStr: jsonStr as String)
                if status == APISECCUSS{
                    let dic : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
                    let data : NSNumber = dic["data"] as! NSNumber
                    confirmView.assignTransactionFee(title: NSLocalized(key: "castOnCreatAssetsSendFee"), fee: data.stringValue)
                    
                    if confirmView.superview == nil{
                        self.view.addSubview(confirmView)
                        confirmView.mas_makeConstraints { (make : MASConstraintMaker?) in
                            make?.edges.equalTo()(self.view)
                        }
                        UIView.animate(withDuration: 0.3) { [weak self] in
                            self?.confirmView.alpha = 1.0
                        }
                    }
                }else{
                    BLTools.showTost(tip: status, superView: self.view)
                }
            }else{
                BLTools.showTost(tip: NSLocalized(key: "castOnCreatTokenWrongful"), superView: self.view)
            }
        }
    }
    
    func saveLocalDatas(){
        BLTools.showTost(tip: NSLocalized(key: "castOnCreatSeccused"), superView: self.view)
        
        let assetsList : NSMutableArray?
        if userDefaults.object(forKey: AssetsInfo) is NSArray{
            let list : NSArray = userDefaults.object(forKey: AssetsInfo) as! NSArray
            assetsList = NSMutableArray.init(array: list)
        }else{
            assetsList = NSMutableArray.init()
        }
        let assetsDic : NSMutableDictionary = NSMutableDictionary.init()
        assetsDic.setValue(assetsName, forKey: AssetsName)
        assetsDic.setValue(assetsNum, forKey: AssetsNum)
        assetsList!.add(assetsDic)
        userDefaults.set(assetsList, forKey: AssetsInfo)
        userDefaults.synchronize()
    }
    
    func actionSheet() {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        //相机
//        sourceType = UIImagePickerController.SourceType.camera
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true//true为拍照、选择完进入图片编辑模式
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: {
        })
    }
    
    //选择好照片后choose后执行的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.editedImage] as? UIImage {
            //处理选中的图片
            if logoImgView != nil{
                logoImgView?.image = chosenImage
                assetsImgData = chosenImage.jpegData(compressionQuality: 0.7)
            }
            
            picker.dismiss(animated: true, completion: nil)
        }else{
            BLTools.showTost(tip: NSLocalized(key: "castOnCreatPhotoWrongful"), superView: self.view)
        }
    }
    
    //cancel后执行的方法
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //ConfirmDelegate
    func confirmAcation() {
        let meta : ApiMeta = ApiNewMeta(assetsDescription)!
        var myBool : ObjCBool = true
        guard ((try? meta.loadImage(byByte: assetsImgData, ret0_: &myBool)) != nil)else{
            BLTools.showTost(tip: "Image data is nil", superView: self.view)
            return
        }
       
        
        let param : NSDictionary = ["image_data":meta.image_Data as Any,
                                    "name":assetsName,
                                    "asset_type":assetsTypeIndex,
                                    "amount":assetsNum,
                                    "reserved":assetsReserve,
                                    "mint_quantity":assetsMintNum,
                                    "start_time":Int64(assetsBegainDate) as Any,
                                    "end_time":Int64(assetsEndDate) as Any,
                                    "description":assetsDescription,
                                    "fee_rate":Int64(rateModel!.sat_per_kw!) as Any]
        BLCastOnViewModel.fairFaunchSet(param: param) { [weak self] resObj in
            let success : Int = resObj["success"] as! Int
            if success == 1{
                self?.saveLocalDatas()
            }else{
                let error = resObj["error"]
                BLTools.showTost(tip: (error ??  BLTools.showTost(tip: NSLocalized(key:"castOnCreatFailed"), superView: (self?.view)!)) as! String, superView: (self?.view)!)
            }
        } failed: { [weak self] error in
            BLTools.showTost(tip: error.msg, superView: (self?.view)!)
        }
    }
}
