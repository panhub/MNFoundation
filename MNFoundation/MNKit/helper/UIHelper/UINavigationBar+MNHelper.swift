//
//  UINavigationBar+MNHelper.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation

extension UINavigationBar {
    // 导航栏高度
    static let Height: CGFloat = {
        return UINavigationController().navigationBar.frame.height
    }()
}
