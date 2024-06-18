//
//  BLRout.swift
//  TVLive
//
//  Created by Slc on 2021/5/13.
//  Copyright © 2021 dianshijia_ios. All rights reserved.
//

import UIKit

@objcMembers class BLRout: UIViewController {
    
    static let shareRout = BLRout.init()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var callData : NSMutableDictionary = NSMutableDictionary.init()
    
    class func resetCallData(){
        shareRout.callData.removeAllObjects()
    }
    
    class func setValue(obj:Any,key:NSString) {
        if BLTools.isAvailableWithObj(obj: obj) {
            shareRout.callData.setObject(obj, forKey: key)
        }
    }
    
   
    class func routVC(pageStr:String) -> UIViewController{
        //获取类
        let page = NSClassFromString(pageStr) as! UIViewController.Type
        let vc = page.init()
        
        //kvc设置属性
        if 0 < shareRout.callData.allKeys.count {
            for key in shareRout.callData.allKeys {
                autoreleasepool {
                    let value = shareRout.callData.object(forKey: key)
                    if BLTools.isAvailableWithObj(obj: value as Any){
                        vc.setValue(shareRout.callData.object(forKey: key), forKey: key as! String)
                    }
                }
            }
        }
        
        //清理数据
        self.resetCallData()
        
        return vc
    }

}
