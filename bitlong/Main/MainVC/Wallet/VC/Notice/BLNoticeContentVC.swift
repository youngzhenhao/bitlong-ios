//
//  BLNoticeContentVC.swift
//  bitlong
//
//  Created by 微链通 on 2024/6/28.
//

import UIKit

class BLNoticeContentVC: BLBaseVC {
    
    @objc var listItem : BLNoticeListItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        if listItem != nil && listItem?.title != nil && 0 < (listItem?.title!.count)!{
            self.title = listItem?.title
        }else{
            self.title = "公告详情"
        }

        self.initUI()
        self.assignContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBar(isHidden: false)
    }
    
    func initUI(){
        self.view.addSubview(contentTextView)
        contentTextView.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.top.mas_equalTo()(TopHeight)
            make?.left.right().mas_equalTo()(0)
            make?.bottom.mas_equalTo()(-SafeAreaBottomHeight)
        }
    }
    
    func assignContent() {
        if listItem != nil && listItem?.content != nil && 0 < (listItem?.content!.count)!{
            self.contentTextView.attributedText = self.getAttributedString(str: (listItem?.content)!)
        }
    }
    
    func getAttributedString(str : String) -> NSMutableAttributedString{
        let attributedString : NSMutableAttributedString = NSMutableAttributedString.init(string: str)
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 3 // 调整行间距
        paragraphStyle.firstLineHeadIndent = 28*SCALE
        paragraphStyle.paragraphSpacing = 10
        let range : NSRange = NSMakeRange(0, str.count)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attributedString.addAttribute(.font, value: FONT_NORMAL(s: 14*Float(SCALE)), range: range)

        return attributedString
    }
    
    lazy var contentTextView: UITextView = {
        var textView = UITextView.init()
        textView.textColor = UIColorHex(hex: 0x808080, a: 1.0)
        
        return textView
    }()
}
