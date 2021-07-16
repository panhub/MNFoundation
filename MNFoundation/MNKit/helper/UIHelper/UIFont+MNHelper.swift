//
//  UIFont+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation
import CoreGraphics


public extension UIFont {
    
    static func registFont(withName string: String) -> Bool {
        guard let bundle = Bundle.bundle(name: MNIcon.bundle) else { return false }
        guard let path = bundle.path(forResource: string, ofType: "ttf", inDirectory: MNIcon.directory) else { return false }
        return registFont(atPath: path)
    }
    
    static func registFont(atPath string: String) -> Bool {
        guard FileManager.default.fileExists(atPath: string) else { return false }
        guard let fontDataProvider = CGDataProvider(url: (NSURL.fileURL(withPath: string) as CFURL)) else { return false }
        guard let fontRef = CGFont(fontDataProvider) else { return false }
        var error: Unmanaged<CFError>?
        return CTFontManagerRegisterGraphicsFont(fontRef, &error)
    }
}
