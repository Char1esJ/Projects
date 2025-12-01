//
//  CountriesCell.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

class CountriesCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "GeorgianFlag")
        return imageView
    }()
    
    private let countryName = UILabel.make(text: "Georgia", fontSize: 15, weight: .light, color: .black)
    
    private let nextBttnImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "NextBttnIcon")
        return imageView
    }()
    
    private let imageViewContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        contentView.addSubview(flagImage)
        contentView.addSubview(countryName)
        contentView.addSubview(nextBttnImage)
        contentView.layer.cornerRadius = 25
        contentView.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            flagImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            flagImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            flagImage.heightAnchor.constraint(equalToConstant: 30 ),
            flagImage.widthAnchor.constraint(equalToConstant: 30),
            
            nextBttnImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            nextBttnImage.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            
            countryName.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            countryName.trailingAnchor.constraint(equalTo: nextBttnImage.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(with model: Country) {
        if let url = URL(string: model.flags.png) {
            flagImage.load(url: url)
        }
        countryName.text = model.name.common
    }
}
