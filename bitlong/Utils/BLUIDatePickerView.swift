//
//  BLUIDatePickerView.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/17.
//

import UIKit

@objc protocol DatePickerDelegate : NSObjectProtocol {
    func datePickerDelected(date : Date)
}

class BLUIDatePickerView: BLBaseView {
    
    weak var delegate : DatePickerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.addSubview(datePicker)
        self.addSubview(submitBt)
        datePicker.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.left.mas_equalTo()(5*SCALE)
            make?.height.mas_equalTo()(35*SCALE)
            make?.right.mas_equalTo()(-65*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
        
        submitBt.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.right.mas_equalTo()(-5*SCALE)
            make?.height.mas_equalTo()(30*SCALE)
            make?.width.mas_equalTo()(50*SCALE)
            make?.centerY.mas_equalTo()(0)
        }
    }
    
    lazy var datePicker : UIDatePicker = {
        var picker = UIDatePicker.init()
        picker.backgroundColor = UIColorHex(hex: 0xFFFFFF, a: 0.8)
        picker.datePickerMode = .dateAndTime;
        picker.minuteInterval = 1//分钟间隔
        picker.timeZone = TimeZone.init(secondsFromGMT: 3600*8)// 时区：中国 偏移8小时
        // 设置最小日期为当前日期
        picker.minimumDate = Date()
        // 设置为特定日期
        let specificDate = Calendar.current.date(from: DateComponents(year: 2099, month: 1, day: 1))
        picker.maximumDate = specificDate
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .compact
        }
        picker.layer.cornerRadius = 6*SCALE
        picker.clipsToBounds = true
//        picker.addTarget(self, action: #selector(datePickerValueChanged(picker:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var submitBt : UIButton = {
        var bt = UIButton.init()
        bt.setTitle("确定", for: .normal)
        bt.setTitleColor(UIColorHex(hex: 0xFFFFFF, a: 1.0), for: .normal)
        bt.titleLabel?.font = FONT_BOLD(s: 14*Float(SCALE))
        bt.backgroundColor = UIColorHex(hex: 0x665AF0, a: 1.0)
        bt.layer.cornerRadius = 6*SCALE
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(removePickerView), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func removePickerView(){
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.datePickerDelected(date:)))) != nil{
            delegate?.datePickerDelected(date: datePicker.date)
        }
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 0.0
        }completion: { [weak self] flag in
            self?.removeFromSuperview()
        }
    }
}
