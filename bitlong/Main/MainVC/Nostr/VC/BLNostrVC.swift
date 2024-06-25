//
//  BLNostrVC.swift
//  bitlong
//
//  Created by slc on 2024/5/13.
//

import UIKit
import WebKit

class BLNostrVC: BLBaseVC,WKNavigationDelegate,WKUIDelegate {

    var htmlUrl : String?
    var bridge : WKWebViewJavascriptBridge?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(isHidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getGenerateKeys()
    }
    
    func initUI(){
        self.view.addSubview(webView)
//        self.view.addSubview(creatBt)
        webView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(StatusBarHeight)
            make?.left.right().bottom().mas_equalTo()(0)
        }
        
//        creatBt.mas_makeConstraints { (make : MASConstraintMaker?) in
//            make?.top.mas_equalTo()(TopHeight)
//            make?.centerX.mas_equalTo()(50*SCALE)
//            make?.width.mas_equalTo()(40*SCALE)
//            make?.height.mas_equalTo()(20*SCALE)
//        }
        
//        WKWebViewJavascriptBridge
        self.initJavascriptBridge()
        
        self.setHtmlUrl(urlStr: "http://202.79.173.43/")
//        self.setHtmlUrl(urlStr: "http://192.168.110.36:8080/")
    }
    
    lazy var netWorkManager : NetworkManager = {
        let manager : NetworkManager = NetworkManager.share()
        
        return manager
    }()
    
    func setHtmlUrl(urlStr : String){
        htmlUrl = urlStr.removingPercentEncoding
        
        let request : NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: htmlUrl!)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        webView.load(request as URLRequest)
        
        //WKWebView 在iPad上加载手机端的网址时，会自动将该网址转为PC端的网址，javaScript方法不会回调，需要转成手机的
        webView.evaluateJavaScript("navigator.userAgent") { [weak self] userAgent, error in
            if isipad(){
                let userAgentStr : NSString = userAgent as! NSString
                self?.webView.customUserAgent =  userAgentStr.replacingOccurrences(of: "iPad", with: "iPhone")
            }
        }
    }
    
    lazy var webView : WKWebView = {
        let config : WKWebViewConfiguration = WKWebViewConfiguration.init()
        config.preferences = WKPreferences.init()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        config.allowsInlineMediaPlayback = true
        let userController : WKUserContentController = WKUserContentController.init()
        config.userContentController = userController
        config.processPool = WKProcessPool.init()
        var view =  WKWebView.init(frame: .zero, configuration: config)
        view.backgroundColor = .white
        view.uiDelegate = self
        view.navigationDelegate = self
        view.scrollView.delegate = self
        view.scrollView.bounces = false
        view.scrollView.showsVerticalScrollIndicator = false
        view.scrollView.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
//    lazy var creatBt : UIButton = {
//        var bt = UIButton.init()
//        bt.setTitle("刷新", for: .normal)
//        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16*SCALE)
//        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 1.0), for: .normal)
//        bt.addTarget(self, action: #selector(refresh), for: .touchUpInside)
//        
//        return bt
//    }()
//    
//    @objc func refresh(){
//        self.setHtmlUrl(urlStr: "http://192.168.110.36:8080/")
//    }
    
    //WKUIDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    //加载完毕
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
  
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        if self.navigationController?.visibleViewController != self {
            completionHandler()
            return;
        }
        
        let alertController : UIAlertController = UIAlertController.init(title: message, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "确认", style: .cancel, handler: { action in
            completionHandler()
        }))
        
        if self.navigationController?.visibleViewController == self {
            BLTools.getCurrentVC().present(alertController, animated: true) {
            }
        }else{
            completionHandler()
        }
    }

    // 显示两个按钮，通过completionHandler回调判断用户点击的确定还是取消按钮
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }

    // 显示一个带有输入框和一个确定按钮的，通过completionHandler回调用户输入的内容
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        completionHandler("")
    }

    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let requestURL : NSURL = navigationAction.request.url! as NSURL
//        let absoluteString : String = (requestURL.absoluteString?.removingPercentEncoding!)!
        
        decisionHandler(.allow)
    }

    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func getGenerateKeys(){
        let genSeedStr : String = BLTools.getGenSeed()
        let generateKeys : String = ApiGenerateKeys(genSeedStr as String)
        if 0 < generateKeys.count{
            NSSLog(msg: "generateKeys 成功")
        }else{
            NSSLog(msg: "generateKeys 失败")
        }
    }
    
    func initJavascriptBridge(){
        bridge = WKWebViewJavascriptBridge.init(webView: webView)
        bridge?.isLogEnable = true
        bridge?.register(handlerName: "getPublicKey", handler: { parameters, callback in
            NSSLog(msg: String.init(format: "parameters:%@",parameters!))
            if parameters != nil{
                let dic : NSDictionary = parameters! as NSDictionary
                let signObj = dic["signStr"]
                if signObj != nil{
                    if signObj is String{
                        let signStr : String = signObj as! String
                        if signStr.count <= 0{
                            if callback != nil{
                                let publicKey : String = ApiGetPublicKey()
                                NSSLog(msg: String.init(format: "publicKey:%@",publicKey))
                                callback!(publicKey)
                            }
                        }else{
                            if callback != nil{
                                let signMess : String = ApiSignMess(signStr)
                                NSSLog(msg: String.init(format: "signMess:%@",signMess))
                                callback!(signMess)
                            }
                        }
                    }else if signObj is NSDictionary{
//                        let signDic : NSDictionary = signObj as! NSDictionary
//                        if callback != nil{
//                        }
                    }
                }
            }
        })
    
        //oc call js
//        bridge!.callHandler("ocCallJs", data: ["":""], responseCallback: { (reponseData) in
//        })
    }
}
