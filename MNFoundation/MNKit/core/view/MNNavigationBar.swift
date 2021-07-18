//
//  MNNavigationBar.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//  导航条

import UIKit

// 导航条事件代理
@objc public protocol MNNavigationBarDelegate: NSObjectProtocol {
    // 获取左按钮视图
    @objc optional func shouldCreateLeftBarItem() -> UIView?
    // 获取右按钮视图
    @objc optional func shouldCreateRightBarItem() -> UIView?
    // 是否创建返回按钮
    @objc optional func shouldDrawBackBarItem() -> Bool
    // 左按钮点击事件
    @objc optional func leftBarItemTouchUpInside(_ leftBarItem: UIView) -> Void
    // 右按钮点击事件
    @objc optional func rightBarItemTouchUpInside(_ rightBarItem: UIView) -> Void
    // 已经添加完子视图
    @objc optional func finishCreateBarItem(_ navigationBar: MNNavigationBar) -> Void
}

public class MNNavigationBar: UIView {
    // 定义左右按钮大小
    static let ItemSize: CGSize = CGSize(width: 20.0, height: 20.0)
    // 按钮间距
    static let ItemMargin: CGFloat = 13.0
    // 事件代理
    weak var delegate: MNNavigationBarDelegate?
    // 毛玻璃视图
    private var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView.blurEffect(frame: CGRect.zero, style: .light)
        return blurView
    }()
    // 左按钮
    private var mn_leftBarItem: UIView!
    var leftBarItem: UIView {
        set (newValue) {}
        get {
            if let barItem = self.mn_leftBarItem { return barItem }
            var barItem: UIView!
            if let view = self.delegate?.shouldCreateLeftBarItem?() {
                barItem = view
            } else {
                barItem = UIControl()
                barItem.size_mn = MNNavigationBar.ItemSize
                if let draw = self.delegate?.shouldDrawBackBarItem?(), draw == true {
                    // 返回按钮
                    barItem.background = UIImage.icon(unicode: MNIcon.Name.back, color: UIColor.black, pix: MNNavigationBar.ItemSize.width)
                    (barItem as! UIControl).addTarget(self, action: #selector(leftBarItemTouchUpInside(_:)), for: UIControl.Event.touchUpInside)
                }
            }
            barItem.left_mn = MNNavigationBar.ItemMargin
            var y = (self.height_mn - UIApplication.StatusBarHeight - barItem.height_mn)/2.0
            y = max(0.0, y)
            y += UIApplication.StatusBarHeight
            barItem.top_mn = y
            barItem.autoresizingMask = .flexibleTopMargin
            mn_leftBarItem = barItem
            return mn_leftBarItem
        }
    }
    // 右按钮
    private var mn_rightBarItem: UIView!
    var rightBarItem: UIView {
        set (newValue) {}
        get {
            if let barItem = self.mn_rightBarItem { return barItem }
            var barItem: UIView!
            if let view = self.delegate?.shouldCreateRightBarItem?() {
                barItem = view
            } else {
                barItem = UIControl()
                barItem.size_mn = MNNavigationBar.ItemSize
                (barItem as! UIControl).addTarget(self, action: #selector(rightBarItemTouchUpInside(_:)), for: UIControl.Event.touchUpInside)
            }
            var y = (self.height_mn - UIApplication.StatusBarHeight - barItem.height_mn)/2.0
            y = max(0.0, y)
            y += UIApplication.StatusBarHeight
            barItem.top_mn = y
            barItem.right_mn = self.width_mn - MNNavigationBar.ItemMargin;
            barItem.autoresizingMask = .flexibleTopMargin
            mn_rightBarItem = barItem
            return mn_rightBarItem
        }
    }
    // 标题视图
    private var mn_titleView: MNNavigationTitleView!
    var titleView: MNNavigationTitleView {
        set (newValue) {}
        get {
            if let view = self.mn_titleView { return view }
            let x = max(self.leftBarItem.right_mn, self.width_mn - self.rightBarItem.left_mn)
            let w = max(0.0, self.width_mn - x*2.0)
            let view = MNNavigationTitleView(frame: CGRect(x: x, y: MN_STATUS_BAR_HEIGHT, width: w, height: self.height_mn - MN_STATUS_BAR_HEIGHT))
            mn_titleView = view
            return mn_titleView
        }
    }
    // 底部分割线
    private var shadowView: UIView = {
        let shadowView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: MN_SEPARATOR_HEIGHT))
        shadowView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return shadowView
    }()
    // 是否添加毛玻璃效果
    var translucent: Bool {
        set (newValue) {
            self.blurView.isHidden = !newValue
        }
        get { !self.blurView.isHidden }
    }
    // 是否添加阴影线
    var shadow: Bool {
        set (newValue) {
            self.shadowView.isHidden = !newValue
        }
        get { !self.shadowView.isHidden }
    }
    // 设置标题字体
    var title: String? {
        set (newValue) {
            self.titleView.titleLabel.text = newValue
        }
        get { self.titleView.titleLabel.text }
    }
    // 设置标题字体
    var titleFont: UIFont? {
        set (newValue) {
            self.titleView.titleLabel.font = newValue
        }
        get { self.titleView.titleLabel.font }
    }
    // 设置标题颜色
    var titleColor: UIColor? {
        set (newValue) {
            self.titleView.titleLabel.textColor = newValue
        }
        get {
            return self.titleView.titleLabel.textColor
        }
    }
    // 返回按钮颜色
    var backColor: UIColor? {
        set (newValue) {
            self.leftItemImage = UIImage.icon(unicode: MNIcon.Name.back, color: newValue, pix: MNNavigationBar.ItemSize.width)
        }
        get { nil }
    }
    // 左按钮图片
    var leftItemImage: UIImage? {
        set (newValue) {
            self.leftBarItem.background = newValue
        }
        get { self.leftBarItem.background }
    }
    // 右按钮图片
    var rightItemImage: UIImage? {
        set (newValue) {
            self.rightBarItem.background = newValue
        }
        get { self.rightBarItem.background }
    }
    
    
    // 创建并布局视图
    public func createItems() -> Void {
        // 毛玻璃
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        // 导航左按钮
        addSubview(leftBarItem)
        // 导航右按钮
        addSubview(rightBarItem)
        // 标题视图
        addSubview(titleView)
        // 阴影线
        shadowView.width_mn = self.width_mn
        shadowView.bottom_mn = self.height_mn
        shadowView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(shadowView)
        // 回调代理
        self.delegate?.finishCreateBarItem?(self)
    }
    
    @objc func leftBarItemTouchUpInside(_ leftBarItem: UIView) -> Void {
        self.delegate?.leftBarItemTouchUpInside?(leftBarItem)
    }
    
    @objc func rightBarItemTouchUpInside(_ rightBarItem: UIView) -> Void {
        self.delegate?.rightBarItemTouchUpInside?(rightBarItem)
    }
}
