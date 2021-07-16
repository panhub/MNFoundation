//
//  MNSwizzle.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//  方法交换支持

import UIKit
import Foundation
import ObjectiveC.runtime

@objc protocol MNAwake {
    // 唤醒方法, 在此提交交换函数
    static func awake()
}

extension MNAwake {
    // 交换实例方法
    static func swizzleInstanceMethod(_ originalSelector: Selector, _ swizzledSelector: Selector) -> Void {
        if let originalMethod = class_getInstanceMethod(Self.self, originalSelector), let swizzledMethod = class_getInstanceMethod(Self.self, swizzledSelector)  {
            if class_addMethod(Self.self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
                class_replaceMethod(Self.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    // 交换类方法
    static func swizzleClassMethod(_ originalSelector: Selector, _ swizzledSelector: Selector) -> Void {
        // 类方法列表存放在元类里, 这里要获取元类
        let metaClass: AnyClass? = objc_getMetaClass(object_getClassName(Self.self)) as? AnyClass
        if let originalMethod = class_getClassMethod(metaClass, originalSelector), let swizzledMethod = class_getClassMethod(metaClass, swizzledSelector) {
            if class_addMethod(metaClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
                class_replaceMethod(metaClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }
}
