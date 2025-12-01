//
//  LanguageToggleViewDelegate.swift
//  UIComponents
//
//  Created by Edgar on 16.11.25.
//


import UIKit

public protocol LanguageToggleViewDelegate: AnyObject {
    func languageToggleViewDidChangeLanguage(_ view: LanguageToggleView)
}

public class LanguageToggleView: UIView {
    
    // MARK: - Properties
    public weak var delegate: LanguageToggleViewDelegate?
    
    private let georgianButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ქართული", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("English", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        addSubview(stackView)
        stackView.addArrangedSubview(georgianButton)
        stackView.addArrangedSubview(englishButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            stackView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        georgianButton.addTarget(self, action: #selector(georgianButtonTapped), for: .touchUpInside)
        englishButton.addTarget(self, action: #selector(englishButtonTapped), for: .touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Actions
    @objc private func georgianButtonTapped() {
        delegate?.languageToggleViewDidChangeLanguage(self)
    }
    
    @objc private func englishButtonTapped() {
        delegate?.languageToggleViewDidChangeLanguage(self)
    }
    
    // MARK: - Public Methods
    public func setLanguage(isGeorgian: Bool) {
        let primaryColor = UIColor(red: 67/255, green: 97/255, blue: 238/255, alpha: 1.0)
        
        if isGeorgian {
            georgianButton.backgroundColor = primaryColor
            georgianButton.setTitleColor(.white, for: .normal)
            englishButton.backgroundColor = .clear
            englishButton.setTitleColor(.secondaryLabel, for: .normal)
        } else {
            englishButton.backgroundColor = primaryColor
            englishButton.setTitleColor(.white, for: .normal)
            georgianButton.backgroundColor = .clear
            georgianButton.setTitleColor(.secondaryLabel, for: .normal)
        }
    }
}
