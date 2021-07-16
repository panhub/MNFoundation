//
//  String+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import Foundation


public extension String {
    // String => Bool
    var bool: Bool {
        return (self == "true" || self == "1" || self == "YES")
    }
}
