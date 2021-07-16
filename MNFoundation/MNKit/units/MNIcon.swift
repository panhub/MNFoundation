//
//  MNIcon.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import UIKit
import Foundation

public class MNIcon: NSObject {
    // 所在bundle名
    public static let bundle: String = MN_KIT_NAME
    // 字体文件名
    public static let name: String = MN_ICON_NAME
    // 字体文件所在文件夹名
    public static let directory: String = MN_ICON_DIR
    // 定义iconfont字体unicode
    enum Name: String {
        case back = "e66f"
        case more = "e879"
        case close = "e638"
        case search = "e516"
        case refresh = "e62f"
        case share = "e60f" //"e6af"
    }
}
