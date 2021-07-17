//
//  CALayer+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/17.
//

import UIKit
import Foundation
import QuartzCore

extension CALayer {
    // 背景图片
    var background: UIImage? {
        set (image) {
            self.contents = image
        }
        get {
            if let image = self.contents as? UIImage {
                return image
            }
            return nil
        }
    }
}
 
