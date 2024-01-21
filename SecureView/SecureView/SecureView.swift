//
//  SecureView.swift
//  SecureView
//
//  Created by Şükrü Can Avcı on 21.01.2024.
//

import UIKit

final class SecureView: UIView {
    
    public var secureMode = true {
        didSet {
            textField.isSecureTextEntry = secureMode
        }
    }
    
    private var contentView: UIView?
    private let textField = UITextField()
    
    private let detector = SecureViewDetector()
    private lazy var secureContentFrame: UIView? = try? detector.getSecureFrame(from: textField)
    
    public init(contentView: UIView? = nil) {
        self.contentView = contentView
        super.init(frame: .zero)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false
        
        guard let secureContentFrame else { return }
        
        addSubview(secureContentFrame)
        secureContentFrame.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            secureContentFrame.leadingAnchor.constraint(equalTo: leadingAnchor),
            secureContentFrame.trailingAnchor.constraint(equalTo: trailingAnchor),
            secureContentFrame.topAnchor.constraint(equalTo: topAnchor),
            secureContentFrame.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        guard let contentView else { return }
        setupView(contentView: contentView)
        
        DispatchQueue.main.async { [weak self] in
            self?.secureMode = true
        }
    }

    public func setupView(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView
        
        guard let secureContentFrame else { return }
        
        secureContentFrame.addSubview(contentView)
        secureContentFrame.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: secureContentFrame.bottomAnchor)
        bottomConstraint.priority = .required - 1
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: secureContentFrame.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: secureContentFrame.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: secureContentFrame.topAnchor),
            bottomConstraint
        ])
    }
}
