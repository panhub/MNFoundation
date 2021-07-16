//
//  UIImage+MNIcon.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/15.
//

import UIKit
import Foundation

extension UIImage {
    static func icon(unicode name: MNIcon.Name, color: UIColor?, pix: CGFloat) -> UIImage? {
        guard let font = UIFont(name: MNIcon.name, size: pix*UIScreen.main.scale) else { return nil }
        let string = Int(name.rawValue, radix: 16).map { String(Unicode.Scalar($0)!) }
        UIGraphicsBeginImageContext(CGSize(width: pix*UIScreen.main.scale, height: pix*UIScreen.main.scale))
        (string! as NSString).draw(at: CGPoint.zero, withAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor:(color ?? UIColor.black)])
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        return UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
    }
}
