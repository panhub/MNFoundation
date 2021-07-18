//
//  String+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import UIKit
import Foundation
import CoreGraphics

public extension String {
    // String => Bool
    var bool: Bool {
        return (self == "true" || self == "1" || self == "YES")
    }
    
    static func size(_ string: String?, _ font: UIFont, _ bounding: CGSize) -> CGSize {
        guard let text = string, bounding != CGSize.zero else { return CGSize.zero }
        return (text as NSString).boundingRect(with:bounding , options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [.font: font], context: nil).size
    }
}
