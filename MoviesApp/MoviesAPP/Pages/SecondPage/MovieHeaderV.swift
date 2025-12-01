//
//  MovieHeaderV.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class MovieHeaderV: UIView {
    // MARK: - Properties
    private lazy var titleLabel = UILabel.make(fontSize: 28, weight: .bold, color: UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00), numberOfLines: 2)
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "StarImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel = UILabel.make(fontSize: 14, weight: .medium, color: .systemGray)
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView() {
        addSubview(titleLabel)
        addSubview(starImageView)
        addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            starImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            starImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 15),
            starImageView.heightAnchor.constraint(equalToConstant: 15),
            starImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor)
        ])
    }
        
    func configure(title: String, rating: String) {
        titleLabel.text = title
        ratingLabel.text = rating
    }
}
