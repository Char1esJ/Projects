//
//  ProfileView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class ProfileView: UIView {
    // MARK: - Properties
    
    private var profileIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileIcon")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(profileIcon)
        
        NSLayoutConstraint.activate([
            profileIcon.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            profileIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileIcon.heightAnchor.constraint(equalToConstant: 128),
            profileIcon.widthAnchor.constraint(equalToConstant: 134),
        ])
    }

}

