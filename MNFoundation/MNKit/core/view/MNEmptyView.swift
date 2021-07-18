//
//  MNEmptyView.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/18.
//  空数据占位图

import UIKit

@objc protocol MNEmptyViewDelegate: NSObjectProtocol {
    @objc optional func dataEmptyViewButtonTouchUpInside(_ emptyView: MNEmptyView) -> Void
}

class MNEmptyView: UIView {
    // 事件类型
    enum Event: UInt {
        case load // 加载数据
        case reload // 重载数据
        case custom // 自定义事件
    }
    // 事件类型
    var type: MNEmptyView.Event = .reload
    // 交互代理
    weak var delegate: MNEmptyViewDelegate?
    // 图片
    var image: UIImage?
    // 按钮标题
    var title: String?
    // 文字提示
    var text: String?
    // 文字颜色
    var textColor: UIColor?
    // 按钮字体颜色
    var titleColor: UIColor?
    // 内容视图
    private var contentView: UIView!
    // 图片显示
    private var imageView: UIImageView!
    // 文字显示
    private var textLabel: UILabel!
    // 按钮
    private var button: UIButton!
    // 边缘
    static let Margin: CGFloat = 25.0
    // 动画时间
    static let AnimationDuration: TimeInterval = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        contentView = UIView(frame: bounds)
        contentView.backgroundColor = UIColor.white
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 17.0)
        textLabel.numberOfLines = 0
        textLabel.clipsToBounds = true
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        
        button = UIButton(type: .custom)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // 刷新数据
        textLabel.text = text
        imageView.image = image
        textLabel.textColor = textColor
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .highlighted)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        button.layer.borderColor = titleColor?.cgColor
        
        let max = max(max(contentView.width_mn, contentView.height_mn) - MNEmptyView.Margin*2.0, 0.0)
        
        // 约束子视图
        imageView.size_mn = image != nil ? CGSize(width: 135.0, height: 135.0) : CGSize.zero
        textLabel.size_mn = String.size(text, textLabel.font, CGSize(width: max, height: CGFloat.greatestFiniteMagnitude))
        if let t = title {
            var size = (t as NSString).size(withAttributes: [.font:button.titleLabel!.font!])
            size.width += 30.0
            size.height = 35.0
            button.size_mn = size
        } else {
            button.size_mn = CGSize.zero
        }
        
        var height: CGFloat = imageView.height_mn
        height += (imageView.height_mn > 0.0 && textLabel.height_mn > 0.0 ? MNEmptyView.Margin : 0.0)
        height += textLabel.height_mn
        height += (textLabel.height_mn > 0.0 && button.height_mn > 0.0 ? MNEmptyView.Margin : 0.0)
        height += button.height_mn
        
        let y: CGFloat = (contentView.height_mn - height)/2.0
        
        imageView.top_mn = y
        textLabel.top_mn = imageView.bottom_mn + (imageView.height_mn > 0.0 && textLabel.height_mn > 0.0 ? MNEmptyView.Margin : 0.0)
        button.top_mn = textLabel.bottom_mn + (textLabel.height_mn > 0.0 && button.height_mn > 0.0 ? MNEmptyView.Margin : 0.0)
        imageView.centerX_mn = contentView.width_mn/2.0
        textLabel.centerX_mn = contentView.width_mn/2.0
        button.centerX_mn = contentView.width_mn/2.0
    }
    
    func show() -> Void {
        guard alpha != 1.0 else { return }
        UIView.animate(withDuration: MNEmptyView.AnimationDuration) {
            self.alpha = 1.0
        }
    }
    
    func dismiss() -> Void {
        guard alpha != 0.0 else { return }
        UIView.animate(withDuration: MNEmptyView.AnimationDuration) {
            self.alpha = 0.0
        }
    }
    
    @objc func buttonTouchUpInside(_ sender: UIButton) -> Void {
        delegate?.dataEmptyViewButtonTouchUpInside?(self)
    }
}
