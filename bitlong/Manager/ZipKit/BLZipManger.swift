//
//  BLZipManger.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/24.
//

import UIKit

class BLZipManger: NSObject,URLSessionDataDelegate {
    
    static let shared = BLZipManger()
    
    override init() {
        super.init()
    }

    /*
     压缩
     path:压缩文件路径
     */
    func zipWith(path : String,inputPath : Any){
        if inputPath is NSArray{
            SSZipArchive.createZipFile(atPath: path, withFilesAtPaths: inputPath as! [String])
        }
    }
    
    /*
     解压
     path:被解压的文件路径
     toPath:解压到的目录
     */
    func unZipWith(filePath : String,toFilePath : String){
        SSZipArchive.unzipFile(atPath: filePath, toDestination: toFilePath, overwrite: true, password: nil) { entry, zipInfo, entryNumber, total in
            let progressValue : Float = Float(entryNumber)/Float(total)
            DispatchQueue.main.async {
                BLTools.showProgress(progress: progressValue, status: "文件正在解压中")
            }
        } completionHandler: { entry, status, error in
            DispatchQueue.main.async {
                if status{
                    BLTools.showSucces(status: "文件解压成功")
                    
                }else{
                    if error != nil{
                        let err : NSError = error! as NSError
                        BLTools.showTost(tip: err.domain, superView: BLTools.getCurrentVC().view)
                    }else{
                        BLTools.showSucces(status: "文件解压出错")
                    }
                }
            }
        }
    }
    
    //fileCachesPath : 缓存目录，临时存放下载的文件
    func downLoadDataFile(fileCachesPath : String){
        BLTools.showLoading(status: "正在下载文件中...")
        let param : NSMutableDictionary = NSMutableDictionary.init(dictionary: BLLoginManger.shared.getHeader())
        param.setValue("attachment; filename=data.zip", forKey: "Content-Disposition")
        param.setValue("application/octet-stream", forKey: "content-type")
        NetworkManager.share().getBytesRequestUrlString(ApiSnapshotDownload, paramerers: nil, requestHeader: (param as! [AnyHashable : Any])) { resp in
            BLTools.hideLoading()
            if resp is DispatchData{
                let patchData : DispatchData = resp as! DispatchData
                // 将 NSDispatchData 转换为 Data
                let data = Data(patchData)
                // 使用解压缩后的数据
                do {
                    DispatchQueue.main.async {
                        BLTools.showLoading(status: "文件下载成功，正在处理中...")
                    }
                    try data.write(to: URL.init(string: "file://" + fileCachesPath)!)
                    let toFilePath : String = KNSDocumentPath(name: UnZipFilePath)
                    self.unZipWith(filePath: fileCachesPath, toFilePath: toFilePath)
                } catch {
                    BLTools.showTost(tip: String.init(format: "Error writing zip file data to file: \(error)"), superView: BLTools.getCurrentVC().view)
                }
            }
        } onFailureBlock: { errorRespModel in
            BLTools.hideLoading()
            if errorRespModel?.msg != nil{
                DispatchQueue.main.async {
                    BLTools.showTost(tip: (errorRespModel?.msg)!, superView: BLTools.getCurrentVC().view)
                }
            }
        }
    }
}
