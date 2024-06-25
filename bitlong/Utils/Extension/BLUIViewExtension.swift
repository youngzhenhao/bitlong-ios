//
//  BLUIViewExtension.swift
//  bitlong
//
//  Created by slc on 2024/5/27.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
    }
}
