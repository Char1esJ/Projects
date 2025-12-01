//
//  inputContainerView.swift
//  Project
//
//  Created by kv on 17.11.25.
//

import UIKit

class inputContainerView: UIView {
    
    private let inputField = UITextField()
    private let sendButton = UIButton(type: .system)
    
    var onSendMessage: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setInputField()
        setSendButton()
        setConstraints()
    }
    
    private func setInputField() {
        inputField.placeholder = "Reply to everyone..."
        inputField.backgroundColor = UIColor.systemGray5
        inputField.layer.cornerRadius = 22
        inputField.setLeftPaddingPoints(14)
        
        addSubview(inputField)
        inputField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setSendButton() {
        sendButton.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysOriginal), for: .normal)
        sendButton.backgroundColor = UIColor(red: 81/255, green: 89/255,blue: 246/255,alpha: 1)
        sendButton.layer.cornerRadius = 22
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inputField.centerYAnchor.constraint(equalTo: centerYAnchor),
            inputField.heightAnchor.constraint(equalToConstant: 44),
            
            sendButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 44),
            sendButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func sendPressed() {
        guard let text = inputField.text, !text.isEmpty else { return }
        
        onSendMessage?(text)
        inputField.text = ""
    }
    
}
