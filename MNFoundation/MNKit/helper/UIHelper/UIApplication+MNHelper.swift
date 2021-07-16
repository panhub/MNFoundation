//
//  UIApplication+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation
import CoreGraphics

extension UIApplication {
    // 状态栏高度
    static let StatusBarHeight: CGFloat = {
        let hidden = UIApplication.shared.isStatusBarHidden
        if hidden {
            UIApplication.shared.setStatusBarHidden(false, with: .none)
        }
        let status_bar_height = UIApplication.shared.statusBarFrame.size.height
        if hidden {
            UIApplication.shared.setStatusBarHidden(true, with: .none)
        }
        return status_bar_height
    }()
}


