//
//  UIView+MNLayout.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//  为UIView位置添加便捷方法

import UIKit
import CoreGraphics

public extension UIView {
    // 原点
    var origin_mn: CGPoint {
        set (v) {
            var frame = self.frame
            frame.origin = v
            self.frame = frame
        }
        get {
            self.frame.origin
        }
    }
    // 大小
    var size_mn: CGSize {
        set (v) {
            var frame = self.frame
            frame.size = v
            self.frame = frame
        }
        get {
            self.frame.size
        }
    }
    // 左
    var left_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.origin.x = v
            self.frame = frame
        }
        get {
            self.frame.minX
        }
    }
    // 右
    var right_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.origin.x = v - frame.size.width
            self.frame = frame
        }
        get {
            self.frame.maxX
        }
    }
    // 上
    var top_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.origin.y = v
            self.frame = frame
        }
        get {
            self.frame.minY
        }
    }
    // 下
    var bottom_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.origin.y = v - frame.size.height
            self.frame = frame
        }
        get {
            self.frame.maxY
        }
    }
    // 宽
    var width_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.size.width = v
            self.frame = frame
        }
        get {
            self.frame.width
        }
    }
    // 高
    var height_mn: CGFloat {
        set (v) {
            var frame = self.frame
            frame.size.height = v
            self.frame = frame
        }
        get {
            self.frame.height
        }
    }
    // 中心横向
    var centerX_mn: CGFloat {
        set (v) {
            var center = self.center
            center.x = v
            self.center = center
        }
        get {
            self.center.x
        }
    }
    // 中心纵向
    var centerY_mn: CGFloat {
        set (v) {
            var center = self.center
            center.y = v
            self.center = center
        }
        get {
            self.center.y
        }
    }
    // 自身中心点
    var bounds_center: CGPoint {
        get {
            return CGPoint(x: (self.bounds.origin.x + self.bounds.size.width)/2.0, y: (self.bounds.origin.y +  self.bounds.size.height)/2.0)
        }
    }
}
