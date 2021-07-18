//
//  MNBaseViewController.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/18.
//  控制器基类(提供基础功能)

import UIKit
import Foundation

class MNBaseViewController: UIViewController, UIViewControllerTransitioningDelegate {
    // 位置
    var frame: CGRect = UIScreen.main.bounds
    // 是否显示
    var isAppear: Bool = false
    // 是否第一次显示
    var isFirstAppear: Bool = true
    // 是否需要刷新数据
    var isNeedsReloadData: Bool = false
    // 指定是否是子控制器
    var isChildController: Bool = false
    // 内容视图
    var contentView: UIView!
    // 内容约束
    var edges: UIViewController.Edge = .none
    // 空数据视图
    fileprivate var dataEmptyView: MNEmptyView!
    var emptySuperview: UIView { contentView }
    var emptyViewFrame: CGRect { emptySuperview.bounds }
    var emptyView: MNEmptyView {
        if let emptyView = dataEmptyView { return emptyView }
        let emptyView = MNEmptyView(frame: emptyViewFrame)
        emptyView.delegate = self
        emptyView.textColor = UIColor.black
        emptyView.titleColor = UIColor.black
        dataEmptyView = emptyView
        return dataEmptyView
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialized()
    }
    
    convenience init(title name: String?) {
        self.init()
        self.title = name
        self.initialized()
    }
    
    convenience init(_ frame: CGRect) {
        self.init()
        self.frame = frame
        self.isChildController = true
        self.initialized()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化自身属性
    func initialized() -> Void {
        if transitionStyle() == .modal {
            transitioningDelegate = self
        }
        edges = (isChildViewController() || !isRootViewController()) ? .none : .bottom
    }
    
    override func loadView() {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = true
        self.view = view;
        createView()
    }
    
    func createView() -> Void {
        var frame = self.view.bounds
        if edges.contains(.bottom) {
            frame = frame.inset(by: UIEdgeInsets(top: 0.0, left: 0.0, bottom: MN_TAB_BAR_HEIGHT, right: 0.0))
        }
        let contentView = UIView(frame: frame)
        contentView.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 255.0/255.0, alpha: 1.0)//UIColor.white
        contentView.isUserInteractionEnabled = true
        view.addSubview(contentView)
        self.contentView = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAppear = true
        if isChildViewController() == false {
            UIApplication.shared.setStatusBarStyle(self.preferredStatusBarStyle, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isAppear = false
        isFirstAppear = false
    }
    
    func loadData() -> Void {
        
    }
    
    func reloadData() -> Void {
        
    }
    
    // 显示空数据视图
    func showEmpty(needs flag: Bool, _ image: UIImage?, _ text: String?, _ title: String?, _ type: MNEmptyView.Event) -> Void {
        if flag {
            emptyView.image = image
            emptyView.text = text
            emptyView.title = title
            emptyView.type = type
            if let superview = emptyView.superview {
                emptyView.setNeedsLayout()
                emptyView.layoutIfNeeded()
                superview.bringSubviewToFront(emptyView)
            } else {
                emptyView.frame = emptyViewFrame
                emptySuperview.addSubview(emptyView)
            }
            emptyView.show()
        } else {
            dataEmptyView?.dismiss()
        }
    }
    
    override func isChildViewController() -> Bool { isChildController }
}

// 空数据相关操作
extension MNBaseViewController: MNEmptyViewDelegate {
    func dataEmptyViewButtonTouchUpInside(_ emptyView: MNEmptyView) {
        guard emptyView.type != .custom else { return }
        emptyView.dismiss()
        if emptyView.type == .reload {
            // 重载数据
            reloadData()
        } else if emptyView.type == .load {
            // 加载数据
            loadData()
        }
    }
}
