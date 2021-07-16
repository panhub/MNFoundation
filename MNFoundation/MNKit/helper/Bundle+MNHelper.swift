//
//  NSBundle+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import Foundation

extension Bundle {
    class func bundle(name ext: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: ext, ofType: "bundle") else { return nil }
        return Bundle(path: path)
    }
}
