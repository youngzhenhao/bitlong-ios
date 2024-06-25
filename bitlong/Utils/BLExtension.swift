//
//  BLExtension.swift
//  bitlong
//
//  Created by slc on 2024/5/8.
//

import UIKit

/*
 UIColor
 */
//传16进制字符串
extension UIColor {
    convenience init(hex: String,alpha:CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = (rgb >> 16) & 0xFF
        let g = (rgb >> 8) & 0xFF
        let b = rgb & 0xFF
        
        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF,
            alpha: alpha
        )
    }
}

/*
 UIButton
 */
extension UIButton {
    
    /// 图片在右位置
    /// - Parameter spacing: 间距
    func iconInRight(with spacing: CGFloat) {
        let img_w = self.imageView?.frame.size.width ?? 0
        let title_w = self.titleLabel?.frame.size.width ?? 0
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(img_w+spacing / 2.0), bottom: 0, right: (img_w+spacing / 2.0))
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (title_w+spacing / 2.0), bottom: 0, right: -(title_w+spacing / 2.0))
    }
    
    /// 图片在左位置
    /// - Parameter spacing: 间距
    func iconInLeft(spacing: CGFloat) {
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2.0, bottom: 0, right: -spacing / 2.0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2.0, bottom: 0, right: spacing / 2.0)
    }
    
    /// 图片在上面
    /// - Parameter spacing: 间距
    func iconInTop(spacing: CGFloat) {
        let img_W = self.imageView?.frame.size.width ?? 0
        let img_H = self.imageView?.frame.size.height ?? 0
        let tit_W = self.titleLabel?.frame.size.width ?? 0
        let tit_H = self.titleLabel?.frame.size.height ?? 0
        
        self.titleEdgeInsets = UIEdgeInsets(top: (tit_H / 2 + spacing / 2), left: -(img_W / 2), bottom: -(tit_H / 2 + spacing / 2), right: (img_W / 2))
        self.imageEdgeInsets = UIEdgeInsets(top: -(img_H / 2 + spacing / 2), left: (tit_W / 2), bottom: (img_H / 2 + spacing / 2), right: -(tit_W / 2))
    }
    
    /// 图片在 下面
    /// - Parameter spacing: 间距
    func iconInBottom(spacing: CGFloat) {
        let img_W = self.imageView?.frame.size.width ?? 0
        let img_H = self.imageView?.frame.size.height ?? 0
        let tit_W = self.titleLabel?.frame.size.width ?? 0
        let tit_H = self.titleLabel?.frame.size.height ?? 0
        
        self.titleEdgeInsets = UIEdgeInsets(top: -(tit_H / 2 + spacing / 2), left: -(img_W / 2), bottom: (tit_H / 2 + spacing / 2), right: (img_W / 2))
        self.imageEdgeInsets = UIEdgeInsets(top: (img_H / 2 + spacing / 2), left: (tit_W / 2), bottom: -(img_H / 2 + spacing / 2), right: -(tit_W / 2))
    }
}


/*
 UIImage
 */
extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
}
