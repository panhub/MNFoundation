//
//  UIView+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation

public extension UIView {
    
    // 背景图片
    var background: UIImage? {
        set (image) {
            if let imageView = self as? UIImageView {
                imageView.image = image
            } else if let button = self as? UIButton {
                button.setBackgroundImage(image, for: UIControl.State.normal)
            } else {
                self.layer.background = image
            }
        }
        get {
            if let imageView = self as? UIImageView {
                return imageView.image
            } else if let button = self as? UIButton {
                return button.backgroundImage(for: UIControl.State.normal)
            } else {
                return self.layer.background
            }
        }
    }
    
    // 获取毛玻璃视图
    func effectView(style: UIBlurEffect.Style) -> UIVisualEffectView {
        return UIVisualEffectView.blurEffect(frame: self.bounds, style: style)
    }
}
