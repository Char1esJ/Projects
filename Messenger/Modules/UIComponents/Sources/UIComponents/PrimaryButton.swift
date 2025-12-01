//
//  PrimaryButton.swift
//  UIComponents
//
//  Created by Edgar on 16.11.25.
//


import UIKit

public class PrimaryButton: UIButton {
    
    // MARK: - Properties
    public var title: String {
        get { title(for: .normal) ?? "" }
        set { setTitle(newValue, for: .normal) }
    }
    
    // MARK: - Initialization
    public init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton() {
        backgroundColor = UIColor(red: 67/255, green: 97/255, blue: 238/255, alpha: 1.0)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Roboto", size: 20)
        layer.cornerRadius = 12
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    // MARK: - Override
    public override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.8 : 1.0
        }
    }
}
