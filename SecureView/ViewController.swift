//
//  ViewController.swift
//  SecureView
//
//  Created by Şükrü Can Avcı on 21.01.2024.
//

import UIKit

class ViewController: UIViewController {

    // MARK: UI
    private lazy var secureModeSwitch: UISwitch = {
        let swtch = UISwitch()
        swtch.translatesAutoresizingMaskIntoConstraints = false
        swtch.addTarget(self, action: #selector(secureModeValueChange), for: .valueChanged)
        return swtch
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "casper"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var secureView: SecureView = {
        let view = SecureView(contentView: imageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    // MARK: Setups
    private func setupViews() {
        view.addSubview(secureModeSwitch)
        view.addSubview(secureView)
        
        NSLayoutConstraint.activate([
            secureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            secureView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            secureView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            secureView.heightAnchor.constraint(equalToConstant: 200),
            
            secureModeSwitch.topAnchor.constraint(equalTo: secureView.bottomAnchor, constant: 50),
            secureModeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: Actions
    @objc private func secureModeValueChange(_ swtch: UISwitch) {
        secureView.secureMode = swtch.isOn
    }
}

