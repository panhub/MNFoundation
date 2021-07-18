//
//  ViewController.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//

import UIKit

class ViewController: MNExtendViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 28.0, height: 28.0))
        imageView.center = contentView.bounds_center
        imageView.image = UIImage.icon(unicode: MNIcon.Name.close, color: UIColor.red, pix: 100.0)
        contentView.addSubview(imageView)
    }
}

