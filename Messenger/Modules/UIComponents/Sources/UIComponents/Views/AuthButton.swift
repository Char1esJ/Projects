//
//  Profile.swift
//  UIComponents
//
//  Created by kv on 16.11.25.
//

import UIKit

public class AuthButton: UIButton {

    public init(label: String) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 81/255, green: 89/255, blue: 246/255, alpha: 1.0)
        setTitle(label, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateLanguage(label: String) {
        setTitle(label, for: .normal)
    }
}
