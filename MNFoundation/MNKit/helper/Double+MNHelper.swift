//
//  Double+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import Foundation
import CoreGraphics

extension Double {
    // Double => CGFloat
    var float_mn: CGFloat {
        return CGFloat(self)
    }
    // Double => Int
    var int_mn: Int {
        return Int(self)
    }
    // Double => NSInteger
    var integer_mn: NSInteger {
        return NSInteger(self)
    }
    var double_mn: Double {
        return self
    }
}
