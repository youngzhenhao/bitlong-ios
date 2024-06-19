//
//  BLServerErrorDealModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/14.
//

import UIKit

class BLServerErrorDealModel: BLBaseModel {
    
    @objc static func dealTapError(jsonStr : NSString?, callBack : @escaping (_ isInvalidate : Bool) -> ()){
        if jsonStr != nil{
            let jsonObj : NSDictionary = jsonStr?.mj_JSONObject() as! NSDictionary
            let success : Bool = jsonObj["success"] as! Bool
            if success{
                callBack(true)
            }else{
                let errorStr : NSString = jsonObj["error"] as! NSString
                if (errorStr.contains(Error_ProofPre) && errorStr.contains(Error_ProofLast)){
                    let preRange : NSRange = errorStr.range(of: Error_ProofPre)
                    let lastRange : NSRange = errorStr.range(of: Error_ProofLast)
                    let subStr : NSString = errorStr.substring(with: NSMakeRange(preRange.location+preRange.length, lastRange.location - (preRange.location+preRange.length))) as NSString
                    let fileArr : NSArray = subStr.components(separatedBy: "/") as NSArray
                    let assetsId : String = fileArr[fileArr.count-2] as! String
                    let fileName : String = fileArr.lastObject as! String
                    self.proofDownload(filePath: subStr as String, assetId: assetsId, fileName: fileName)

                    callBack(true)
                }else{
                    callBack(false)
                }
            }
        }
    }

    //下载证明文件
    @objc static func proofDownload(filePath : String, assetId : String, fileName : String){
        let urlStr : String = ApiProofDownload + "/" + assetId + "/" + fileName
        let param : NSMutableDictionary = NSMutableDictionary.init(dictionary: BLLoginManger.shared.getHeader())
        param.setValue("application/octet-stream", forKey: "Accept")
        NetworkManager.share().getBytesRequestUrlString(urlStr, paramerers: nil, requestHeader: (param as! [AnyHashable : Any])) { resp in
            if resp is Data{
                let data : Data = resp as! Data
                do {
                    try data.write(to: URL.init(string: "file://" + filePath)!)
                    DispatchQueue.main.async {
                        BLTools.showAlterWith(title: "温馨提示", msg: "因缺失数据文件，导致资产无法正常交易，需要重启应用", cancelTitle: "取消", confirmTitle: "确定") {
                            exit(0)
                        }
                    }
                } catch {
                    NSSLog(msg: String.init(format: "Error writing proof file data to file: \(error)"))
                }
            }
        } onFailureBlock: { errorRespModel in
            BLTools.showTost(tip: (errorRespModel?.msg)!, superView: BLTools.getCurrentVC().view)
        }
    }
}
