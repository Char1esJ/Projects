//
//  TopView.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

class TopView: UIView {
    // MARK: - Properties
    
    private let countryName = UILabel.make(text: "Georgia", fontSize: 17, weight: .bold, color: .black)
    
    private let flagContainerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "GeorgianFlag")
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
        addSubview(countryName)
        addSubview(flagContainerView)
        flagContainerView.addSubview(flagImage)
        
        NSLayoutConstraint.activate([
            countryName.topAnchor.constraint(equalTo: topAnchor),
            countryName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            flagContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            flagContainerView.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 30),
            flagContainerView.widthAnchor.constraint(equalToConstant: 343),
            flagContainerView.heightAnchor.constraint(equalToConstant: 228),
            flagContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            flagImage.topAnchor.constraint(equalTo: flagContainerView.topAnchor),
            flagImage.leadingAnchor.constraint(equalTo: flagContainerView.leadingAnchor),
            flagImage.trailingAnchor.constraint(equalTo: flagContainerView.trailingAnchor),
            flagImage.bottomAnchor.constraint(equalTo: flagContainerView.bottomAnchor)
        ])
    }
    
    func configure(title: String, image: String) {
        if let url = URL(string: image) {
            flagImage.load(url: url)
        }
        countryName.text = title
    }
}
