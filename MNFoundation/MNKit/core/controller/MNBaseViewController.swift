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
        contentView.backgroundColor = UIColor.white
        contentView.isUserInteractionEnabled = true
        view.addSubview(contentView)
        self.contentView = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func isChildViewController() -> Bool { isChildController }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

