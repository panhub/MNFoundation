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
            self.contents = image?.cgImage
        }
        get {
//            if let contents = self.contents {
//                return UIImage(cgImage: contents as CGImage)
//            }
            return nil
        }
    }
}
 
