//
//  Profile.swift
//  UIComponents
//
//  Created by kv on 15.11.25.
//

import UIKit

public class PasswordField: UIStackView {
    
    private let fieldLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter", size: 12)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let textField: UITextField = {
       let textfield = UITextField()
        textfield.font = UIFont(name: "Inter", size: 15)
        textfield.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        
        textfield.layer.cornerRadius = 8
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.systemGray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 52))
        let imageView = UIImageView(frame: CGRect(x: 12, y: 16, width: 20, height: 20))
        imageView.image = UIImage(named: "LockPicture")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        leftView.addSubview(imageView)
        
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 52))
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        button.tintColor = .systemGray
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 52)
        button.tag = 999 
        button.addTarget(textfield, action: #selector(UITextField.togglePasswordVisibility), for: .touchUpInside)
        rightView.addSubview(button)

        textfield.rightView = rightView
        textfield.rightViewMode = .always
        
        return textfield
    }()
    
    public init(label: String, placeholder: String) {
        
        fieldLabel.text = label
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0),
                .font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
        )

        super.init(frame: .zero)

        axis = .vertical
        spacing = 8
        distribution = .fill
        
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        addArrangedSubview(fieldLabel)
        addArrangedSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateLanguage(label: String, placeholder: String? = nil) {
        fieldLabel.text = label
        
        if let placeholder = placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor: UIColor.systemGray,
                    .font: UIFont.systemFont(ofSize: 15, weight: .regular)
                ]
            )
        }
    }
}
