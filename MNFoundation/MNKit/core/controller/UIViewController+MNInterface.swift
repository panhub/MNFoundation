//
//  UIViewController+MNInterface.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/18.
//

import UIKit
import Foundation

@objc protocol MNControllerInterface: NSObjectProtocol {
    @objc optional func tabBarItemTitle() -> String?
    @objc optional func tabBarItemImage() -> UIImage?
    @objc optional func tabBarItemSelectedImage() -> UIImage?
    @objc optional func isRootViewController() -> Bool
    @objc optional func isChildViewController() -> Bool
    @objc optional func transitionStyle() -> UIViewController.TransitionStyle
}

extension UIViewController: MNControllerInterface {
    
    // 控制器转场方式
    @objc enum TransitionStyle: UInt {
        case stack, modal
    }
    
    // 内容约束
    struct Edge: OptionSet {
        let rawValue: UInt
        // 无预留
        static let none = Edge(rawValue: 1 << 0)
        // 预留顶部
        static let top = Edge(rawValue: 1 << 1)
        // 预留底部
        static let bottom = Edge(rawValue: 1 << 2)
        // 预留顶部底部
        static let all: Edge = [.top, .bottom]
    }
    
    // 完整的控制器
    var root: UIViewController? {
        var viewController: UIViewController? = self
        repeat {
            if let vc = viewController, vc.isChildViewController() == false { return vc }
            viewController = viewController?.parent
        } while viewController != nil
        return viewController
    }
    
    // 实现协议
    func transitionStyle() -> TransitionStyle { .stack }
    func isRootViewController() -> Bool { false }
    func isChildViewController() -> Bool { false }
    func tabBarItemTitle() -> String? { nil }
    func tabBarItemImage() -> UIImage? { nil }
    func tabBarItemSelectedImage() -> UIImage? { nil }
}
