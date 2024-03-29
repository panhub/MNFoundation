//
//  MNExtendViewController.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/18.
//  附带导航条的控制器基类

import UIKit

class MNExtendViewController: MNBaseViewController {
    // 定制导航条高度
    var navigationBarHeight: CGFloat { MN_NAV_BAR_HEIGHT }
    // 导航条
    fileprivate var mn_navigationBar: MNNavigationBar!
    // 外界获取导航条
    override var navigationBar: MNNavigationBar! { mn_navigationBar }
    
    // 初始化时对内容视图约束
    override func initialized() {
        super.initialized()
        if isChildViewController() == false {
            edges.remove(.none)
            edges = edges.union(.top)
        }
    }
    
    // 标题
    override var title: String? {
        set (newValue) {
            super.title = newValue
            if let bar = mn_navigationBar { bar.title = title }
        }
        get { super.title }
    }
    
    override func createView() {
        super.createView()
        if isChildViewController() == false {
            if edges.contains(.top) {
                contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: navigationBarHeight + MN_STATUS_BAR_HEIGHT, left: 0.0, bottom: 0.0, right: 0.0))
            }
            let navigationBar = MNNavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: view.width_mn, height: self.navigationBarHeight + MN_STATUS_BAR_HEIGHT))
            navigationBar.delegate = self
            navigationBar.createItems()
            navigationBar.title = title
            view.addSubview(navigationBar)
            mn_navigationBar = navigationBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppear, let navigationBar = mn_navigationBar {
            navigationBar.superview?.bringSubviewToFront(navigationBar)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MNExtendViewController: MNNavigationBarDelegate {
    func shouldCreateLeftBarItem() -> UIView? { return nil }
    func shouldCreateRightBarItem() -> UIView? { return nil }
    func shouldDrawBackBarItem() -> Bool { !isRootViewController() }
    func finishCreateBarItem(_ navigationBar: MNNavigationBar) {}
    func rightBarItemTouchUpInside(_ rightBarItem: UIView) {}
    func leftBarItemTouchUpInside(_ leftBarItem: UIView) {
        if let _ = presentingViewController {
            dismiss(animated: UIApplication.shared.applicationState == .active, completion: nil)
        } else if let nav = navigationController {
            if nav.viewControllers.count > 1  {
                nav.popViewController(animated: UIApplication.shared.applicationState == .active)
            }
        }
    }
}

extension UIViewController {
    // 为所有控制器添加导航条计算属性
    @objc var navigationBar: MNNavigationBar! {
        if let viewController = self.root as? MNExtendViewController, let bar = viewController.mn_navigationBar { return bar }
        return nil
    }
}
