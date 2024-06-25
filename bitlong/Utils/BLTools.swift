//
//  BLTools.swift
//  bitlong
//
//  Created by 微链通 on 2024/4/28.
//

import UIKit
import Foundation

let tostViewTag = 10000000001
let KEY_DEVICEID = "KEY_DEVICEID"
let KEY_IN_KEYCHAIN = "KEY_IN_KEYCHAIN"

open class BLTools: NSObject {
    
    static let shared = BLTools()
    
    @objc static func getEnvironmentalConfig() -> String{
#if DEBUG
        return "regtest" //私链
#else
        return "mainnet" //主网
#endif
    }
    
    //获取当前屏幕显示的viewcontroller
    @objc static func getCurrentVC() -> UIViewController{
        //获得当前活动窗口的根视图
        var vc = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
        if vc == nil{
            vc = appDelegate.window.rootViewController
        }
        let currentShowingVC : UIViewController = self.findCurrentShowingViewControllerFrom(vc: vc!)
        
        return currentShowingVC
    }
    
    static func findCurrentShowingViewControllerFrom(vc : UIViewController) -> UIViewController{
        var currentShowingVC : UIViewController?
        if let pVc = vc.presentedViewController{
            // 当前视图是被presented出来的
            let nextRootVC : UIViewController = pVc
            currentShowingVC = self.findCurrentShowingViewControllerFrom(vc: nextRootVC)
        }else if vc is UITabBarController{
            //根视图为UITabBarController
            let tabBarVC : UITabBarController = vc as! UITabBarController
            let nextRootVC : UIViewController = tabBarVC.selectedViewController!
            currentShowingVC = self.findCurrentShowingViewControllerFrom(vc: nextRootVC)
        }else if vc is UINavigationController{
            // 根视图为UINavigationController
            let navBarVC : UINavigationController = vc as! UINavigationController
            let nextRootVC : UIViewController = navBarVC.visibleViewController!
            currentShowingVC = self.findCurrentShowingViewControllerFrom(vc: nextRootVC)
        }else{
            // 根视图为非导航类
            currentShowingVC = vc
        }
        
        return currentShowingVC!
    }
    
    //获取lit服务状态
    static func getLitStatus() -> LitStatus{
        let status : String = ApiGetState()
        if (status == LitStatus.WAITING_TO_START.rawValue) {//节点正在等待成为集群的领导者，尚未启动。
            return LitStatus.WAITING_TO_START
        }else if (status ==  LitStatus.NON_EXISTING.rawValue) {//钱包尚未初始化。
            return LitStatus.NON_EXISTING
        }else if (status == LitStatus.LOCKED.rawValue) {//钱包已锁定。
            return LitStatus.LOCKED
        }else if (status == LitStatus.UNLOCKED.rawValue) {//钱包已成功解锁，但 RPC 服务器尚未就绪。
            return LitStatus.UNLOCKED
        }else if (status == LitStatus.RPC_ACTIVE.rawValue) {//RPC 服务器处于活动状态，但尚未完全准备好接受调用
            return LitStatus.RPC_ACTIVE
        }else if (status == LitStatus.SERVER_ACTIVE.rawValue){//RPC 服务器处于活动状态，但尚未完全准备好接受调用
            return LitStatus.SERVER_ACTIVE
        }else if (status == LitStatus.NO_START_LND.rawValue){//LND服务挂了，请重新启动服务
            return LitStatus.NO_START_LND
        }
        
        return LitStatus.UNKNOW
    }
    
    static func getStatusDes(status : LitStatus) -> String{
        if (status == LitStatus.WAITING_TO_START) {
            return "节点正在等待成为集群的领导者，尚未启动"
        }else if (status ==  LitStatus.NON_EXISTING) {
            return "钱包尚未初始化"
        }else if (status == LitStatus.LOCKED) {
            return "钱包已锁定"
        }else if (status == LitStatus.UNLOCKED) {
            return "钱包已成功解锁，但RPC服务器尚未就绪"
        }else if (status == LitStatus.RPC_ACTIVE) {
            return "RPC服务器处于活动状态，但尚未完全准备好接受调用"
        }else if status == LitStatus.SERVER_ACTIVE{
            return "RPC服务器可用并准备好接受调用"
        }
        
        return "服务状态未知"
    }
    
