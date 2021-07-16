//
//  UIView+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation

public extension UIView {
    func effectView(style: UIBlurEffect.Style) -> UIVisualEffectView {
        return UIVisualEffectView.blurEffect(frame: self.bounds, style: style)
    }
}
