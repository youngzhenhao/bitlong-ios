//
//  BLChangePasswordTipView.swift
//  bitlong
//
//  Created by slc on 2024/6/20.
//

import UIKit

class BLChangePasswordTipView: BLBaseView {
    
    @objc var isNeedToChange : Bool = false
    @objc var callBack : ChangePasswordBlock?
    
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
        containerView.addSubview(lineView)
        containerView.addSubview(textLbl)
        containerView.addSubview(unChangeBt)
        containerView.addSubview(changeBt)
        
        containerView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.right().bottom().mas_equalTo()(0)
            make?.height.mas_equalTo()(180*SCALE+SafeAreaBottomHeight)
        }
        
        titleLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.width.mas_equalTo()(180*SCALE)
            make?.height.mas_equalTo()(20*SCALE)
            make?.top.mas_equalTo()(15*SCALE)
            make?.centerX.mas_equalTo()(0)
        }
        
        lineView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(titleLbl.mas_bottom)?.offset()(15*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(0.5*SCALE)
        }
        
        textLbl.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(lineView.mas_bottom)?.offset()(25*SCALE)
            make?.left.mas_equalTo()(10*SCALE)
            make?.right.mas_equalTo()(-10*SCALE)
            make?.height.mas_equalTo()(16*SCALE)
        }
        
        unChangeBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(textLbl.mas_bottom)?.offset()(25*SCALE)
            make?.left.mas_equalTo()(30*SCALE)
            make?.width.mas_equalTo()((SCREEN_WIDTH - 100*SCALE)/2.0)
            make?.height.mas_equalTo()(35*SCALE)
        }
        
        changeBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-30*SCALE)
            make?.width.mas_equalTo()((SCREEN_WIDTH - 100*SCALE)/2.0)
            make?.height.mas_equalTo()(35*SCALE)
            make?.centerY.mas_equalTo()(unChangeBt.mas_centerY)
        }
    }
    
    @objc func updateView(isChange : Bool){
        isNeedToChange = isChange
        
        if isChange{
            textLbl.text = "检测到有修改密码任务,是否修改?"
            unChangeBt.setTitle(isNeedToChange ? "暂不修改" : "不修改", for: .normal)
            changeBt.setTitle(isNeedToChange ? "去修改" : "修改", for: .normal)
        }
    }
    
    lazy var containerView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 1.0)
        view.layer.cornerRadius = 6*SCALE
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var titleLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "提示"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 16*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var lineView : UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColorHex(hex: 0x383838, a: 0.8)
        
        return view
    }()
    
    lazy var textLbl : UILabel = {
        var lbl = UILabel.init()
        lbl.text = "修改密码需要重新启动进入修改页面，是否重启?"
        lbl.textColor = UIColorHex(hex: 0x383838, a: 1.0)
        lbl.font = FONT_NORMAL(s: 14*Float(SCALE))
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var unChangeBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("不修改", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 0.8), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 13*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xD2D9FA, a: 1.0)
        bt.layer.cornerRadius = 18*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var changeBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("修改", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0x383838, a: 0.8), for: .normal)
        bt.titleLabel?.font = FONT_NORMAL(s: 13*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0xD2D9FA, a: 1.0)
        bt.layer.cornerRadius = 18*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(clickAcation), for: .touchUpInside)
        
        return bt
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = touches.first?.view
        if view != containerView{
            self.closeAcation()
        }
    }
    
    func closeAcation(){
        self.removeFromSuperview()
    }
    
    @objc func clickAcation(sender : UIButton){
        if sender == unChangeBt{
            userDefaults.set(false, forKey: IsNeedChangePassWord)
            
            if callBack != nil{
                callBack!()
            }
        }else{
            userDefaults.set(isNeedToChange ? false : true, forKey: IsNeedChangePassWord)
            
            if isNeedToChange{
                let baseVC : BLBaseVC =  BLTools.getCurrentVC() as! BLBaseVC
                let vc : BLChangePasswordVC = BLChangePasswordVC.init()
                vc.callBack = { [weak self] in
                    if self?.callBack != nil{
                        self?.callBack!()
                    }
                }
                baseVC.pushBaseVC(vc: vc, animated: true)
            }else{
                exit(0)
            }
        }
        userDefaults.synchronize()
        
        self.closeAcation()
    }
}