    static func haveDynamicIsland() -> Bool{
        var isHave : Bool = false
        if #available(iOS 16.0, *){
            isHave = 51 <= (UIApplication.shared.delegate?.window?!.safeAreaInsets.top)!
        }
        
        return isHave
    }
    
    static func textHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        let textRect = NSString(string: text).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil)
        
        return textRect.height
    }
    
    static func textWidth(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        let textRect = NSString(string: text).boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: height),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil)
        
        return textRect.width
    }
    
    /*
     HUD
     */
    @objc static func showLoading(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    @objc static func showLoading(status : String){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: status)
    }
    
    //显示消息图标和状态
    @objc static func showInfo(status : String){
        SVProgressHUD.showInfo(withStatus: status)
    }

    //显示成功图标和状态
    @objc static func showSucces(status : String){
        SVProgressHUD.showSuccess(withStatus: status)
    }

    //显示错误图标和状态
    @objc static func showError(status : String){
        SVProgressHUD.showError(withStatus: status)
    }
    
    //显示自定义图标和状态
    @objc static func showImage(image : UIImage,status : String){
        SVProgressHUD.show(image, status: status)
    }
    
    //显示自定义进度和状态
    @objc static func showProgress(progress : Float, status : String){
        SVProgressHUD.showProgress(progress, status: status)
    }
    
    @objc static func hideLoading(){
        SVProgressHUD.dismiss()
    }
    
    @objc static func showTost(tip : String,superView : UIView){
        if superView.viewWithTag(tostViewTag) != nil && superView.viewWithTag(tostViewTag)?.superview != nil{
            return
        }
        
        let tostView : UIView = UIView.init()
        tostView.backgroundColor = UIColorHex(hex: 0x000000, a: 0.7)
        tostView.layer.cornerRadius = 6*SCALE
        tostView.clipsToBounds = true
        tostView.tag = tostViewTag
        superView.addSubview(tostView)
        
        let tipLbl : UILabel = UILabel.init()
        tipLbl.text = tip
        tipLbl.textColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        tipLbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        tipLbl.textAlignment = .center
        tipLbl.numberOfLines = 0
        tostView.addSubview(tipLbl)
        
        let width : CGFloat = BLTools.textWidth(text: tip, font: tipLbl.font, height: 14*SCALE)
        var height : CGFloat = BLTools.textHeight(text: tip, font: tipLbl.font, width: width)
        var bottom : CGFloat = SafeAreaBottomHeight + 20*SCALE
        if BLTools.getCurrentVC() is BLWalletVC || BLTools.getCurrentVC() is BLCastOnOutWellVC
            || BLTools.getCurrentVC() is BLTransactionVC || BLTools.getCurrentVC() is BLToolVC
            || BLTools.getCurrentVC() is BLNostrVC{
            bottom = SafeAreaBottomHeight + 20*SCALE + TabBarHeight
        }
        
        if width <= SCREEN_WIDTH-74*SCALE{
            tostView.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.bottom.mas_equalTo()(-bottom)
                make?.centerX.mas_equalTo()(0)
                make?.width.mas_equalTo()(width+44*SCALE)
                make?.height.mas_equalTo()(height+26*SCALE)
            }
        }else{
            height = BLTools.textHeight(text: tip, font: tipLbl.font, width: SCREEN_WIDTH-74*SCALE)
            tostView.mas_makeConstraints { (make : MASConstraintMaker?) in
                make?.bottom.mas_equalTo()(-bottom)
                make?.centerX.mas_equalTo()(0)
                make?.width.mas_equalTo()(SCREEN_WIDTH-30*SCALE)
                make?.height.mas_equalTo()(height+26*SCALE)
            }
        }
        
        tipLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.top.mas_equalTo()(5*SCALE)
            make?.bottom.mas_equalTo()(-5*SCALE)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.3) {
                tostView.alpha = 0
            }completion: { finished in
                tostView.removeFromSuperview()
            }
        }
    }
    
    static func getProcessID() -> Int32{
        let processInfo : ProcessInfo = ProcessInfo.processInfo
        let processID : pid_t = processInfo.processIdentifier
        
        return processID
    }
    
    //背景渐变色
    static func topColorChange(view : UIView?,colorBegin : UIColor?,colorEnd : UIColor?,direction : CGFloat?){
        if view != nil && view?.superview != nil{
            view?.layoutIfNeeded()
            view?.superview?.layoutIfNeeded()
            
            BLTools.removeCAGradientLayer(view: view)
            
            if colorBegin != nil && colorEnd != nil{
                let gradientLayer : CAGradientLayer = CAGradientLayer.init()
                gradientLayer.frame = view!.bounds
                gradientLayer.colors = [colorBegin?.cgColor as Any,colorEnd?.cgColor as Any]
                if direction == 0{//纵向渐变
                    gradientLayer.startPoint = CGPointMake(0, 0)
                    gradientLayer.endPoint = CGPointMake(0, 1)
                }else{//横向渐变
                    gradientLayer.startPoint = CGPointMake(0, 0)
                    gradientLayer.endPoint = CGPointMake(1, 0)
                }
                gradientLayer.locations = [0,1]
                view!.layer.insertSublayer(gradientLayer, at: 0)
            }
        }
    }
    
    static func removeCAGradientLayer(view : UIView?){
        if view != nil && view?.layer.sublayers != nil && 0 < (view?.layer.sublayers!.count)! {
            for i in 0..<(view?.layer.sublayers!.count)!{
                if view!.layer.sublayers![i] is CAGradientLayer {
                    view!.layer.sublayers![i].removeFromSuperlayer()
                }
            }
        }
    }
    
    static func pasteGeneral(string : Any){
        if string is String{
            let str : String = string as! String
            if 0 < str.count{
                UIPasteboard.general.string = (string as! String)
                BLTools.showTost(tip: "已复制到粘贴板", superView: self.getCurrentVC().view)
            }else{
                BLTools.showTost(tip: "内容不存在，无法复制到粘贴板", superView: self.getCurrentVC().view)
            }
        }else{
            BLTools.showTost(tip: "内容不合法，无法复制到粘贴板", superView: self.getCurrentVC().view)
        }
    }
    
    static func getPasteGeneralString() -> String{
        if let pasteboardString = UIPasteboard.general.string {
            return pasteboardString
        } else {
            return ""
        }
    }
    
    //生成二维码
    static func generateQRCode(for string: String) -> UIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        //设置生成的二维码的容错率 "L/M/Q/H"
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        let inputData = string.data(using: .utf8)
        filter?.setValue(inputData, forKey: "inputMessage")
        
        //获取输出的图片
        guard let outImage = filter?.outputImage else { return UIImage() }
        //获取高清图片
        let hdImage = getHDImage(outImage)
        
        return hdImage
    }
    
    //获取高清图片
    static func getHDImage(_ outImage: CIImage) -> UIImage {
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        //放大图片
        let ciImage = outImage.transformed(by: transform)
        
        return UIImage(ciImage: ciImage)
    }
    
    //检测对象是否合法
    static func isAvailableWithObj(obj : Any) -> Bool{
        if !(obj is NSNull){
            if obj is String{
                let str : String = obj as! String
                if str != "(null)" && str != "<null>"{
                    return true
                }
                
                return false
            }
            
            return true
        }
        
        return false
    }
    
    static func getResaultStatus(jsonStr : String) -> String{
        if BLTools.isAvailableWithObj(obj: jsonStr){
            let obj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
            let code = obj["code"]
            if code != nil{
                let status : Int32 = code as! Int32
                if status == 200{
                    return APISECCUSS
                }
            }
            
            let error = obj["error"]
            if error != nil && error is String{
                return error as! String
            }
        }
        
        return "未知错误"
    }
    
    //日期选择器
    func getPickerView() -> BLUIDatePickerView{
        return pickerView
    }
    
    lazy var pickerView : BLUIDatePickerView = {
        var view = BLUIDatePickerView.init()
        view.backgroundColor = UIColorHex(hex: 0x000000, a: 0.5)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    static func getHdDeviceid() -> String{
        let deviceId = BLTools.readKeyChainObjectWithKey(key: KEY_DEVICEID)
        if deviceId is String && 0 < (deviceId as! String).count{
            return deviceId as! String
        }
        
        let uuid : String = BLTools.getUUID()
        BLTools.saveKeyChainWithObject(obj: uuid, key: KEY_DEVICEID)
        
        return uuid
    }
    
    static func getUUID() -> String {
        let uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil,uuidRef)
        return uuidStringRef! as String
    }
    
    static func nSKeyedArchiver(archData : Any,secureCoding : Bool, path : String) -> Bool{
        do{
            let data : NSData = try NSKeyedArchiver.archivedData(withRootObject: archData, requiringSecureCoding: secureCoding) as NSData
            return data.write(toFile: path, atomically: true)
        }catch{
            NSSLog(msg: "nSKeyedArchiver error")
            return false
        }
    }
    
    static func nSKeyedUnarchiverPath(path : String) -> Any{
        if 0 < path.count{
            do{
                let unData = NSData.init(contentsOfFile: path)
                if unData != nil {
                    return NSKeyedUnarchiver.unarchiveObject(with: unData! as Data) as Any
                }else{
                    return NSError.init(domain: "data is nil", code: -1)
                }
            }
        }else{
            return NSError.init(domain: "path is error", code: -1)
        }
    }
    
    static func saveKeyChainWithObject(obj : String,key : String){
        let kvPairs : NSMutableDictionary = NSMutableDictionary.init()
        kvPairs.setObject(obj, forKey: key as NSCopying)
        BLKeychain.save(KEY_IN_KEYCHAIN, data: kvPairs)
    }
    
    static func readKeyChainObjectWithKey(key : String) -> Any{
        let kvPairs = BLKeychain.load(KEY_IN_KEYCHAIN, class: NSDictionary.self)
        if kvPairs is NSDictionary{
            return (kvPairs as! NSDictionary).object(forKey: key) as Any
        }
        
        return ""
    }
    
    static func deleteKeyChainObjectWithKey(key : String){
        let kvPairs : NSMutableDictionary = NSMutableDictionary.init(dictionary: BLKeychain.load(KEY_IN_KEYCHAIN, class: NSDictionary.self) as! NSDictionary)
        let containsTarget = kvPairs.allKeys.contains { element in
            if key == element as! String {
                return true
            }
            
            return false
        }
        if containsTarget{
            kvPairs.removeObject(forKey: key)
        }
        
        BLKeychain.save(KEY_IN_KEYCHAIN, data: kvPairs)
    }
    
    static func deleteKeyChain(){
        BLKeychain.delete(KEY_IN_KEYCHAIN)
    }
    
    static func getGenSeed() -> String{
        let genSend = userDefaults.object(forKey: GenSeed)
        if genSend != nil && genSend is String{
            let genSendStr : NSString = genSend as! NSString
            let arr : NSArray = genSendStr.components(separatedBy: ",") as NSArray
            let resStr : NSMutableString = NSMutableString.init()
            for i in 0..<arr.count{
                if i != 0{
                    resStr.append(" ")
                }
                resStr.append(arr[i] as! String)
            }
            
            return resStr as String
        }else{
            return ""
        }
    }
    
    static func addressType(address : String) -> AddressType{
        if 4 < address.count{
            let prefix = address.prefix(4)
            if prefix == "bcrt"{//btc
                return .addressBTC
            }else if prefix == "tapr"{
                return .addressAssets
            }else if prefix == "lnbc"{
                return .addressInvoice
            }
        }
        
        BLTools.showTost(tip: "地址类型未知！", superView: appDelegate.window)
        return .addresNone
    }
    
    //获取系统时间戳
    static func getCurrentTimeStr() -> String{
        let currentDate : Date = Date.init()
        let time : TimeInterval = currentDate.timeIntervalSince1970
        let timeString : String = String.init(format: "%.0f", time)
        
        return timeString
    }

    //获取系统时间戳-毫秒
    static func getCurrentMillisecondTimeStr() -> String{
        let currentDate : Date = Date()
        let time : TimeInterval = currentDate.timeIntervalSince1970
        let timeString : String = String.init(format: "%.0f", time * 1000)
        
        return timeString
    }

    //根据data获取时间戳
    static func getCurrentTimeStrWithData(timeData : NSDate) -> String{
        let time : TimeInterval = timeData.timeIntervalSince1970
        let timeString : String = String.init(format: "%.0f", time)
        
        return timeString
    }

    //根据时间戳 格式转化(formatStr 格式类型 如:yyyy-MM-dd HH:mm:ss)
    static func getFormaterWithTimeStr(timeStr : NSString,formatStr : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        let date : Date = Date(timeIntervalSince1970: TimeInterval(timeStr.integerValue))
        let dateString : String = formatter.string(from: date)
        
        return dateString
    }

    //获取格式转化(formatStr 格式类型 如:yyyy-MM-dd HH:mm:ss)
    static func getFormater(date : Date?,formatStr : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        var currentDate = date
        if currentDate == nil{
            currentDate = Date()
        }
        let dateString : String = formatter.string(from: currentDate!)
        
        return dateString
    }
    
    static func saveFile(dateDic : NSDictionary, filePath : String){
//        let manager : FileManager = FileManager.default
        if dateDic.write(toFile: filePath, atomically: true){
            let readDic : NSDictionary = NSDictionary.init(contentsOfFile: filePath)!
            NSSLog(msg: String.init(format: "icon写入文件成功%@",readDic))
        }else{
            NSSLog(msg: "icon写入文件失败")
        }
    }
    
    static func readFile(filePath : String) -> NSDictionary?{
        let manager : FileManager = FileManager.default
        if manager.fileExists(atPath: filePath){
            let readDic : NSDictionary = NSDictionary.init(contentsOfFile: filePath)!
            return readDic
        }else{
            return nil
        }
    }
    
    /*
     assetId 资产id，当isImageData = true时，assetId值为isImageData字符串
     isImageData 是否是根据isImageData获取图片资源
     */
    static func getAssetIconImg(assetId : String, isImageData : Bool) -> UIImage?{
        let obj = BLTools.nSKeyedUnarchiverPath(path: KNSDocumentPath(name: Key_AssetsIcon))
        var imgData : Data?
        if obj is NSDictionary{
            let dic : NSDictionary = obj as! NSDictionary
            let data = dic[assetId as Any]
            if data is Data{
                imgData = data as? Data
            }else{
                imgData = BLTools.setAssetIconMeta(assetId: assetId, isImageData: isImageData)
            }
        }else{
            imgData = BLTools.setAssetIconMeta(assetId: assetId, isImageData: isImageData)
        }
        
        if imgData != nil{
            return UIImage.init(data:imgData!)
        }else{
            return nil
        }
    }
    
    static func setAssetIconMeta(assetId : String, isImageData : Bool) -> Data?{
        let meta : ApiMeta = ApiMeta.init(nil)!
        if isImageData{
            meta.image_Data = assetId
        }else{
            meta.fetchAssetMeta(false, data: assetId)
        }
        let data = meta.getImage()
        if data != nil{
            var dic : NSMutableDictionary?
            let obj = BLTools.nSKeyedUnarchiverPath(path: KNSDocumentPath(name: Key_AssetsIcon))
            if obj is NSDictionary{
                dic = NSMutableDictionary.init(dictionary: obj as! NSDictionary)
            }else{
                dic = NSMutableDictionary.init()
            }
            dic!.setValue(data, forKey: assetId)
            if BLTools.nSKeyedArchiver(archData: dic as Any, secureCoding: true, path: KNSDocumentPath(name: Key_AssetsIcon)){
                
            }
            
            return data
        }else{
           return nil
        }
    }
    
    static func showAlterWith(title : String, msg : String, cancelTitle : String, confirmTitle : String, callBack : (() -> ())) {
        let alterController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancelBt = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
        }
        let confirmBt = UIAlertAction(title: confirmTitle, style: UIAlertAction.Style.destructive) { (UIAlertAction) -> Void in
            
        }

        alterController.addAction(cancelBt)
        alterController.addAction(confirmBt)

        BLTools.getCurrentVC().present(alterController, animated: true, completion: nil)
    }
    
    //正则表达式校验
    static func checkRegular(regex : String,value : String) -> Bool{
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
           
        return predicate.evaluate(with:value)
    }
    
    //获取应用版本号
    static func getAppVersion() -> String{
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        
        return ""
    }
}
