//
//  PopularMovieCell.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class PopularMovieCell: UITableViewCell {
    // MARK: - Properties    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel = UILabel.make(fontSize: 15, weight: .bold, color: UIColor(named: "TitleColor"))
    
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "StarImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel = UILabel.make(fontSize: 14, weight: .medium, color: .systemGray)
    
    private let genresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ClockImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var durationLabel = UILabel.make(fontSize: 14, weight: .regular, color: .systemGray)
    
    private let posterPageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PosterPageImage")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(genresStackView)
        contentView.addSubview(clockImageView)
        contentView.addSubview(durationLabel)
        contentView.addSubview(posterPageImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterImageView.widthAnchor.constraint(equalToConstant: 85),
            posterImageView.heightAnchor.constraint(equalToConstant: 128),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: posterPageImageView.leadingAnchor, constant: -12),
            
            starImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            genresStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresStackView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 12),
            genresStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            genresStackView.heightAnchor.constraint(equalToConstant: 24),
            
            clockImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            clockImageView.topAnchor.constraint(equalTo: genresStackView.bottomAnchor, constant: 12),
            clockImageView.widthAnchor.constraint(equalToConstant: 16),
            clockImageView.heightAnchor.constraint(equalToConstant: 16),
            
            durationLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 4),
            durationLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
            
            posterPageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            posterPageImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 5),
            posterPageImageView.widthAnchor.constraint(equalToConstant: 40),
            posterPageImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func createGenreBtn(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 9, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.53, green: 0.64, blue: 0.91, alpha: 1.00), for: .normal)
        button.backgroundColor = UIColor(red: 0.86, green: 0.89, blue: 1.00, alpha: 1.00)
        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }
        
    func configure(with movie: MovieModel) {
        posterImageView.image = movie.poster
        titleLabel.text = movie.title
        ratingLabel.text = movie.rating
        durationLabel.text = movie.duration
        
        genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let maxGenres = min(3, movie.genres.count)
        for i in 0..<maxGenres {
            let genreButton = createGenreBtn(text: movie.genres[i])
            genresStackView.addArrangedSubview(genreButton)
        }
    }
}
