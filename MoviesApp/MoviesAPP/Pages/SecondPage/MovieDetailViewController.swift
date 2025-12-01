//
//  MovieDetailViewController.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MovieDetailViewModel
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView = MovieHeaderV()
    private let genresView = GenresV()
    private let infoView = MovieInfoV()
    private let descriptionView = DescriptionV()
    private let castView = CastV()
    
    // MARK: - Inits
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configure()
    }
    
    // MARK: - Methods
    private func setupViews() {
        view.backgroundColor = .black
        
        view.addSubview(mainImageView)
        view.addSubview(contentView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(genresView)
        contentView.addSubview(infoView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(castView)
        
        [headerView, genresView, infoView, descriptionView, castView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 280),
            
            contentView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genresView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            genresView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            genresView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            infoView.topAnchor.constraint(equalTo: genresView.bottomAnchor, constant: 20),
            infoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 24),
            descriptionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            castView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 32),
            castView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            castView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            castView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configure() {
        mainImageView.image = viewModel.posterImage
        headerView.configure(title: viewModel.title, rating: viewModel.rating)
        genresView.configure(genres: viewModel.genres)
        infoView.configure(duration: viewModel.duration, language: viewModel.language, rating: viewModel.pgRating)
        descriptionView.configure(description: viewModel.description)
        castView.configure(cast: viewModel.cast)
    }
}
