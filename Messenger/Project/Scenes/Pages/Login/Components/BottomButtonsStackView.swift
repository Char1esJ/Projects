//
//  bottomButtonsStackView.swift
//  Project
//
//  Created by Kristine on 16.11.25.
//

import UIKit
import UIComponents

class BottomButtonsStackView: UIStackView {
    
    var onGoogleButtonTapped: (() -> Void)?
    var onSubmitLoginTapped: (() -> Void)?
    
    private let continueWithGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("auth.google.button".localized, for: .normal)
        button.setTitleColor( UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.54),for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto", size: 20)
        button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.17
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.setImage(UIImage(named: "GoogleLogo")?.withRenderingMode(.alwaysOriginal),for: .normal)
        
        var config = UIButton.Configuration.filled()
            config.title = "auth.google.button".localized
            config.image = UIImage(named: "GoogleLogo")?.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 12 
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            config.baseBackgroundColor = .white
            config.baseForegroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.54)
           
            
            button.configuration = config
        return button
    }()
    
    private let authButton = AuthButton(label: "auth.login.button".localized)
    
    private func createVerticalSpace(_ height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        alignment = .fill
        
        setUI()
        setupActions()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addArrangedSubview(continueWithGoogleButton)
        addArrangedSubview(createVerticalSpace(16))
        addArrangedSubview(authButton)
        
        setConstraints()
    }
  
    private func setConstraints() {
        NSLayoutConstraint.activate([
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 64),
            authButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func setupActions() {
        continueWithGoogleButton.addAction(
            UIAction { [weak self] _ in
                self?.onGoogleButtonTapped?()
            },
            for: .touchUpInside
        )
        
        authButton.addAction(
            UIAction { [weak self] _ in
                self?.onSubmitLoginTapped?()
            },
            for: .touchUpInside
        )
    }
    
    func updateLanguage(googleLabel: String, loginLabel: String) {
        continueWithGoogleButton.setTitle(googleLabel, for: .normal)
        authButton.updateLanguage(label: loginLabel)
    }

}
