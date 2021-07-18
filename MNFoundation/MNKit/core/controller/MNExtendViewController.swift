//
//  MNExtendViewController.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/18.
//

import UIKit

class MNExtendViewController: MNBaseViewController {
    // 导航条高度
    var navigationBarHeight: CGFloat { MN_NAV_BAR_HEIGHT }
    // 导航条
    fileprivate var mn_navigationBar: MNNavigationBar!
    // 外界获取导航条
    override var navigationBar: MNNavigationBar! { mn_navigationBar }

    override func initialized() {
        super.initialized()
        if isChildViewController() {
            edges = .none
        } else if isRootViewController() {
            edges = .all
        } else {
            edges = .top
        }
    }
    
    override func createView() {
        super.createView()
        if edges.contains(.top) {
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: self.navigationBarHeight + MN_STATUS_BAR_HEIGHT, left: 0.0, bottom: 0.0, right: 0.0))
            let navigationBar = MNNavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: view.width_mn, height: self.navigationBarHeight + MN_STATUS_BAR_HEIGHT))
            navigationBar.delegate = self
            navigationBar.createItems()
            navigationBar.title = title
            view.addSubview(navigationBar)
            self.mn_navigationBar = navigationBar
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
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    @objc var navigationBar: MNNavigationBar! {
        if let viewController = self as? MNExtendViewController, let v = viewController.mn_navigationBar { return viewController.mn_navigationBar }
        return nil
    }
}
