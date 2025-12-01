//
//  HeaderBarView.swift
//  Project
//
//  Created by kv on 17.11.25.
//

import UIKit

class HeaderBarView: UIView {
    
    private let titleLabel = UILabel()
    private let settingsButton = UIButton(type: .system)
    
    var onSettingsButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.systemGroupedBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setTitle()
        setButton()
    }
    
    private func setTitle() {
        titleLabel.text = "Wazaaaaap"
        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 25) ?? .systemFont(ofSize: 48, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.98, alpha: 1.0)

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func setButton() {
        let image = UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal)
        settingsButton.setImage(image, for: .normal)
        settingsButton.addAction(
            UIAction { [weak self] _ in
                self?.onSettingsButtonTapped?()
            },
            for: .touchUpInside
        )

        addSubview(settingsButton)
        bringSubviewToFront(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            settingsButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
