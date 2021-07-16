//
//  MNConst.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit
import Foundation
import CoreGraphics

// 架包名
public let MN_KIT_NAME: String = "MNKit"
// iconfont字体文件名
public let MN_ICON_NAME: String = "iconfont"
// iconfont字体文件夹名
public let MN_ICON_DIR: String = "font"

// 是否是低分辨率屏
public let MN_IS_LOW_SCALE: Bool = UIScreen.main.scale < 3.0
// 统一分割线高度
public let MN_SEPARATOR_HEIGHT: CGFloat = (MN_IS_LOW_SCALE ? 1.0 : 0.5)

// 状态栏高度
public let MN_STATUS_BAR_HEIGHT: CGFloat = UIApplication.StatusBarHeight
// 导航栏高度
public let MN_NAV_BAR_HEIGHT: CGFloat = UINavigationBar.Height
// 顶部栏总高度
public let MN_TOP_BAR_HEIGHT: CGFloat = (MN_STATUS_BAR_HEIGHT + MN_NAV_BAR_HEIGHT)
// 标签栏总高度
public let MN_TAB_BAR_HEIGHT: CGFloat = UITabBar.Height





