// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class InputField: UIView {
    
    // MARK: - Public Properties
    public private(set) var textField: UITextField!
    
    public var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    public var labelText: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    public var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    // MARK: - Private Properties
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var leftIconView: UIImageView?
    private var rightToggleButton: UIButton?
    
    private let isSecure: Bool
    private let hasLeftIcon: Bool
    
    // MARK: - Initialization
    public init(labelText: String,
                placeholder: String,
                isSecure: Bool = false,
                hasLeftIcon: Bool = false) {
        self.isSecure = isSecure
        self.hasLeftIcon = hasLeftIcon
        
        super.init(frame: .zero)
        
        self.titleLabel.text = labelText
        
        setupTextField(placeholder: placeholder)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupTextField(placeholder: String) {
        textField = UITextField()
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .label
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textFieldContainer)
        
        textFieldContainer.addSubview(textField)
        
        var constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textFieldContainer.heightAnchor.constraint(equalToConstant: 52)
        ]
        
        if hasLeftIcon {
            let iconView = UIImageView()
            iconView.image = UIImage(named: "LockPicture")
            iconView.tintColor = .secondaryLabel
            iconView.contentMode = .scaleAspectFit
            iconView.translatesAutoresizingMaskIntoConstraints = false
            
            textFieldContainer.addSubview(iconView)
            leftIconView = iconView
            
            constraints.append(contentsOf: [
                iconView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 16),
                iconView.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
                iconView.widthAnchor.constraint(equalToConstant: 20),
                iconView.heightAnchor.constraint(equalToConstant: 20),
                
                textField.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12)
            ])
        } else {
            constraints.append(
                textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 16)
            )
        }
        
        if isSecure {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            button.tintColor = .secondaryLabel
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(toggleSecureEntry), for: .touchUpInside)
            
            textFieldContainer.addSubview(button)
            rightToggleButton = button
            
            constraints.append(contentsOf: [
                button.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -16),
                button.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
                button.widthAnchor.constraint(equalToConstant: 24),
                button.heightAnchor.constraint(equalToConstant: 24),
                
                textField.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -12)
            ])
        } else {
            constraints.append(
                textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -16)
            )
        }
        
        constraints.append(
            textField.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor)
        )
        
        NSLayoutConstraint.activate(constraints)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Actions
    
    @objc private func toggleSecureEntry() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        rightToggleButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
