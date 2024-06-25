//
//  BLWalletViewModel.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/28.
//

import UIKit

class BLWalletViewModel: BLBaseModel {
    var P2TRModel : BLAddAddressModel?,P2WKHModel : BLAddAddressModel?,NP2WKHModel : BLAddAddressModel?
     
    func getAddress(){
        var objStr = ApiGetNewAddress_P2TR()
        var obj = self.getJSONObject(obj: objStr)
        if obj != nil{
            let dic : NSDictionary = obj!
            P2TRModel = BLAddAddressModel.mj_object(withKeyValues: dic)
        }
        
        objStr = ApiGetNewAddress_P2WKH()
        obj = self.getJSONObject(obj: objStr)
        if obj != nil{
            let dic : NSDictionary = obj!
            P2WKHModel = BLAddAddressModel.mj_object(withKeyValues: dic)
        }
        
        objStr = ApiGetNewAddress_NP2WKH()
        obj = self.getJSONObject(obj: objStr)
        if obj != nil{
            let dic : NSDictionary = obj!
            NP2WKHModel = BLAddAddressModel.mj_object(withKeyValues: dic)
        }
    }
    
    func getJSONObject(obj : Any) -> NSDictionary?{
        if obj is NSString{
            let objStr : NSString = obj as! NSString
            let param = objStr.mj_JSONObject()
            if param != nil && param is NSDictionary{
                let dic : NSDictionary = param as! NSDictionary
                let data = dic["data"]
                if data != nil && data is NSDictionary{
                    return (data as! NSDictionary)
                }
            }
        }
        
        return nil
    }
    
    static func getWalletBalance() -> BLWalletBalanceModel{
        //获取钱包信息
        let jsonStr : String = ApiGetWalletBalance()
        let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
        let obj = jsobObj["data"]
        if obj != nil && obj is NSDictionary{
            let data : NSDictionary = obj as! NSDictionary
            let walletBalanceModel : BLWalletBalanceModel = BLWalletBalanceModel.mj_object(withKeyValues: data)
           
            return walletBalanceModel
        }
        
        return BLWalletBalanceModel.init()
    }
    
    static func getAssetsModel() -> BLAssetsModel{
        //获取资产列表
        let assetsListStr : String = ApiListBalances()
        let jsonDic : NSDictionary = assetsListStr.mj_JSONObject() as! NSDictionary
        let assetsModel : BLAssetsModel = BLAssetsModel.mj_object(withKeyValues: jsonDic)
       
        return assetsModel
    }
    
    static func getAssetAddressDecode(jsonStr : String) -> BLAssetAddressDecodeModel{
        let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
        let obj = jsobObj["data"]
        if obj != nil && obj is NSDictionary{
            let data : NSDictionary = obj as! NSDictionary
            let decodeModel : BLAssetAddressDecodeModel = BLAssetAddressDecodeModel.mj_object(withKeyValues: data)
           
            return decodeModel
        }
        
        return BLAssetAddressDecodeModel.init()
    }
    
    static func getLightingAddressDecode(jsonStr : String) -> BLLightingAddressDecodeModel{
        let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
        let obj = jsobObj["data"]
        if obj != nil && obj is NSDictionary{
            let data : NSDictionary = obj as! NSDictionary
            let decodeModel : BLLightingAddressDecodeModel = BLLightingAddressDecodeModel.mj_object(withKeyValues: data)
           
            return decodeModel
        }
        
        return BLLightingAddressDecodeModel.init()
    }
    
    static func getQueryHisAddrs(jsonStr : String) -> BLCollectionHisModel{
        let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
        let hisModel : BLCollectionHisModel = BLCollectionHisModel.mj_object(withKeyValues: jsobObj)
       
        return hisModel
    }
    
    static func getCoinDetailModel(jsonStr : String) -> BLAssetsCoinDetailModel{
        let jsobObj : NSDictionary = jsonStr.mj_JSONObject() as! NSDictionary
        let obj = jsobObj["data"]
        if obj != nil && obj is NSDictionary{
            let data : NSDictionary = obj as! NSDictionary
            let model : BLAssetsCoinDetailModel = BLAssetsCoinDetailModel.mj_object(withKeyValues: data)
           
            return model
        }
        
        return BLAssetsCoinDetailModel.init()
    }
    
    //转账
    static func invoiceInvoicePay(param : NSDictionary, successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiInvoiceInvoicePay, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //开户（开发票）
    static func invoiceInvoiceApply(param : NSDictionary, successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiInvoiceInvoiceApply, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //查询余额
    static func invoiceQueryBalance(successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiInvoiceQueryBalance, paramerers:nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //查询发票
    static func invoiceQueryInvoice(assetId : String, successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        let param : NSDictionary = ["asset_id" : assetId]
        NetworkManager.share().postRequestUrlString(ApiInvoiceQueryInvoice, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //查询交易记录
    static func invoiceQueryPayment(assetId : String, successed: @escaping (_ model : BLInvoicesPaymentModel) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        let param : NSDictionary = ["asset_id" : assetId]
        NetworkManager.share().postRequestUrlString(ApiInvoiceQueryPayment, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            let paymentModel : BLInvoicesPaymentModel = BLInvoicesPaymentModel.mj_object(withKeyValues: respObj)
            if paymentModel.payments != nil && 0 < paymentModel.payments!.count{
                if paymentModel.paymentsIn != nil{
                    paymentModel.paymentsIn?.removeAllObjects()
                }else{
                    paymentModel.paymentsIn = NSMutableArray.init()
                }
                if paymentModel.paymentsOut != nil{
                    paymentModel.paymentsOut?.removeAllObjects()
                }else{
                    paymentModel.paymentsOut = NSMutableArray.init()
                }
                for item : BLInvoicesPaymentItem in paymentModel.payments! {
                    //0表示收入，1表示支出
                    if item.away == "0"{
                        paymentModel.paymentsIn?.add(item)
                    }else if item.away == "1"{
                        paymentModel.paymentsOut?.add(item)
                    }
                }
            }
            
            successed(paymentModel)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //上传BTC余额
    static func setBtcBalance(param : NSDictionary, successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().postRequestUrlString(ApiBtcBalanceSet, paramerers:(param as! [AnyHashable : Any]), requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any]), onSuccessBlock: { respObj in
            successed(respObj as! NSDictionary)
        }, onFailureBlock: { (error : ErrorRespModel?) in
            failed(error!)
        }, requestSerializerType: .jsonType)
    }
    
    //查询BTC余额
    static func getBtcBalance(successed: @escaping (_ respObj : NSDictionary) -> Void, failed: @escaping (_ error : ErrorRespModel) -> Void){
        NetworkManager.share().getBufRequestUrlString(ApiBtcBalanceGet, paramerers: nil, requestHeader: (BLLoginManger.shared.getHeader() as! [AnyHashable : Any])) { respObj in
            
        } onFailureBlock: { (error : ErrorRespModel?) in
            
        }
    }
}
