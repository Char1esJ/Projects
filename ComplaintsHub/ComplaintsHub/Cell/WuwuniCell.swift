//
//  WuwuniCell.swift
//  Assignment-N17
//
//  Created by Charles Janjgava on 10/15/25.
//

import UIKit

class WuwuniCell: UICollectionViewCell {
    // MARK: Properties
    private var cellView: UIView = {
        let view = UIView()
        let screenHeight = UIScreen.main.bounds.height
        view.clipsToBounds = true
        view.layer.cornerRadius = screenHeight * 0.02
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CellBackgroundColorImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var wuwuniImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RedIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var wuwuniTitleLabel: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Change assignment"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.029, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var wuwuniDescriptionLabel: UILabel = {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = "Who makes calculator all the time"
        label.font = UIFont.systemFont(ofSize: screenHeight * 0.016, weight: .medium)
        label.textColor = .gray
        label.alpha = 0.7
        label.textAlignment = .left
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func setupView() {
        configureBackgroundImage()
        configureContents()
    }
    
    private func configureBackgroundImage() {
        contentView.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(with wuwuni: WuwuniModel) {
        wuwuniImage.image = wuwuni.image
        wuwuniTitleLabel.text = wuwuni.titleLabel
        wuwuniDescriptionLabel.text = wuwuni.wuwuniLabel
    }
    
    private func configureContents() {
        contentView.addSubview(cellView)
        cellView.addSubview(wuwuniImage)
        cellView.addSubview(wuwuniTitleLabel)
        cellView.addSubview(wuwuniDescriptionLabel)
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            // Icon
            wuwuniImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            wuwuniImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            wuwuniImage.heightAnchor.constraint(equalTo: wuwuniImage.widthAnchor),
            wuwuniImage.heightAnchor.constraint(equalToConstant: screenHeight * 0.045),
            
            // Title Label
            wuwuniTitleLabel.topAnchor.constraint(equalTo: wuwuniImage.bottomAnchor, constant: 15),
            wuwuniTitleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            wuwuniTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            
            // Description Label
            wuwuniDescriptionLabel.topAnchor.constraint(equalTo: wuwuniTitleLabel.bottomAnchor, constant: 5),
            wuwuniDescriptionLabel.leadingAnchor.constraint(equalTo: wuwuniTitleLabel.leadingAnchor),
            wuwuniDescriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            wuwuniDescriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -3)
        ])
    }
}

#Preview {
    MainPageVC()
}
