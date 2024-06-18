//
//  BLLoginManger.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/4.
//

import UIKit

@objcMembers class BLLoginManger: NSObject {
    
    static let shared = BLLoginManger()
    var timer : Timer?
    
    override init() {
        super.init()
    }
    
    func login(callBack : @escaping(_ token : String) -> Void){
        self.getToken(callBack: { token in
            callBack(token)
        })
        
        if timer != nil{
            return
        }
        timer = Timer(timeInterval: 4.5*60, repeats: true) { [weak self] timer in
            self?.getToken(callBack: { token in
            })
        }
        timer!.fire()
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func getToken(callBack : @escaping(_ token : String) -> Void){
        let genSend : NSString = userDefaults.object(forKey: GenSeed) as! NSString
        let arr : NSArray = genSend.components(separatedBy: ",") as NSArray
        let resStr : NSMutableString = NSMutableString.init()
        for i in 0..<arr.count{
            if i != 0{
                resStr.append(" ")
            }
            resStr.append(arr[i] as! String)
        }
        
        ApiGenerateKeys(resStr as String)
        let ApiGetNPublicKey : String = ApiGetNPublicKey()
        var error : NSError? = nil
        let token : String = ApiLogin(ApiGetNPublicKey, BLTools.getHdDeviceid(), &error)
        userDefaults.setValue(token, forKey: Token)
        userDefaults.synchronize()
        
        callBack(token)
    }
    
    func getHeader() -> NSDictionary{
        let headerDic : NSMutableDictionary = NSMutableDictionary.init()
        let obj = userDefaults.object(forKey: Token)
        if obj is String{
            let token : String = obj as! String
            let authorization : String = "Bearer " + token
            headerDic.setObject(authorization, forKey: "Authorization" as NSCopying)
        }
        
        return headerDic
    }
}
