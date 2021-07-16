//
//  MNKit.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import UIKit
import Foundation
import CoreGraphics

public class MNKit: NSObject {
    static let shared: MNKit = {
        return MNKit()
    }()
    
    func load() -> Void {
        if UIFont.registFont(withName: MNIcon.name) {
            print("注册字体完成")
        }
    }
}
