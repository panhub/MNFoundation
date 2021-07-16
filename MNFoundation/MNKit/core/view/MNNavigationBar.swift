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
    @objc optional func rightBarItemTouchUpInside(_ leftBarItem: UIView) -> Void
    // 已经添加完子视图
    @objc optional func finishCreateBarItem(_ navigationBar: MNNavigationBar) -> Void
}

public class MNNavigationBar: UIView {
    // 事件代理
    weak var delegate: MNNavigationBarDelegate?
    // 毛玻璃视图
    var blurView: UIVisualEffectView!
    // 底部分割线
    var shadowView: UIView!
    // 左按钮
    var leftBarItem: UIView!
    // 右按钮
    var rightBarItem: UIView!
    // 标题视图
    var titleView: MNNavBarTitleView!
    // 定义左右按钮大小
    static let ItemSize: CGSize = CGSize(width: 27.0, height: 27.0)
    
    
    // 创建并布局视图
    public func createBarItem() -> Void {
        
        // 添加毛玻璃视图
        let blurView = UIVisualEffectView.blurEffect(frame: self.bounds, style: .light)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        self.blurView = blurView
        
        let leftBarItem = createLeftBarItem()
        addSubview(leftBarItem)
        self.leftBarItem = leftBarItem
    
        createRightBarItem()
        createTitleView()
        
        let shadowView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: MN_SEPARATOR_HEIGHT))
        shadowView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        shadowView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(shadowView)
    }
    
    private func createLeftBarItem() -> UIView {
        var barItem: UIView?
        if let view = self.delegate?.shouldCreateLeftBarItem?() {
            barItem = view
        } else {
            barItem = UIControl()
            barItem!.size_mn = MNNavigationBar.ItemSize
            if let draw = self.delegate?.shouldDrawBackBarItem?(), draw == true {
                // 返回按钮
                barItem?.backgroundColor = UIColor.red
            }
        }
        return barItem!
    }
    
    private func createRightBarItem() -> Void {
        
    }
    
    private func createTitleView() -> Void {
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
