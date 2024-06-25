//
//  BLCollectionInvoiceQRView.swift
//  bitlong
//
//  Created by slc on 2024/6/1.
//

import UIKit

typealias InvoiceQRViewBlock = () ->()

class BLCollectionInvoiceQRView: BLBaseView {
    
    var callBack : InvoiceQRViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(closeBt)
        containerView.addSubview(lineView)
        containerView.addSubview(qrImgView)
        containerView.addSubview(encodeLbl)
        containerView.addSubview(copyBt)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.centerY.mas_equalTo()(0)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.bottom.mas_equalTo()(copyBt.mas_bottom)?.offset()(20*SCALE)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(16*SCALE)
            make?.left.right().mas_equalTo()(0)
            make?.height.mas_equalTo()(18*SCALE)
        }
        
        closeBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-16*SCALE)
            make?.width.height().mas_equalTo()(24*SCALE)
            make?.centerY.mas_equalTo()(titleLbl)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(16*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(1*SCALE)
        }
        
        qrImgView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineView.mas_bottom)?.offset()(30*SCALE)
            make?.width.height().mas_equalTo()(180*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        encodeLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(qrImgView.mas_bottom)?.offset()(30*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(140*SCALE)
        }
        
        copyBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(encodeLbl.mas_bottom)?.offset()(25*SCALE)
            make?.left.mas_equalTo()(20*SCALE)
            make?.right.mas_equalTo()(-20*SCALE)
            make?.height.mas_equalTo()(50*SCALE)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 12*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 18*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var closeBt : UIButton = {
        var bt = UIButton.init()
        bt.setImage(imagePic(name: "ic_wallet_close"), for: .normal)
        bt.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xE5E5E5, a: 1.0)
        
        return view
    }()
    
    lazy var qrImgView : UIImageView = {
        var view = UIImageView.init()
        
        return view
    }()
    
    lazy var encodeLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.textColor = UIColorHex(hex: 0x383838, a: 0.4)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var copyBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("复制地址", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 16*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x2A82E4, a: 1.0)
        bt.layer.cornerRadius = 22*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(copyClicked), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func closeClicked(){
        if callBack != nil{
            callBack!()
        }
    }
    
    @objc func copyClicked(){
        if encodeLbl.text != nil{
            BLTools.pasteGeneral(string: encodeLbl.text as Any)
        }
    }
    
    func assignHisItem(obj: Any,title : String){
        titleLbl.text = title
        
        if obj is BLCollectionHisItem{
            let item : BLCollectionHisItem = obj as! BLCollectionHisItem
            if item.encoded != nil{
                qrImgView.image = BLTools.generateQRCode(for: item.encoded!)
                encodeLbl.text = item.encoded
                
            }
        }else if obj is BLInvoicesHisItem{
            let item : BLInvoicesHisItem = obj as! BLInvoicesHisItem
            if item.invoice != nil{
                qrImgView.image = BLTools.generateQRCode(for: item.invoice!)
                encodeLbl.text = item.invoice
            }
        }
        
        let height : CGFloat = BLTools.textHeight(text: encodeLbl.text!, font: encodeLbl.font, width: SCREEN_WIDTH-60*SCALE)
        encodeLbl.mas_updateConstraints { (make : MASConstraintMaker?) in
            make?.height.mas_equalTo()(height+5*SCALE)
        }
    }
}
