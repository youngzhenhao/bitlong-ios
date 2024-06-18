//
//  BLCastOnViewModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/5.
//

import UIKit

class BLCastOnViewModel: BLBaseModel {
    
    var sendHisModel : BLAssetsSendHisModel?
    
    func getSendHisModel(jsonStr : String){
        let obj = BLCastOnViewModel.getJSONObject(obj: jsonStr)
        if obj != nil{
            sendHisModel = BLAssetsSendHisModel.mj_object(withKeyValues: obj! as NSDictionary)
        }
    }
    
    static func getJSONObject(obj : Any) -> NSDictionary?{
        if obj is NSString{
            let objStr : NSString = obj as! NSString
            let param = objStr.mj_JSONObject()
            if param != nil && param is NSDictionary{
                return (param as! NSDictionary)
            }
        }
        
        return nil
    }

    //查询所有已发行且未全部铸造的公平发射数据
    static func getFairFaunchQueryIssued(successed: @escaping (_ model : BLLaunchQueryIssuedModel) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().getRequestUrlString(ApiFairLaunchQueryIssued, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { resObj in
            let queryIssuedModel : BLLaunchQueryIssuedModel = BLLaunchQueryIssuedModel.mj_object(withKeyValues: resObj)
            successed(queryIssuedModel)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .httpType)
    }
    
    //查询合适的费率
    static func getFeeQueryRate(successed: @escaping (_ model : BLCreatAssetsRateModel) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().getRequestUrlString(ApiFeeQueryRate, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { resObj in
            let data = (resObj as! NSDictionary)["data"]
            if data is NSDictionary{
                let rateModel : BLCreatAssetsRateModel = BLCreatAssetsRateModel.mj_object(withKeyValues: data)
                successed(rateModel)
            }else{
                successed(BLCreatAssetsRateModel.init())
            }
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .httpType)
    }
    
    //进行公平发射资产发行
    static func fairFaunchSet(param : NSDictionary, successed: @escaping (_ resObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiFairLaunchSet, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //通过资产ID(AssetID)查询公平发射资产发行信息
    static func getQueryAsset(assetId : String, successed: @escaping (_ model : BLLaunchQueryIssuedItem) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        let urlStr : String = ApiFairLaunchQueryAsset + "/" + assetId
        NetworkManager.share().getRequestUrlString(urlStr, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { resObj in
            if let data = (resObj as! NSDictionary)["data"]{
                let queryIssuedItem : BLLaunchQueryIssuedItem = BLLaunchQueryIssuedItem.mj_object(withKeyValues: data)
                successed(queryIssuedItem)
            }else{
                successed(BLLaunchQueryIssuedItem.init())
            }
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .httpType)
    }
    
    //通过给定参数查询是否可以进行铸造行为
    static func fairFaunchQueryMint(param : NSDictionary, successed: @escaping (_ resObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiFairLaunchQueryMint, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //进行公平发射的资产铸造
    static func fairFaunchMint(param : NSDictionary, successed: @escaping (_ resObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiFairLaunchMint, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //查询用户自己的公平发射资产铸造信息
    static func fairFaunchMintQueryOwnMint(successed: @escaping (_ resObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().getRequestUrlString(ApiFairLaunchQueryOwnMint, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .httpType)
    }
    
    //进行公平发射资产的发行保留部分取回
    static func fairFaunchMintReserved(param : NSDictionary, successed: @escaping (_ resObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiFairLaunchMintReserved, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //通过资产ID(AssetID)查询资产的可铸造库存份数和数量
    static func getQueryInventoryMintNumber(assetId : String, successed: @escaping (_ model : BLCastOnQueryInventoryMintNumberModel) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        let urlStr : String = ApiFairLaunchQueryInventoryMintNumber + "/" + assetId
        NetworkManager.share().getRequestUrlString(urlStr, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { resObj in
            if let data = (resObj as! NSDictionary)["data"]{
                let model : BLCastOnQueryInventoryMintNumberModel = BLCastOnQueryInventoryMintNumberModel.mj_object(withKeyValues: data)
                successed(model)
            }else{
                successed(BLCastOnQueryInventoryMintNumberModel.init())
            }
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .httpType)
    }
}
