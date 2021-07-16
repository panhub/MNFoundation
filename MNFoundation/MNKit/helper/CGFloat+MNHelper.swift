//
//  CGFloat+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import Foundation
import CoreGraphics

extension CGFloat {
    // CGFloat => Double
    var double_mn: Double {
        return Double(self)
    }
    // CGFloat => Int
    var int_mn: Int {
        return Int(self)
    }
    // CGFloat => NSInteger
    var integer_mn: NSInteger {
        return NSInteger(self)
    }
    var float_mn: CGFloat {
        return self
    }
}
