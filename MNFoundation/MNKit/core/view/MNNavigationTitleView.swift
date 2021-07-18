//
//  MNNavBarTitleView.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/14.
//  导航条标题视图

import UIKit

class MNNavigationTitleView: UIView {
    
    let titleLabel = UILabel()
    
    var title: String? {
        set (text) {
            titleLabel.text = text
        }
        get { titleLabel.text }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.frame = bounds
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
