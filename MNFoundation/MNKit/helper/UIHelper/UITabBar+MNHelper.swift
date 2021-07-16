//
//  UITabBar+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation

extension UITabBar {
    // 标签栏高度
    static let Height: CGFloat = {
        return UITabBarController().tabBar.frame.height
    }()
}
